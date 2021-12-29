#---------------------------------------------------
# Create AWS security group  for Demo2
#--------------------------------------------------- 
resource "aws_security_group" "demo2-sec-group" {
    name        = "demo2-sec-group"
    vpc_id = aws_vpc.mydemo2.id
    description = "Security group for Demo2"    
    
   dynamic "ingress"  {
	for_each = ["22", "80"]
	content {
	        
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
      } 
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
      Name = "-allow-22-80 ports"
    }
}

