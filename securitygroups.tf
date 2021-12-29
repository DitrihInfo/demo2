#  AWS Instances and sec-group  for Demo2
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


resource "aws_security_group" "sec-alb" {
    name = "alb-security-group"

    # Allow HTTP in
    ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    
#Allow HTTP in
    egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ssh-bastion" {
    name = "bastion-security-group"

    # Allow HTTP in
    ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    
#Allow HTTP in
    egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}