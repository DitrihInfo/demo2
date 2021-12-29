#---------------------------------------------------
# Create AWS instance BastionA
#---------------------------------------------------

#  AWS instants BastionsrvA 
resource "aws_instance" "BastionA" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name      = var.amazonkey
        subnet_id = aws_subnet.public-subnetA.id
    vpc_security_group_ids  = [aws_security_group.demo2-sec-group.id]
    user_data               = file("upwebsite.sh")
    tags = {
        Name = "BastionA"
    }
    }
     
#---------------------------------------------------
# Create AWS instance BastionB
#---------------------------------------------------

resource "aws_instance" "BastionB" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name      = var.amazonkey
    subnet_id = aws_subnet.public-subnetB.id
    vpc_security_group_ids  = [aws_security_group.demo2-sec-group.id]
    user_data               = file("upwebsite.sh")
    tags = {
        Name = "BastionB"
    }
    }
#---------------------------------------------------
# Create AWS instance websrv-privateA 
#---------------------------------------------------   

resource "aws_instance" "websrv-privateA" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name      = var.amazonkey
    subnet_id = aws_subnet.private-subnetA.id
    vpc_security_group_ids  = [aws_security_group.demo2-sec-group.id]
    user_data               = file("upwebsite.sh")
    tags = {
        Name = "Websrv-privateA"
    }
    }
#---------------------------------------------------
# Create AWS instance websrv-privateB 
#--------------------------------------------------- 
resource "aws_instance" "websrv-privateB" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name      = var.amazonkey
    subnet_id = aws_subnet.private-subnetB.id
    vpc_security_group_ids  = [aws_security_group.demo2-sec-group.id]
    user_data               = file("upwebsite.sh")
    tags = {
        Name = "websrv-privateB"
    }
    }
