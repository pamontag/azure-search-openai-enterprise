param name string
param location string = resourceGroup().location
param tags object = {}
param addressPrefix string = '10.0.0.0/23' 
param appsubnetname string = 'appsubnet'
param miscsubnetname string = 'miscsubnet'
param appsubnetaddressprefix string = '10.0.0.0/25' 
param miscubnetaddressprefix string = '10.0.1.0/25' 

resource virtualnetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: appsubnetname
        properties: {
          addressPrefix: appsubnetaddressprefix
          delegations: [
            {
              name: 'serverfarmdelegation'
              properties: {
                serviceName: 'Microsoft.Web/serverfarms'
              }
            }
          ]
        }
      },{
        name: miscsubnetname
        properties: {
          addressPrefix: miscubnetaddressprefix
        }
      }         
    ]    
  }
}

output appsubnetid string = virtualnetwork.properties.subnets[0].id
output miscsubnetid string = virtualnetwork.properties.subnets[1].id
