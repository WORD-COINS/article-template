#!/usr/bin/env bash

# $REPOSITORY_NAMEで指定された名前のリポジトリをWORDのGitに作成します。

set -e

git checkout master
git pull origin master
git push "ssh://git@gitolite.word-ac.net/${REPOSITORY_NAME}" master
