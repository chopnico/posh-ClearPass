function Remove-CpNetworkDeviceGroup {
  [CmdletBinding()]
  param (
    [Parameter(
      Mandatory = $false,
      HelpMessage = "A ClearPass session generated by New-CpSession.",
      ParameterSetName = "NetworkDeviceGroup")]
    [Parameter(
      Mandatory = $false,
      HelpMessage = "A ClearPass session generated by New-CpSession.",
      ParameterSetName = "Id")]
    [Session]$Session=$global:CpSession,

    [Parameter(
      Mandatory = $true,
      HelpMessage = "A network device group object.",
      ValueFromPipeline = $true,
      ParameterSetName = "NetworkDeviceGroup")]
    [NetworkDeviceGroup]$NetworkDeviceGroup,

    [Parameter(
      Mandatory = $true,
      HelpMessage = "A network device ID.",
      ParameterSetName = "Id")]
    [Int]$Id,

    [Parameter(
      Mandatory = $false,
      HelpMessage = "Don't verify the server certificate.",
      ParameterSetName = "NetworkDevice")]
    [Parameter(
      Mandatory = $false,
      HelpMessage = "Don't verify the server certificate.",
      ParameterSetName = "Id")]
    [Switch]$SkipCertificateCheck
  )
  
  Process{
    function Remove {
      param(
        [Int]$NetworkDeviceGroupId
      )
      $uri = [Uri]"https://$($Session.Hostname)/api/network-device-group/$($NetworkDeviceGroupId)"

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
      Remove -NetworkDeviceGroupId $Id
    }
    else {
      Remove -NetworkDeviceGroupId $NetworkDeviceGroup.Id
    }
  }
}