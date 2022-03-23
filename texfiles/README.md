WORD Class
===

## about source code

- Makefile
	+ `make`で`word.cls`と`word.pdf`ができる
- word.dtx
    + A class extended bxjsbook for WORD-coins.

## word.cls

##  オプション

+ `noheader`オプションでヘッダを出力しなくなる。
+ `nopagenumber`オプションで頁番号を出力しなくなる。

## コマンド

+ `\article` 記事をインポートする。文書トップレベルでのみ使用する。
+ `\authormark{hoge}`で、著者名前の「文 編集部」を編集できる。
+ `\articletitle` 記事タイトルを設定する。
+ `\articleauthor` 著者名前を設定する。
+ `\makearticletitle` 記事タイトルと著者名前を表示する。tocに追加する。
+ `\makenoarticletitle` tocに記事タイトルと著者名前を追加する。
+ `\articleheader`が従来の`\subtitle`の代わりとして登場した。
  - 何もしない場合記事タイトル表示時に記事タイトルの値を設定するが、文書中で叩くとその箇所から変更する。 


# ライセンス

License: modified BSD (see LICENSE)
