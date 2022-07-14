# Clexp

Clexp is a accessory tool to replace text in the clipboard on macOS.

### Features

- replace text in the clipboard when copied

## Installation

Install using [Mint](https://github.com/yonaskolb/Mint).
```sh
$ mint install novr/Clexp
```

## Usage

### Register the text you want to auto-replace using the settings

Tap the icon on the status bar and call Preferences from the menu

<p align=center><img src=./Assets/Settings.png></p>

| Input | from | replace to | Output |
|:--|:--|:--|---|
| 123 | ^(\d+) | [$1] | [123] |
