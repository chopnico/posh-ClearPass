class SaveNetworkDevice {
  [String]$Name
  [String]$Description
  [String]$IpAddress
  [String]$RadiusSecret
  [String]$TacacsSecret
  [String]$VendorName
  [Bool]$CoaCapable
  [Int]$CoaPort
  [Bool]$RadsecEnabled
  [Hashtable]$Attributes
}