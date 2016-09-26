# Turmeric

## 開発環境構築

Xcodeをインストールした上で、Homebrewで必要なツール類を入れる

```
brew install carthage mergepbx
```

リポジトリをクローンして、Carthageで外部ライブラリをインストールする

```
git clone https://github.com/pepabo-mobile-app-training/turmeric.git
cd turmeric
carthage update --platform iOS
```

`Turmeric.xcodeproj`をXcodeで開き、シミュレーターでアプリが動けば準備完了
