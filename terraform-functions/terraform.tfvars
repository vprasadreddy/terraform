networks = {
  virtual_network_1 = {
    virtual_network_name = "vnet1"
    cidr_block           = "10.1.0.0/16"
    subnets = [{
      name       = null
      cidr_block = "10.1.0.1/16"
      },
      {
        name       = "email_server"
        cidr_block = "10.1.1.2/16"
    }]
  },
  virtual_network_2 = {
    virtual_network_name = "vnet2"
    cidr_block           = "10.1.2.0/16"
    subnets = [{
      name       = "firewall"
      cidr_block = "10.1.2.1/16"
      },
      {
        name       = "db"
        cidr_block = "10.1.2.2/16"
    }]
  },
  virtual_network_3 = {
    virtual_network_name = "vnet3"
    cidr_block           = "10.1.3.0/16"
    subnets = [{
      name       = ""
      cidr_block = "10.1.3.1/16"
      },
      {
        name       = "backend"
        cidr_block = "10.1.3.2/16"
    }]
  }
}


networks2 = {
  virtual_network_1 = {
    virtual_network_name = "vnet1"
    cidr_block           = "10.1.0.0/16"
    subnets = {
      subnet_1 = {
      name       = null
      cidr_block = "10.1.0.1/16"
      },
      subnet_2 = {
        name       = "email_server"
        cidr_block = "10.1.1.2/16"
    }
    }
  },
  virtual_network_2 = {
    virtual_network_name = "vnet2"
    cidr_block           = "10.1.2.0/16"
    subnets = {
      subnet_1 = {
      name       = "firewall"
      cidr_block = "10.1.2.1/16"
      },
      subnet_2 = {
        name       = "db"
        cidr_block = "10.1.2.2/16"
    }}
  }
}