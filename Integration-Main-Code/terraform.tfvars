# #RESOURCE GROUP
 resource_group_variables = {
   "resource_group_1" = {
     name     = "arinarg000001"
    location = "westus2"
    resource_group_tags = {
     Created_By = "Ranjith",
     Department = "CIS"
    }
  }
}


#VNET 
vnets_variables = {
  "vnet_1" = {
    name                        = "arinavnet000001a"
    location                    = "westus2"
    resource_group_name         = "arinarg000001"
    address_space               = ["10.0.0.0/16"]
    dns_servers                 = []
    flow_timeout_in_minutes     = null #possible values are between 4 and 30 minutes.
    bgp_community               = null
    edge_zone                   = null
    is_ddos_protection_required = false #Provide the value as true only if ddos_protection_plan is required
    ddos_protection_plan_name   = null  #Provide the name of the ddos protection plan if above value is true or else keep it as null. If new DDOS protection plan needs to be created uncomment from line 24 to 34
    vnet_tags = {
      Created_By = "ranjith.prasanna@arina.co.in",
      Department = "Arina"
    }
  }
}


subnet_variables = {
  "subnet_1" = {
    name                                           = "arinasubnet000001a"
    resource_group_name                            = "arinarg000001"
    address_prefixes                               = ["10.0.1.0/24"]
    virtual_network_name                           = "arinavnet000001a"
    enforce_private_link_service_network_policies  = true
    enforce_private_link_endpoint_network_policies = true
    is_delegetion_required                         = false #update to true if delegation required and update delegation name,service_name,Service_actions
    service_endpoints                              = ["Microsoft.AzureActiveDirectory"]
    delegation_name                                = "delegation000001"
    service_name                                   = "Microsoft.Sql/managedInstances"
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
  },
  "subnet_2" = {
    name                                           = "arinasubnet00000b"
    resource_group_name                            = "arinarg000001"
    address_prefixes                               = ["10.0.2.0/24"]
    virtual_network_name                           = "arinavnet000001a"
    enforce_private_link_service_network_policies  = false                                                                                                                                                    #Setting this to true will Disable the policy
    enforce_private_link_endpoint_network_policies = false                                                                                                                                                    #Setting this to true will Disable the policy
    service_endpoints                              = ["Microsoft.AzureActiveDirectory"]                                                                                                                       #update this field if service endpoint is required
    is_delegetion_required                         = false                                                                                                                                                    #update to true if delegation required and update delegation name,service_name,Service_actions
    delegation_name                                = "delegation000002"                                                                                                                                       #Update this field if delgation required
    service_name                                   = "Microsoft.Databricks/workspaces"                                                                                                                        #Update this field if delgation required
    service_actions                                = ["Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"] #Update this field if delgation required
  }
}

network_security_group_variable = {
  #NSG with none security rules
  "network_security_group_1" = {
    name                = "arinansg000001"
    resource_group_name = "arinarg000001"
    location            = "westus2"
    security_rule       = null
    network_security_group_tags = {
      Created_By = "adithya",
      Department = "arina"
    }
  },
  #NSG with multiple security rules
  "network_security_group_3" = {
    name                = "arinansg000003"
    resource_group_name = "arinarg000001"
    location            = "westus2"
    security_rule = [
      {
        name                                       = "arinansg000003"
        priority                                   = 100
        direction                                  = "Inbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = null
        destination_port_range                     = "*"
        destination_port_ranges                    = null
        source_address_prefix                      = "*"
        source_address_prefixes                    = null
        destination_address_prefix                 = "*"
        destination_address_prefixes               = null
        description                                = "InboudAllow100"
        source_application_security_group_ids      = null
        destination_application_security_group_ids = null
      },
      {
        name                                       = "arinansg0000031"
        priority                                   = 100
        direction                                  = "Outbound"
        access                                     = "Allow"
        protocol                                   = "Tcp"
        source_port_range                          = "*"
        source_port_ranges                         = null
        destination_port_range                     = "*"
        destination_port_ranges                    = null
        source_address_prefix                      = "*"
        source_address_prefixes                    = null
        destination_address_prefix                 = "*"
        destination_address_prefixes               = null
        description                                = "OutboudAllow100"
        source_application_security_group_ids      = null
        destination_application_security_group_ids = null
      }
    ]
    network_security_group_tags = {
      Created_By = "adithya",
      Department = "arina"
    }
  }
}


avd_host_pool_variables = {
  "host_pool1" = {
    name                             = "arinatesthostpool1"
    location                         = "westus2"
    resource_group_name              = "arinarg000001"
    friendly_name                    = "arinatesthostpool1"
    description                      = "hostPoolDescription"
    custom_rdp_properties            = null
    host_pool_type                   = "Personal"
    personal_desktop_assignment_type = "Automatic"
    load_balancer_type               = "Persistent"
    preferred_app_group_type         = "Desktop" # can be Desktop, RailApplications
    # if host_pool_type is personal pass maximum_sessions_allowed = null
    maximum_sessions_allowed = null
    validate_environment     = true
    start_vm_on_connect      = true
    host_pool_tags = {
      Created_By = "deboparna",
      Department = "CT"
    }
  },
  "host_pool2" = {
    name                  = "arinatesthostpool2"
    location              = "westus2"
    resource_group_name   = "arinarg000001"
    friendly_name         = "arinatesthostpool2"
    description           = "hostPoolDescription"
    custom_rdp_properties = null
    host_pool_type        = "Pooled"
    # if host_pool_type is pooled make personal_desktop_assignment_type = null
    personal_desktop_assignment_type = null
    load_balancer_type               = "BreadthFirst"
    preferred_app_group_type         = "Desktop" # can be Desktop, RailApplications
    # if host_pool_type is personal make maximum_sessions_allowed = 0
    maximum_sessions_allowed = 3
    validate_environment     = true
    start_vm_on_connect      = true
    host_pool_tags = {
      Created_By = "deboparna",
      Department = "CT"
    }
  }
}


#AppGroup
appgroups_variables = {
  "key" = {
    appgroup_tags = {
      Created_By = "Aayush",
      Department = "CIS"
    }
    description         = "Description of App Group"
    friendly_name       = "Ploceus App Group"
    host_pool_name      = "arinatesthostpool1"
    location            = "westus2"
    name                = "ploceusappGroup"
    resource_group_name = "arinarg000001"
    type                = "RemoteApp"
  }
}


workspaces_variables = {
  "workspace" = {
    name                = "arinavdiworkspace000001"
    location            = "westus2"
    resource_group_name = "arinarg000001"
    friendly_name       = "arinavdi"
    description         = "VDI for arinaUser"
    workspace_tags = {
      CreatedBy = "anushankar.konduri@arina.co.in"
    }
  }
}

#Work space and Application Group allocation variables
association_variable = {
  key1 = {
    app_group = "ploceusappGroup"
    workspace = "arinavdiworkspace000001"
  }
}
