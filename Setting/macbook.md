# settings
## General
- ON: Automatically hide and show the menu bar
## keyboard
### keyboard
- Key Repeat : Fast
- Delay Until Repeat : Short
### Show keyboard and emoji viewers in menu bar
- ON
- edit emoji & symbols
  - custmize list...
  - add Technique symbols
  - add `⌃⌘⌥⇧` to favorit(select and double click to use)
- edit user dictionaly
  - add `⌃⌘⌥⇧` to favorit
### shortcuts
#### Mission Control
- switch to Desctop 1to10
#### Keyboard
- Move focus to the Dock ⌥⇧⌘D
- Move focus to active or next window ⌥⇧⌘N
- Move focus to next window ⌥⌘N
- Move focus to menu bar ⌥⌘/
- Move focus to status menus ⌥⇧⌘_

#### Spotlight
- Show Spotlight search ⌃Space
- Show Finder search window off
##### App Shortcuts
- Minimize ⌥⌘M
- Zoom ⌥⌘⇧Z
### input sources
- google Japanese input
- off: kotoeri
## Mission Control
- off: Automatically rearrange Spaces based on most recent use
- Dashboard: As Overlay
## Dock
- on: Automatically hide and show the dock
## User
### Login Items
- iTerm
- Clipy
- ChatWork
- Spectacle
- Atom
- Chrome
- Slack
## Accessibility
### Display
- on: Reduce motion
### Mouse & Trackpad
#### Enabe Mouse Keys
- ... not yet, but maybe i will need it.
#### Trackpad Options
- on: Enable dragging : three finger drag

# status bar
## battery
- show usage
## time
- show month day date time

# dashboard
- delete and add calender (to initialize)

# install
- Clipy
  - Main: ⇧⌘V
- atom
- spectacle
- amethyst
- SequelPro
- Slack
- EverNote
  - New Chat ⌥⇧⌘C  #it's conflict with ⌥⇧⌘N
- ghq

## brew
```
brew install peco #Simplistic interactive filtering tool
brew cask install atom
brew cask install visual-studio-code
brew cask install amethyst
brew install jq # => use like this : curl localhost:8080/api/json | jq .
brew cask install eqmac # イコライザー
brew cask install postman
```

## find all components
```
mdfind -name "kindle"
```

# screen shot
```sh
$ defaults write com.apple.screencapture location ~/Downloads/screenshot/
$ defaults write com.apple.screencapture name "ScreenShot"
$ killall SystemUIServer
```
