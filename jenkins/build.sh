#!/usr/bin/env bash

# Jenkinsから呼び出されて、articlesの中にあるフォルダへ移動して`make`を実行します。
# `make`に成功した場合、PDFはpushされた日時とコミットIDに基づいて表示用のフォルダへコピーされます。

set -e

# Checkout the branch
git checkout "$branch"
git submodule update --init --recursive

# Determine the article's directory (the first directory in "articles" that is not "hinagata")
cd articles
for i in *; do
  if [ "$i" != "hinagata" ]; then
    article_dir="$i"
    break
  fi
done

if [ -z "$article_dir" ]; then
  echo "Article's directory not found. Aborting."
  exit 1
fi

# cd and make
cd "$article_dir"
WORD_FONT=hiragino-pron make

# Copy the artifact
if [ -e main.pdf ]; then
  mkdir -p "$WORKSPACE/artifacts/$repository/$branch"
  cp main.pdf "$WORKSPACE/artifacts/$repository/$branch/${push_date}_${revision:0:7}.pdf"
fi

# Back to the repository root
cd ../..
