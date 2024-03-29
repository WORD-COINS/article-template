---
title: 記事を執筆しよう
author: 情報 太郎
---

# Markdownによる執筆

LaTeXを手元に用意せずに簡単に記事を書くために用意しています。複雑なデザインを必要とする場合はLaTeXを使用して下さい。

リポジトリをgitで手元にcloneしたのちにフォルダ名と同じブランチを作成して移動します。

```
$ git checkout -b articles/my-article-md
```

とした場合には`articles/hinagata-markdown`フォルダをコピーしたのちにフォルダ名を変更し、`articles/my-article-md`フォルダとします。ブランチ名が異なる場合はフォルダ名も当然異なります。このとき、ブランチ名は必ず`articles/*`という形式にしてください。

`articles/my-article-md`フォルダ内の`main.md`ファイル内に記事を書きます。その際、ファイル冒頭にタイトルと著者名を以下のように必ず記述してください。


```
---
title: タイトル
author: 著者名
---
```

さて、今度はリポジトリルートにmain.texファイルを開きます。すると

```TeX
\mainmatter

% 記事（サンプル）
\article{./articles/hinagata}
% 記事（markdownサンプル）
\article{./articles/hinagata-markdown}

% 裏表紙
\article{./articles/back_cover}
```
このようになっていると思いますので、この「記事（サンプル）」と「裏表紙」という
コメントの間に次のような書き込みをしましょう。

```TeX
\article{./articles/my-article-md}
```

このとき、`\article`コマンドの引数には記事のあるフォルダまでのパスを与えてください。

記事の執筆が終わったらcommitをしてpushしましょう。

```
$ git add articles/my-article-md
$ git commit -m "add article"
$ git push
```

# サポート記法

## 小節

### 深さ3

## 段落

空白行を入れると段落が変わり、
単なる改行だとそのまま続けて表示される

段落2\
これは強制改行

## 箇条書き

- 順序無し箇条書き
  - 深くできる
- 普通の深さ

1. 順序有り箇条書き
1. 順序2

## 脚注

脚注[^footnote]を入れられる。

[^footnote]: 脚注

## 引用

引用できる。

> 被引用文

## コード

インラインにコードを入れることも`code`のようにできる。

```python
print("hello")
```

## 画像

![画像のテスト](../back_cover/wordlogo.pdf){#fig:pdf_figure}

![画像のテスト（jpeg）](./wordlogo.jpg){#fig:jpeg_figure}


このようにPDFやJPEG、PNG画像を付けることができます。

画像の横幅や縦幅を指定したい場合はLaTeXコードを書く必要があります：


\begin{figure}
\hypertarget{fig:jpeg_figure}{%
\centering
\includegraphics[width=0.8\textwidth]{./wordlogo.jpg}
\caption{画像のテスト（大きさ変更）}\label{fig:jpeg_figure}
}
\end{figure}

## 数式

簡単な数式は$マークの間に書くことで実現できます。

$$x + y = \frac{y}{x}$$


行の中に入れることもできます。：$a + b = c$


## \LaTeX コマンド

コマンドを文中に書くことができます。

例えば強制的に改ページしたいときは

\newpage

とすれば実現できます

# texファイルの生成

texファイルが必要になった場合はpandocをインストールしたのちに

```
make pandoc
```

とすることで生成することができます。


# その他情報

pandoc 3.1.2での動作を確認している。

Markdownで執筆できる環境の整備をしたのは@puripuri2100[^puripuri2100]なので、何か聞きたい場合は連絡を。

[^puripuri2100]: [https://twitter.com/puripuri2100](https://twitter.com/puripuri2100)
