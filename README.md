# Dotto

[![CI](https://github.com/fun-dotto/app/actions/workflows/ci.yml/badge.svg)](https://github.com/fun-dotto/app/actions/workflows/ci.yml)

## ようこそ、Dotto 開発チームへ！

[Dotto Wiki](https://app.notion.com/p/fun-dotto/30428560ac7980778136e29902746cae?v=30428560ac79801a92ef000c7ca1f6a3)

## セットアップ

### 事前にやっておくこと

- macOSを最新バージョンにアップデート
- [Homebrewをインストール](https://app.notion.com/p/fun-dotto/30428560ac79801095f2e00033d9a132)
- [最新バージョンのXcodeをインストール](https://app.notion.com/p/fun-dotto/30428560ac79807797c3d6f62d1d393d)
- [miseをインストール](https://app.notion.com/p/fun-dotto/30428560ac79804caaf8ed3a3ad30cb5)

### リポジトリをクローン

```zsh
git clone git@github.com:fun-dotto/app.git dotto-app
cd dotto-app
```

### mise でプロジェクトを信頼

```zsh
mise trust
```

### ツールをインストール

```zsh
mise install
```

### Google Cloud & Firebase を認証

```zsh
gcloud auth login
firebase login
```

### 色々セットアップ

```zsh
mise run bootstrap
```

### ビルドして起動する

```zsh
mise run run:app
```

&copy; 2026 Dotto
