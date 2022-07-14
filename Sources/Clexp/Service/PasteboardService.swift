//
//  PasteboardService.swift
//  
//
//  Created by 古宮 伸久 on 2022/07/12.
//

import AppKit
import Combine
import SwiftUI

final class PasteboardService {
    fileprivate var cachedChangeCount = CurrentValueSubject<Int, Never>(0)
    private var cancellable: AnyCancellable?

    func startMonitoring() {
        cancellable = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .map { _ in NSPasteboard.general.changeCount }
            .withLatestFrom(cachedChangeCount) { ($0, $1) }
            .filter { $0 != $1 }
            .sink(receiveValue: { [weak self] changeCount, _ in
                self?.cachedChangeCount.send(changeCount)
                self?.replace()
            })
    }

    private func replace() {
        guard !Environment.current.isActive else { return }

        let board = NSPasteboard.general

        guard let availableType = board.availableType(from: [.string, .rtf]) else { return }

        let value: String?
        switch availableType {
        case .string:
            value = board.string(forType: .string)

        case .rtf:
            value = board.string(forType: .rtf)

        default:
            value = nil
        }

        guard let value = value else { return }
        guard let from = Environment.current.defaults.from, !from.isEmpty,
        let to = Environment.current.defaults.with, !to.isEmpty else { return }

        let newValue = value.replacingOccurrences(of: from, with: to, options: .regularExpression, range: nil)

        if value != newValue {
            cachedChange()
            board.declareTypes([.string], owner: nil)
            board.setString(newValue, forType: .string)
        }
    }

    private func cachedChange() {
        cachedChangeCount.send(cachedChangeCount.value + 1)
    }
}

extension Publisher {
  func withLatestFrom<Other: Publisher, Result>(_ other: Other,
                                                    resultSelector: @escaping (Output, Other.Output) -> Result)
      -> AnyPublisher<Result, Failure>
      where Other.Failure == Failure {
          let upstream = share()

          return other
              .map { second in upstream.map { resultSelector($0, second) } }
              .switchToLatest()
              .zip(upstream) // `zip`ping and discarding `\.1` allows for
                                        // upstream completions to be projected down immediately.
              .map(\.0)
              .eraseToAnyPublisher()
      }
}
