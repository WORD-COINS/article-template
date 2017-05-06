#!/usr/bin/env bash

# $REPOSITORY_NAMEで指定された名前のリポジトリをWORDのGitに作成します。

set -e

git checkout master
git remote add word "git@gitolite.word-ac.net:${REPOSITORY_NAME}"
git push word master
