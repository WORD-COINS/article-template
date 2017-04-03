#!/usr/bin/env bash

# smbのWORD-SERVERをマウントして、特定のフォルダにPDFファイルを投入します。
# WORD-SEVERのIPアドレスとログインユーザー、パスワードは環境変数で与えられます。
# また、PDFを設置する場所も環境変数で与えられます。
#
# $WORD_SERVER_IPADDR WORD-SERVERのIPアドレス
# $WORD_LOGIN_USER   WORD-SEVERのログインユーザー
# $WORD_LOGIN_PASS   WORD-SERVERのログインパスワード
# $article_filename  PDFの名前
# $article_directory 記事のフォルダ
# $branch            Git Branch名
# $dist              コピー先のフォルダ（例: WORD記事/2017年度/2017 43号/01 未赤入れ）

set -e

# Submodule update
git submodule update --init --recursive

# Build
cd "articles/${article_directory}"
WORD_FONT=hiragino-pron make

# Monunt WORD-SEVER
mkdir -p "/Volumes/WORD-ARTICLES"
mount_smbfs "smb://${WORD_LOGIN_USER}:${WORD_LOGIN_PASS}@${WORD_SERVER_IPADDR}/WORD-ARTICLES/" /Volumes/WORD-ARTICLES

# Copy the PDF
cp main.pdf "/Volumes/WORD-ARTICLES${dist}/$article_filename"

# Unmount
umount /Volumes/WORD-ARTICLES
