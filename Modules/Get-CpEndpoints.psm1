function Get-CpEndpoints {
  [CmdletBinding()]
  param (
    [Parameter(
      Mandatory = $false,
      HelpMessage = "A ClearPass session generated by New-CpSession.")]
    [Session]$Session=$global:CpSession,

    [Parameter(
      Mandatory = $false,
      HelpMessage = "Maximum number of items to return (1 – 1000).")]
    [Int]$Limit=25,

    [Parameter(
      Mandatory = $false,
      HelpMessage = "Zero based offset to start from.")]
    [Int]$Offset=0,

    [Parameter(
      Mandatory = $false,
      HelpMessage = "Sort ordering for returned items.")]
    [String]$Sort="id",

    [Parameter(
      Mandatory = $false,
      HelpMessage = "Sort ordering for returned items.")]
    [PSObject]$Filter="{}",

    [Parameter(
      Mandatory = $false,
      HelpMessage = "Don't verify the server certificate.")]
    [Switch]$SkipCertificateCheck
  )

  if($Filter -ne "{}"){
    [String]$Filter = [System.Web.HttpUtility]::UrlEncode(($Filter | ConvertTo-Json -Depth 100))
  }

  $uri = [Uri]"https://$($Session.Hostname)/api/endpoint?filter=$($Filter)&sort=+$($Sort)&offset=$($OffSet)&limit=$($Limit)"

  $headers = @{
    "Authorization" = "Bearer $($Session.AccessToken)"
    "Accept" = "application/json"
  }

  $params = @{
    Uri = $uri.OriginalString
    Method = "Get"
    Headers = $headers
    SkipCertificateCheck = $SkipCertificateCheck
  }

  try{
    $response = Invoke-RestMethod @params

    $response.'_embedded'.items | ForEach-Object {
      $endpoint = [Endpoint]@{
        Id                = $_.id
        MacAddress        = $_.mac_address
        Description       = $_.description
        Status            = $_.status
        DeviceInsightTags = $_.device_insight_tags
        Attributes        = $_.attributes
      }
      
      Write-Output $endpoint
    }
  }
  catch {
    Write-Error $_
  }
}