#RESOURCE GROUP
module "resource_group" {
  source                   = "../resource_group/v1.1.0"
  resource_group_variables = var.resource_group_variables
}

#Virtual Network
module "virtual_network" {
  source              = "../virtual_network/v1.0.0"
  vnets_variables = var.vnets_variables
  depends_on          = [module.resource_group]
}

#Subnet
module "subnet" {
  source                  = "../subnet/v1.0.0"
  subnet_variables = var.subnet_variables
  depends_on              = [module.virtual_network]
}

#Network
module "network_security_group" {
  source                  = "../network_security_group/v1.1.0"
  network_security_group_variable = var.network_security_group_variable
  depends_on              = [module.resource_group]
  
}

module "virtual_desktop_host_pool" {
   source = "../virtual_desktop_hostpool/v1.0.0"
   avd_host_pool_variables = var.avd_host_pool_variables
   depends_on = [module.subnet]
}
module "virtual_desktop_application_group" {
  source                  = "../virtual_desktop_application_group/v1.0.0"
  appgroups_variables     =  var.appgroups_variables
  depends_on              = [module.virtual_desktop_host_pool]
}

module "virtual_desktop_workspace" {
  source = "../virtual_desktop_workspace/v1.0.0"
  workspaces_variables = var.workspaces_variables
  depends_on = [module.resource_group]
}

module "virtual_desktop_workspace_application_group_association" {
  source = "../virtual_desktop_workspace_application_group_association/v1.0.0"
  association_variable = var.association_variable
  depends_on = [module.virtual_desktop_workspace, module.virtual_desktop_application_group]
}