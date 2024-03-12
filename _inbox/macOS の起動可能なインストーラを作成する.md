https://support.apple.com/mac/startup
-2003F

## wifi
5fctek3rhar66

## Apple ID
ishigaki0515naoki@gmail.com
@345_5
lOg@93780

## 起動ディスクの件
```sh
csrutil disable
spctl --master-disable
```

## Mac Serial
C02DQ6FGMD6R

## ターゲットディスクモードで起動する
on + T


## macOS の起動可能なインストーラを作成する
https://support.apple.com/ja-jp/101578


```sh
sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume /Volumes/usb_macOS

sudo "/Applications/Install macOS Sonoma.app/Contents/Resources/createinstallmedia" --volume /Volumes/usb_macOS

# 実施したところ、以下のエラーが発生した
# sudo /Applications/Install\ macOS\ Sonoma.app/Contents/Resources/createinstallmedia --volume /Volumes/usb_macOS
# Password:
# sudo: /Applications/Install macOS Sonoma.app/Contents/Resources/createinstallmedia: command not found
```


