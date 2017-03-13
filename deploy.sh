#!/bin/bash
set -e

#if [[ "${TRAVIS_OS_NAME}" == "linux" && "${TRAVIS_BRANCH}" == "master" && "${TRAVIS_PULL_REQUEST}" == "false" ]]; then
  echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile ~/.ssh/deploy.key\n" >> ~/.ssh/config
  openssl aes-256-cbc -k "$SERVER_KEY" -in deploy_key.enc -d -a -out deploy.key
  cp deploy.key ~/.ssh/
  chmod 600 ~/.ssh/deploy.key
  git config --global user.email "m@yyu.pw"
  git config --global user.name "Yoshimura Yuu"
  git clone git@github.com:WORD-COINS/article-template-document.git
  cd article-template-document
  git fetch origin gh-pages:gh-pages
  git checkout gh-pages
  mv ../main-ptex.pdf main-ptex.pdf
  mv ../main-luatex.pdf main-luatex.pdf
  git add main-ptex.pdf main-luatex.pdf
  git commit -a -m "auto commit on travis $TRAVIS_JOB_NUMBER $TRAVIS_COMMIT"
  git push origin gh-pages:gh-pages
#fi
