class NetworkDevice {
  [Int]$Id
  [String]$Name
  [String]$Description
  [String]$IpAddress
  [String]$VendorName
  [Bool]$CoaCapable
  [Int]$CoaPort
  [Bool]$RadsecEnabled
  [PSCustomObject]$Attributes
}