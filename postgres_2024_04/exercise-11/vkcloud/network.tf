# Get external network with Internet access
data "vkcs_networking_network" "extnet" {
   sdn        = "sprut"
   external   = true
}
# Create a network
resource "vkcs_networking_network" "example" {
   name       = "example-tf-net"
   sdn        = "sprut"
}
# Create a subnet
resource "vkcs_networking_subnet" "example" {
   name       = "example-tf-subnet"
   network_id = vkcs_networking_network.example.id
   cidr       = "192.168.199.0/24"
}
# Create a router
resource "vkcs_networking_router" "example" {
   name       = "example-tf-router"
   sdn        = "sprut"
   external_network_id = data.vkcs_networking_network.extnet.id
}
# Connect the network to the router
resource "vkcs_networking_router_interface" "example" {
   router_id  = vkcs_networking_router.example.id
   subnet_id  = vkcs_networking_subnet.example.id
}
