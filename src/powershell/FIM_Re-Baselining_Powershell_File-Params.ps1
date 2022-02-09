Get-Content ./inputparams.txt | Foreach-Object{
   $var = $_.Split('=')
   New-Variable -Name $var[0] -Value $var[1]
}

Start-Transcript -Path "./logfile.txt"

# Write-Host "API_KEY_ID: " $api_key_id
# Write-Host "API_KEY_SECRET: " $api_key_secret
# Write-Host "FIM_POLICY_ID: " $fim_policy_id
# Write-Host "FIM_BASELINE_ID: " $fim_baseline_id
# Write-Host "EXPIRES_AT: " $expires_at
# Write-Host "COMMENT: " $comment
# Write-Host "SERVER_ID: " $server_id
# Write-Host "AGENT_ID: " $agent_id


[string]$sStringToEncode="$($api_key_id):$($api_key_secret)"
# Write-Host "String to Encode using Base64: " $sStringToEncode

$sEncodedString=[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($sStringToEncode))
# write-Host "Base64 Encoded String: " $sEncodedString


$api_authentication_url="https://api.cloudpassage.com/oauth/access_token?grant_type=client_credentials"
# write-Host "API_Authentication_URL: " $api_authentication_url

$whole_token_response=Invoke-WebRequest -Headers @{"Authorization" = "Basic $($sEncodedString)"} `
                  -Method POST `
                  -Uri $api_authentication_url `

# write-Host "Whole_Token_Response: " $whole_token_response

$minimized_token_response = $whole_token_response.Content | Out-String | ConvertFrom-Json
# write-Host "Minimized_Token_Response: " $minimized_token_response

$access_token="$($minimized_token_response.access_token)"
# Write-Host "Generated_Access_Token: " $access_token


$api_rebaseline_url="https://api.cloudpassage.com/v1/fim_policies/$($fim_policy_id)/baselines/$($fim_baseline_id)"
# Write-Host "Api_Rebaseline_URL: " $api_rebaseline_url

$request_body = '{"baseline": {"server_id": "'+$server_id+'","expires": "'+$expires_at+'","comment": "'+$comment+'"}}'
# Write-Host "Request Body: "$request_body

$rebaseline_response=Invoke-WebRequest -Headers @{"Authorization" = "Bearer $($access_token)"} `
                  -Method PUT `
                  -Body $request_body `
                  -Uri $api_rebaseline_url `
                  -ContentType application/json
Write-Host "Whole_Re-Baseline_Response: "$rebaseline_response


Stop-Transcript