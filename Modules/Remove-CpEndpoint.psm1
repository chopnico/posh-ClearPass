function Remove-CpEndpoint {
  [CmdletBinding()]
  param (
    [Parameter(
      Mandatory = $false,
      HelpMessage = "A ClearPass session generated by New-CpSession.",
      ParameterSetName = "Endpoint")]
    [Parameter(
      Mandatory = $false,
      HelpMessage = "A ClearPass session generated by New-CpSession.",
      ParameterSetName = "Id")]
    [Session]$Session=$global:CpSession,

    [Parameter(
      Mandatory = $true,
      HelpMessage = "A endpoint object.",
      ValueFromPipeline = $true,
      ParameterSetName = "Endpoint")]
    [Endpoint]$Endpoint,

    [Parameter(
      Mandatory = $true,
      HelpMessage = "A endpoint ID.",
      ParameterSetName = "Id")]
    [Int]$Id,

    [Parameter(
      Mandatory = $false,
      HelpMessage = "Don't verify the server certificate.",
      ParameterSetName = "Endpoint")]
    [Parameter(
      Mandatory = $false,
      HelpMessage = "Don't verify the server certificate.",
      ParameterSetName = "Id")]
    [Switch]$SkipCertificateCheck
  )

  Process{
    function Remove {
      param(
        [Int]$EndpointId
      )
      $uri = [Uri]"https://$($Session.Hostname)/api/endpoint/$($EndpointId)"

      $headers = @{
        "Authorization" = "Bearer $($Session.AccessToken)"
        "Accept" = "application/json"
      }
  
      $params = @{
        Uri = $uri.OriginalString
        Method = "Delete"
        Headers = $headers
        ContentType = "application/json"
        SkipCertificateCheck = $SkipCertificateCheck
      }
  
      try{
        Invoke-RestMethod @params | Out-Null
      }
      catch {
        Write-Error $_
      }
    }

    if($Id){
      Remove -Endpoint $Id
    }
    else {
      Remove -Endpoint $Endpoint.Id
    }
  }
}