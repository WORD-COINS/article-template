#!/usr/bin/env bash

# makeに成功した場合、Slackへ通知を行います。
# ただし、Slackのwebhook URLは環境変数`$slack_webhook_url`をJenkinsジョブで定義します。
# （このスクリプトはGitHubで公開されるため、SlackのURLが外部に流出するのを防ぐため）

set -e

if [ -e "$WORKSPACE/artifacts/$repository/$branch/${push_date}_${revision:0:7}.pdf" ]; then
  result="SUCCESS"
else
  result="FAILURE"
fi

pdf_url="${JOB_URL}ws/artifacts/${repository}/${branch}/${push_date}_${revision:0:7}.pdf"
console_url="${BUILD_URL}console"
param="repository=${repository}&branch=${branch}&revision=${revision}&result=${result}&console_url=${console_url}&pdf_url=${pdf_url}&job_name=${JOB_NAME}&build_number=${BUILD_NUMBER}&build_url=${BUILD_URL}"

gitiles_base_url="https://gitiles.word-ac.net/"
gitiles_url="${gitiles_base_url}${repository}/+/${revision}"

channel="jenkins"
username="jenkins"

fields=`cat <<EOS
{
  "title": "Status",
  "value": "${result}",
  "short": "true"
},
{
  "title": "Repository",
  "value": "${repository}",
  "short": "true"
},
{
  "title": "Branch",
  "value": "${branch}",
  "short": "true"
},
{
  "title": "Revision",
  "value": "<${gitiles_url}|${revision}>",
  "short": "true"
},
{
  "title": "Compile Log",
  "value": "${console_url}",
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
      \"value\": \"${pdf_url}\",
      \"short\": \"true\"
    }"
    ;;
  *) color="danger" ;;
esac

payload=`cat <<EOS
{
  "channel":  "${channel}",
  "username": "${username}",
  "attachments": [
    {
      "fallback": "${JOB_NAME} Build #${BUILD_NUMBER} ${result}",
      "title": "${JOB_NAME} Build #${BUILD_NUMBER}",
      "title_link": "${BUILD_URL}",
      "color": "${color}",
      "fields": [${fields}]
    }
  ]
}
EOS
`

curl -s -X POST --data-urlencode "payload=${payload}" "${slack_webhook_url}"
