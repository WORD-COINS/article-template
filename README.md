WORDの記事の雛形
===================

## 必要なもの

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/)
- [docker-compose](https://github.com/docker/compose)

## コンパイル

1. `git submodule update --init`
2. `cd texfiles`
3. `docker-compose pull`
4. `docker-compose up`
5. `cd ..`
6. `docker-compose pull`
7. `docker-compose up`

## 編集の仕方

### 1. 記事のディレクトリを作る

まず`articles`フォルダの`hinagata`をコピーして、任意の名前をつけます。
このときの名前はなんでも構いませんが日本語を使うとややこしくなるのでやめましょう。
このときのディレクトリ名をここでは`my_article`としたとして話をすすめます。

### 2. 記事を目次に加える

リポジトリ直下にある`main.tex`を見てみましょう。ファイル中盤に次のような記述があるはずです。

```tex
% 記事（サンプル）
\LetLtxMacro\latexincludegraphics\includegraphics
\renewcommand\includegraphics[2][]{%
  \latexincludegraphics[#1]{./articles/hinagata/#2}
}
\subfile{./articles/hinagata/main.tex}
\LetLtxMacro\includegraphics\latexincludegraphics
\newpage
```

これをコピーして、パスの部分を次のように自分の記事のディレクトリに変更します。

```diff
 % 記事（サンプル）
 \LetLtxMacro\latexincludegraphics\includegraphics
 \renewcommand\includegraphics[2][]{%
-  \latexincludegraphics[#1]{./articles/hinagata/#2}
+  \latexincludegraphics[#1]{./articles/my_article/#2}
 }
- \subfile{./articles/hinagata/main.tex}
+ \subfile{./articles/my_article/main.tex} 
 \LetLtxMacro\includegraphics\latexincludegraphics
 \newpage
```

### 3. 記事を編集する

手順（1）で作成したディレクトリの中にあるファイル`./articles/my_article/main.tex`を編集することで、記事をつくれます。

#### 「文　編集部」の消し方

WORD編集部の人間ではない場合、著者の前に付く「文　編集部」を削除したくなると思います。
「文　編集部」は以下のコマンドを`\begin{document}`の直後に書くことで消せます。

```tex
\authormark{}
```

## 質問

[@\_yyu\_](https://twitter.com/_yyu_)へ投げると早い。LuaLaTeXに関しては[@Nymphium](https://twitter.com/Nymphium)か[@azuma962](https://twitter.com/azuma962)へ。

## ライセンス

License: modified BSD (see LICENSE)
