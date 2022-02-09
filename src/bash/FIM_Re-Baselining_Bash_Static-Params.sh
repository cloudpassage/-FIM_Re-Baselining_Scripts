#!/bin/bash

# Input Variables
api_key_id=""
api_key_secret=""
fim_policy_id=""
fim_baseline_id=""
expires_at=""
comment="FIM_Rebaselining_Script"
agent_id=""
server_id=""

# redirect stdout/stderr to a file
exec > logfile.txt

base64_code=$(echo -ne $api_key_id:$api_key_secret | base64)
echo "Base64 Code: "$base64_code

sudo yum install jq

api_authentication_url="https://api.cloudpassage.com/oauth/access_token?grant_type=client_credentials"
token_response=$(curl -X POST $api_authentication_url -H "Authorization: Basic "$base64_code)
access_token=$(echo $token_response | jq '.access_token')
modified_access_token=$(echo $access_token | tr -d '"')
echo "Generated Access Token: "$modified_access_token

api_rebaseline_url="https://api.cloudpassage.com/v1/fim_policies/$fim_policy_id/baselines/$fim_baseline_id"
echo "$api_rebaseline_url"


request_body="{"\"baseline"\": {"\"server_id"\": "\"$server_id"\", "\"expires"\": "\"$expires_at"\", "\"comment"\": "\"$comment"\"}}"
echo "Request Body: "$request_body

rebaseline_response=$(curl -X PUT -H "Authorization: Bearer ${modified_access_token}" -H "Content-type: application/json" -d "${request_body}" "${api_rebaseline_url}")
echo "Response of Re-baseline Request: "$rebaseline_response