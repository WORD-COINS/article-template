#!/usr/bin/env bash

# ビルドの結果をPDFやログのURLとともにSlackへ通知します。
# SlackのWebHook URLは環境変数`$PDF_BUILD_NOTIFY_URL`を使用します。

set -e

if [ $BITBUCKET_EXIT_CODE -eq 0 ]; then
  result="SUCCESS"
else
  result="FAILURE"
fi

REPO_NAME="${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}"
REPO_URL="https://bitbucket.org/${REPO_NAME}"
PDF_URL="${REPO_URL}/downloads/`basename ${BITBUCKET_BRANCH}`.pdf"
PIPELINE_URL="${REPO_URL}/addon/pipelines/home#!/results/${BITBUCKET_BUILD_NUMBER}"
COMMIT_URL="${REPO_URL}/src/${BITBUCKET_COMMIT}"

fields=`cat <<EOS
{
  "title": "Status",
  "value": "${result}",
  "short": "true"
},
{
  "title": "Repository",
  "value": "${REPO_NAME}",
  "short": "true"
},
{
  "title": "Branch",
  "value": "${BITBUCKET_BRANCH}",
  "short": "true"
},
{
  "title": "Revision",
  "value": "<${COMMIT_URL}|${BITBUCKET_COMMIT}>",
  "short": "true"
},
{
  "title": "Compile Log",
  "value": "${PIPELINE_URL}",
  "short": "true"
}
EOS
`

case "${result}" in
  "SUCCESS")
    color="good"
    fields="${fields},
    {
      \"title\": \"PDF\",
      \"value\": \"${PDF_URL}\",
      \"short\": \"true\"
    }"
    ;;
  *) color="danger" ;;
esac

payload=`cat <<EOS
{
  "attachments": [
    {
      "fallback": "${REPO_NAME} Build #${BITBUCKET_BUILD_NUMBER}",
      "title": "${REPO_NAME} Build #${BITBUCKET_BUILD_NUMBER}",
      "title_link": "${PIPELINE_URL}",
      "color": "${color}",
      "fields": [${fields}]
    }
  ]
}
EOS
`

curl -s -X POST --data-urlencode "payload=${payload}" "${PDF_BUILD_NOTIFY_URL}"
