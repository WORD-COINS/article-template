#!/usr/bin/env bash

# ビルドの結果をPDFやログのURLとともにSlackへ通知します。
# SlackのWebHook URLは環境変数`$PDF_BUILD_NOTIFY_URL`を使用します。

set -e

GITHUB_HOST_URL="https://github.com"
REPO_URL="${GITHUB_HOST_URL}/${REPO_NAME}"
BUILD_URL="${GITHUB_HOST_URL}/${REPO_NAME}/actions/runs/${RUN_ID}"
COMMIT_URL="${REPO_URL}/tree/${GITHUB_SHA}"
GIT_BRANCH="${GITHUB_REF##*/}"
# TODO: PDF_URL を PDF への直リンにしたい
# PDF_URL=""

fields=`cat <<EOS
{
  "title": "Status",
  "value": "${status}",
  "short": "true"
},
{
  "title": "Repository",
  "value": "${REPO_NAME}",
  "short": "true"
},
{
  "title": "Branch",
  "value": "${GIT_BRANCH}",
  "short": "true"
},
{
  "title": "Revision",
  "value": "<${COMMIT_URL}|${GITHUB_SHA}>",
  "short": "true"
},
{
  "title": "Compile Log",
  "value": "${BUILD_URL}",
  "short": "true"
}
EOS
`

case "${status}" in
  "success")
    color="good"
    # TODO: PDF_URL を PDF への直リンにしたい
    # fields="${fields},
    # {
    #   \"title\": \"PDF\",
    #   \"value\": \"${PDF_URL}\",
    #   \"short\": \"true\"
    # }"
    ;;
  "cancelled")
    color="warning"
    ;;
  *) color="danger" ;;
esac

payload=`cat <<EOS
{
  "attachments": [
    {
      "fallback": "${REPO_NAME} Build #${RUN_ID}",
      "title": "${REPO_NAME} Build #${RUN_ID}",
      "title_link": "${BUILD_URL}",
      "color": "${color}",
      "fields": [${fields}]
    }
  ]
}
EOS
`

curl -s -X POST --data-urlencode "payload=${payload}" "${PDF_BUILD_NOTIFY_URL}"
