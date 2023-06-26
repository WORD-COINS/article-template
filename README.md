WORDの記事の雛形
===================

- subfilesパッケージにより、texファイル入稿の形態へと変更
- usepackageは`article-template` 直下の `main.tex` を編集する
- デフォルトの処理系をLuaLaTeXへと変更
- 記事タイトル周辺のコマンドの変更

ビルド時にぶっこわれが発生する場合、
pLaTeX専用パッケージを利用しようとしていないかを疑ってみましょう。

全体ビルド時にぶっこわれが発生する場合、前に置いてある記事で変更された
コマンドがないかなどを確認しましょう。

## 必要なもの

- [Git](https://git-scm.com/)
- [TeXLive](https://www.tug.org/texlive/)または[MacTeX](http://www.tug.org/mactex/)
- [GNU Make](https://www.gnu.org/software/make)

## 編集の仕方

### 0. ブランチを切る

記事を入れるディレクトリ名に合わせてGitのブランチを切ります。
記事のディレクトリを`my_article`としたら、次のように切ってブランチを移動しましょう。

```
git branch articles/my_article
git switch articles/my_article
```

注意する点として、 article **s** である点です。
article だとCIが走らないので気を付けてください。

### 1. 記事のディレクトリを作る

`articles`フォルダの`hinagata`をコピーして、任意の名前をつけます。
このときの名前はなんでも構いませんが日本語を使うとややこしくなるのでやめましょう。
このときのディレクトリ名をここでは`my_article`としたとして話をすすめます。

### 2. 記事を目次に加える

リポジトリ直下にある`main.tex`を見てみましょう。ファイル中盤に次のような記述があるはずです。

```tex
% 記事（サンプル）
\article{./articles/hinagata}

% 裏表紙
\article{./articles/back_cover}
```

パスの部分を次のように自分の記事のディレクトリに変更した`\article`コマンドを挿入します。

```diff
 % 記事（サンプル）
 \article{./articles/hinagata}

+\article{./articles/my_article}

 % 裏表紙
 \article{./articles/back_cover}
```

### 3. 記事を編集する

手順（1）で作成したディレクトリの中にあるファイル
`./articles/my_article/main.tex`を編集することで、記事をつくれます。

#### 記事内コマンド

**`document` 環境内** で以下のコマンドが使えます。

+ `\articletitle{hoge}` で記事タイトルの設定をします。
+ `\articleauthor{fuga}` で著者の設定をします。
+ `\makearticletitle` で記事タイトルと記事著者を表示します。


#### 「文　編集部」の消し方

WORD編集部の人間ではない場合、著者の前に付く「文　編集部」を削除したくなると思います。
「文　編集部」は以下のコマンドを`\begin{document}`の直後に書くことで消せます。

```tex
\authormark{}
```

#### ヘッダの表示変更
通常記事タイトルがヘッダに表示されますが、これを変更する場合`document`環境内で
以下を叩いてください。

```tex
\articleheader{newheader}
```

#### パッケージの追加

`article-template/main.tex` のプリアンブルで`\usepackage`を行ってください。


#### 参考文献の書式
BiBTeXを用いる場合、bibファイルは`article-template` 直下の`main.bib` を編集する。
こだわりや調整の自信が無い場合、参考文献の表示は
 `\bibbysection[heading=subbibnumbered]` を用いる。

`article-template/articles/my_article/main.tex`

```tex
\begin{document}
...
情報太郎\cite{myarticle-taro}によれば、ここは
...


\bibbysection[heading=subbibnumbered]

\end{document}
```

`article-template/main.bib`

```
@proceedings{my_article-taro,
Title={Sugoi Ronbun},
Author={Taro Jhouho},
...
}
```

#### 既定以外のフォントを用いる場合
docker側でフォントインストールとシステムへの反映処理が書かれているものとして、
WORDクラス元のbxjsクラスで`luatexja-fontspec`パッケージを読みこんでいるので、
`article-template/main.tex` のプリアンブルで以下のようにして追加する。
他の記事を壊さないよう、グルーピング（`{}`）して使用すること。


`article-template/main.tex`

```tex

\newfontfamily{\myfont}{Very Good Font}

\begin{docment}
```

`article-template/articles/my_article/main.tex`

```tex
\begin{document}
...

普通の文章。{\myfont ここからウルトラスーパー良いフォントで表示}
```


#### 別にpdfをビルドしている場合

すでに別ビルドしたpdfがある場合、
`hinagata-import-pdf`をコピーして同様に進めてください。
別ビルドのpdfではページ番号とヘッダを使わないようにしてください。
wordクラスを使う場合、`documentclass`のオプションに`noheader`と`nopagenumber`を
設定します。
`articletitle`と`articleauthor`を設定し `\makenoarticletitle`で目次に
記事タイトルと著者名が追加されます。

####


## コンパイル

### 全体のコンパイル
リポジトリのルートディレクトリで`make`しましょう。

### 各記事のコンパイル
目次と裏表紙が必要ない場合は`articles/`以下の記事ディレクトリに`cd`して`make`しましょう。

### Dockerによるコンパイル
手元でのビルドに失敗したり、TeXLiveを入れたくなかったりする人はDockerイメージを使ってビルドすることもできます。

#### 全体のコンパイル
リポジトリのルートディレクトリで`docker compose up`しましょう。

#### 各記事のコンパイル
目次と裏表紙が必要ない場合は`articles/`以下の記事ディレクトリに`cd`して`docker compose up`しましょう。

### GitHub Actionsによるコンパイル
特定のブランチ名でBitBucketにpushするとGitHub Actionsを使って記事をビルドすることができます。

#### コンパイル対象
* タグ: 全体の記事
* `master`ブランチ: 全体の記事
* `articles/*`ブランチ: ブランチ名末尾と同じディレクトリの記事

例えば`my_article`というディレクトリで記事を書いた場合、
`articles/my_article`というブランチ名でpushすることで自動的に記事がビルドされます。

#### PDFのダウンロード
ビルドに成功したら編集部内のストレージからPDFをダウンロードすることができます。
詳細は編集部のえらい人に聞いてください。

## 質問
[@hid\_alma1026](https://twitter.com/hid_alma1026)か
[@\_yyu\_](https://twitter.com/_yyu_)へ投げると早い。
LuaLaTeXに関しては[@Nymphium](https://twitter.com/Nymphium)か[@azuma962](https://twitter.com/azuma962)へ。

GitHub Actionsや成果物のpush先に関しては [@totsugeki\_tai](https://twitter.com/totsugeki_tai) に聞くとよい。

## ライセンス

License: modified BSD (see LICENSE)
