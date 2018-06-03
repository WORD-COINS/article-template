#!/bin/bash

set -xe

if [[ "$BITBUCKET_BRANCH" == "master" ]]; then
  pip install boto3==1.3.0
  python ./pipeline/idcf_upload.py ${IDCF_API_KEY} ${IDCF_API_SECRET} word-coins main.pdf "${BITBUCKET_COMMIT}.pdf"
  export IDCF_URL="https://word-coins.ds.jp-east.idcfcloud.com/${BITBUCKET_COMMIT}.pdf"
  export BUILD_STATUS="{\"key\":\"doc\", \"state\":\"SUCCESSFUL\", \"name\":\"Documentation\", \"url\":\"${IDCF_URL}\"}"
  curl -H "Content-Type:application/json" -X POST --user "${BB_AUTH_USER}:${BB_AUTH_PASSWORD}" -d "${BUILD_STATUS}" "https://api.bitbucket.org/2.0/repositories/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}/commit/${BITBUCKET_COMMIT}/statuses/build"
fi
