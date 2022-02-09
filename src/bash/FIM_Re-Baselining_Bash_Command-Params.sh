
#!/bin/bash

while getopts "a:b:c:d:e:f:g:h:" opt; do
  case $opt in
    a)
      api_key_id=$(echo "$OPTARG");;
    b)
      api_key_secret=$(echo "$OPTARG");;
    c)
      fim_policy_id=$(echo "$OPTARG");;
    d)
      fim_baseline_id=$(echo "$OPTARG");;
    e)
      expires_at=$(echo "$OPTARG");;
    f)
      comment=$(echo "$OPTARG");;
	g)
      server_id=$(echo "$OPTARG");;
    h)
      agent_id=$(echo "$OPTARG");;
    \?)
      echo "Invalid option: -$OPTARG" exit 1 ;;
    :)
      echo "Option -$OPTARG requires an argument." exit 1 ;;
  esac
done

# redirect stdout to a file
exec > logfile.txt

echo $api_key_id
echo $api_key_secret
echo $fim_policy_id
echo $fim_baseline_id
echo $expires_at
echo $comment
echo $server_id
echo $agent_id

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


