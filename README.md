# WORDの記事の雛形

これはGitHubで完結したWORDの記事の雛形です。
鍵登録が出来ない場合や、WORD編集部以外のメンバーに執筆してもらう場合に利用してもらって下さい。

# 使い方

1. `git clone https://github.com/WORD-COINS/article-template.git`
2. `cd ./article-template`
3. `submodule init`
4. `submodule update`
5. `cd ./articles`
6. `cp -r ./hinagata ./my-article-name`
7. `cd ./my-article-name`
8. `make`

これで`main.pdf`が生成されれば成功です。
あとは`main.tex`を編集すれば記事が出来ます。

# 「文　編集部」の消し方

WORD編集部の人間ではない場合、著者の前に付く「文　編集部」を削除したくなると思います。
そういう場合は`\subtitle`の後（少なくとも`\begin{document}`の前）などに`\authormark`を使って次のようにしてください。

```tex
\authormark{}
```

このようにすると、「文　編集部」が消滅します。

# 質問

[@_yyu_](https://twitter.com/_yyu_)へ投げると早い。
