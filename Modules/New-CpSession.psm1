function New-CpSession {
  [CmdletBinding()]
  param (
      [Parameter(
           Position = 0,
           Mandatory = $true,
           ValueFromPipeLine = $false,
           ValueFromPipeLineByPropertyName = $false)]
      [String]$Hostname,

      [Parameter(
           Position = 1,
           Mandatory = $true,
           ValueFromPipeLine = $false,
           ValueFromPipeLineByPropertyName = $false)]
      [PSCredential]$Credential,

      [Parameter(
           Position = 2,
           Mandatory = $false,
           ValueFromPipeLine = $false,
           ValueFromPipeLineByPropertyName = $false)]
      [Switch]$SkipCertificateCheck
  )

  $username = $Credential.GetNetworkCredential().UserName
  $password = $Credential.GetNetworkCredential().Password

  $uri = [Uri]"https://$($Hostname)/api/oauth"

  $body = @{
    "grant_type"    = "client_credentials";
    "client_id"     = $username;
    "client_secret" = $password
  } | ConvertTo-Json

  $params = @{
    Uri = $uri
    Method = "Post"
    Body = $body
    ContentType = "application/json"
    SkipCertificateCheck = $SkipCertificateCheck
  }

  try{
    $response = Invoke-RestMethod @params

    $session = [Session]@{
      Hostname    = $Hostname
      AccessToken = $response.access_token
      ExpiresIn   = $response.expires_in
    }

    Write-Output $session
  }
  catch {
    Write-Error $_
  }
}