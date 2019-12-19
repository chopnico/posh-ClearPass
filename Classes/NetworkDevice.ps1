class NetworkDevice {
  [Int]$Id
  [String]$Name
  [String]$Description
  [String]$IpAddress
  [String]$VendorName
  [String]$RadiusSecret
  [String]$Tacas
  [Bool]$CoaCapable
  [Int]$CoaPort
  [Bool]$RadsecEnabled
  [Hashtable]$Attributes
}