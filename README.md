WORDの記事の雛形
===
[![Build Status](https://travis-ci.org/WORD-COINS/article-template.svg?branch=master)](https://travis-ci.org/WORD-COINS/article-template)
[![Build status](https://ci.appveyor.com/api/projects/status/v38n9xspthe9su67?svg=true)](https://ci.appveyor.com/project/y-yu/article-template)

これはGitHubで完結したWORDの記事の雛形です。
鍵登録が出来ない場合や、WORD編集部以外のメンバーに執筆してもらう場合に利用してもらって下さい。

# 使い方

## macOS・Linux
1. `git clone https://github.com/WORD-COINS/article-template.git`
2. `cd ./article-template`
3. `git submodule update --init`
4. `cd ./articles`
5. `cp -r ./hinagata ./my-article-name`
6. `cd ./my-article-name`
7. `autoconf`
8. `./configure`
9. `make`

## Windows
1. `git clone https://github.com/WORD-COINS/article-template.git`
2. `cd ./article-template`
3. `git submodule update --init`
4. `cd ./articles`
5. `cp -r ./hinagata ./my-article-name`
6. `cd ./my-article-name`
7. `cmake -DENABLE_LUATEX=OFF .`
8. `cmake --build .`

これで`main.pdf`が生成されれば成功です。
あとは`main.tex`を編集すれば記事が出来ます。

# 「文　編集部」の消し方
WORD編集部の人間ではない場合、著者の前に付く「文　編集部」を削除したくなると思います。
そういう場合は`\subtitle`の後（少なくとも`\begin{document}`の前）などに次のようなコマンドを追加してください。

```tex
\makeatletter
\renewcommand{\@authormark}{}
\makeatother
```
このようにすると、「文　編集部」が消滅します。

# 偶数頁
レイアウトの問題で、偶数頁から開始していただくことがあります。その場合は、プレアンブルに以下を追加してください。

```tex
\setcounter{page}{2}
```

# word-lua
WORDでは新たにLuaLaTeXが使えるようになりました。

## macOS・Linux
上記の **使い方8.** で`./configure --enable-luatex`としてください。
以降は`make`のみでOKです。

## Windows
**使い方7.** で`cmake -DENABLE_LUATEX=ON .`としてください。

## 「文　編集部」の消し方
LuaLaTeXでは「文　編集部」は以下のコマンドでも消すことができます。

```tex
\authormark{}
```

## 偶数頁
また、偶数頁始まりも`\documentclass`のオプションに`swapheader`をつけていただくことで簡単にできます。

```TeX
\documentclass[swapheader]{word-lua}
%.....
```

# 質問
[@\_yyu\_](https://twitter.com/_yyu_)へ投げると早い。word-luaに関しては[@Nymphium](https://twitter.com/Nymphium)か[@azuma962](https://twitter.com/azuma962)へ。

# ライセンス

License: modified BSD (see LICENSE)
