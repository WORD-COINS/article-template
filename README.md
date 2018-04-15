WORDの記事の雛形
===================

[![Build Status](https://travis-ci.org/WORD-COINS/article-template.svg?branch=master)](https://travis-ci.org/WORD-COINS/article-template)
[![Build status](https://ci.appveyor.com/api/projects/status/v38n9xspthe9su67?svg=true)](https://ci.appveyor.com/project/y-yu/article-template)

これはGitHubで完結したWORDの記事の雛形です。
鍵登録が出来ない場合や、WORD編集部以外のメンバーに執筆してもらう場合に利用してもらって下さい。

## 使い方

### macOS・Linux

1. `git clone https://github.com/WORD-COINS/article-template.git`
2. `cd ./article-template`
3. `git submodule update --init`
4. `cd ./articles`
5. `cp -r ./hinagata ./my-article-name`
6. `cd ./my-article-name`
7. `make`

### Windows

1. `git clone https://github.com/WORD-COINS/article-template.git`
2. `cd ./article-template`
3. `git submodule update --init`
4. `cd ./articles`
5. `cp -r ./hinagata ./my-article-name`
6. `cd ./my-article-name`
7. `make`

これで`main_odd.pdf`、`main_even.pdf`が生成されれば成功です。
あとは`main.tex`を編集すれば記事が出来ます。

### 「文　編集部」の消し方

WORD編集部の人間ではない場合、著者の前に付く「文　編集部」を削除したくなると思います。
「文　編集部」は以下のコマンドを`\documentclass`から`\begin{document}`の間の
どこかに書くことで消せます。

```tex
\authormark{}
```

### 偶数頁

また、偶数頁始まりも`\documentclass`のオプションに`evenstart`をつけることで簡単にできます。

```tex
\documentclass[evenstart]{word}
%.....
```

## LuaLaTeXを使う

WORDでは新たにLuaLaTeXが使えるようになりました。

### macOS・Linux

上記の **使い方(7)** で`LATEXMKFLAG=-lualatex make`としてください。
以降は`make`のみでOKです。

### Windows

**使い方(7)** で`LATEXMKFLAG=-lualatex make`としてください。

## 質問

[@\_yyu\_](https://twitter.com/_yyu_)へ投げると早い。LuaLaTeXに関しては[@Nymphium](https://twitter.com/Nymphium)か[@azuma962](https://twitter.com/azuma962)へ。

## ライセンス

License: modified BSD (see LICENSE)
