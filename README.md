# Automatical-LaTeX-Typesetter
LaTeXを用いて組版を自動化する

## 概要

RubyとLaTeX（それとpandoc）を用いて文芸誌の組版を自動化するシステムです。

## 機能

- Markdownファイルから自動的にLaTeXファイルを生成
- 複数のMarkdownファイルをまとめてPDFに出力
- 日本語対応の組版システム

## ディレクトリ構成

```
.
├── input/          # Markdownファイルを配置するディレクトリ
├── TeXfile/        # 変換されたLaTeXファイルが保存されるディレクトリ
├── output/         # 生成されたPDFファイルが出力されるディレクトリ
├── master.tex      # 組版形式を指定するマスターLaTeXファイル
├── typesetter.rb   # 自動化スクリプト
└── README.md       # このファイル
```

## 必要な環境

- Ruby 3.x
- pandoc
- LuaLaTeX (TeXLive等)

## インストール

### Ubuntu/Debian系

```bash
# pandocのインストール
sudo apt-get install pandoc

# LaTeXのインストール
sudo apt-get install texlive-full texlive-luatex texlive-lang-japanese
```

### macOS (Homebrew使用)

```bash
# pandocのインストール
brew install pandoc

# MacTeX（LuaLaTeX含む）のインストール
brew install --cask mactex
```

## 使い方

### 1. Markdownファイルを準備

`input/` ディレクトリに組版したいMarkdownファイルを配置します。

```bash
# 例：サンプルファイルがあります
input/sample.md
```

### 2. スクリプトを実行

```bash
ruby typesetter.rb
```

このスクリプトは以下の処理を自動で行います：

1. `input/` ディレクトリ内のすべての `.md` ファイルを検索
2. pandocを使用して各Markdownファイルを LaTeX形式に変換
3. 変換されたLaTeXファイルを `TeXfile/` ディレクトリに保存
4. `master.tex` をコンパイルしてPDFを生成
5. 生成されたPDFを `output/` ディレクトリに出力

### 3. 出力ファイルを確認

`output/master.pdf` に最終的な組版結果が出力されます。

## カスタマイズ

### master.texの編集

組版のスタイル、フォント、レイアウトなどを変更したい場合は、`master.tex` を編集してください。

```latex
% 例：フォントサイズの変更
\documentclass[a4paper,10pt]{ltjsarticle}

% 例：余白の調整
\usepackage[top=30mm,bottom=30mm,left=25mm,right=25mm]{geometry}
```

### 複数ファイルの読み込み

複数のMarkdownファイルを変換した場合、`master.tex` に `\input` コマンドを追加します：

```latex
\input{TeXfile/chapter1.tex}
\input{TeXfile/chapter2.tex}
\input{TeXfile/chapter3.tex}
```

## ライセンス

MIT License

## 貢献

プルリクエストや Issues は大歓迎です！
