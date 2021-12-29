
output "LoadBalance_DNS_Name" {
  value = "${aws_lb.mylb.dns_name}"
  description = "Domain Name ALB"
}

/*
output "public_ip" {
  value = aws_instance.ec2_public.public_ip
}
*/
output "websrv_privateA_ip" {
  value = aws_instance.websrv-privateA.private_ip
}
output "websrv_privateB_ip" {
  value = aws_instance.websrv-privateB.private_ip
}
output "Static_IP_BastionA"{
  value = aws_instance.BastionA.public_ip
}
output "Static_IP_BastionB"{
  value = aws_instance.BastionB.public_ip
}
output "Static_IP_forNatA" {
    value = aws_eip.eipA.public_ip
}

output "Static_IP_forNatB" {
    value = aws_eip.eipB.public_ip
}
