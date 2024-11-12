# Create a security group
resource "vkcs_networking_secgroup" "example" {
   name = "my_security_group"
   description = "terraform security group"
}

# Create a security rule
resource "vkcs_networking_secgroup_rule" "example" {
  description       = "All inbound TCP traffic"
  security_group_id = vkcs_networking_secgroup.example.id
  direction         = "ingress"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
}