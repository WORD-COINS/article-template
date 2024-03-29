#!/usr/bin/env bash

# 全ての記事を検査してmain.mdファイルがあったら変換する

for filepath in $PWD/articles/*; do
  cd $filepath
  if [ -f ./main.md ]; then
    echo $filepath
    make pandoc
  fi
done
