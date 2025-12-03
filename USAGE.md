# 使い方ガイド

## 基本的なワークフロー

### ステップ1: Markdownファイルの作成

`input/` ディレクトリに、組版したい内容をMarkdown形式で作成します。

```markdown
# タイトル

## 第一章

本文がここに入ります。

## 第二章

続きの内容...
```

### ステップ2: 自動変換の実行

以下のいずれかの方法で実行します：

```bash
# 方法1: Makefileを使用（推奨）
make

# 方法2: Rubyスクリプトを直接実行
ruby typesetter.rb

# 方法3: 実行可能スクリプトとして実行
./typesetter.rb
```

### ステップ3: 結果の確認

- 変換されたLaTeXファイル: `TeXfile/` ディレクトリ
- 最終的なPDF: `output/master.pdf`

## 複数ファイルの処理

複数のMarkdownファイルを処理する場合：

1. すべてのMarkdownファイルを `input/` に配置
2. `master.tex` を編集して、必要な `\input` コマンドを追加：

```latex
\input{TeXfile/chapter1.tex}
\input{TeXfile/chapter2.tex}
\input{TeXfile/chapter3.tex}
```

3. 通常通り `make` を実行

## カスタマイズ

### 組版スタイルの変更

`master.tex` を編集することで、以下をカスタマイズできます：

- フォントサイズ
- ページサイズ
- 余白
- ヘッダー/フッター
- 章や節の書式

例：

```latex
% フォントサイズを10ptに変更
\documentclass[a4paper,10pt]{ltjsarticle}

% 余白を変更
\usepackage[top=30mm,bottom=30mm,left=25mm,right=25mm]{geometry}
```

### Markdownの書式

pandocがサポートする拡張Markdown記法が使用できます：

- 見出し: `#`, `##`, `###`
- リスト: `-` または `1.`, `2.`
- 強調: `*斜体*`, `**太字**`
- リンク: `[テキスト](URL)`
- 画像: `![代替テキスト](画像パス)`
- コードブロック: ` ```言語名 ... ``` `

## クリーンアップ

生成されたファイルを削除する場合：

```bash
make clean
```

これにより、以下が削除されます：
- `TeXfile/*.tex`
- `output/*.pdf`
- その他のLaTeX中間ファイル

## トラブルシューティング

### pandocがインストールされていない

エラーメッセージが表示される場合、pandocをインストールしてください：

```bash
# Ubuntu/Debian
sudo apt-get install pandoc

# macOS
brew install pandoc
```

### LaTeXコンパイラがインストールされていない

LuaLaTeXが必要です：

```bash
# Ubuntu/Debian
sudo apt-get install texlive-full texlive-luatex texlive-lang-japanese

# macOS
brew install --cask mactex
```

### 日本語フォントの問題

日本語が正しく表示されない場合は、システムに適切な日本語フォントがインストールされていることを確認してください。

## 高度な使い方

### 自動監視モード（オプション）

ファイルの変更を監視して自動的にコンパイルする場合、別途ツールを使用できます：

```bash
# inotify-toolsを使用（Linux）
while inotifywait -e close_write input/*.md; do make; done

# fswatch を使用（macOS）
fswatch -o input/*.md | xargs -n1 -I{} make
```

### バージョン管理

gitignoreにより、以下のファイルは自動的にバージョン管理から除外されます：
- 生成されたPDFファイル
- LaTeXの中間ファイル

必要に応じて変換されたTeXファイルをバージョン管理に含めることもできます。
