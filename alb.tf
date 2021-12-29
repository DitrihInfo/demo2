#---------------------------------------------------
# Create ALB
#---------------------------------------------------

resource "aws_lb" "mylb" {
    name = "myalb"
    internal           = false
    load_balancer_type = "application"
    subnets = [aws_subnet.public-subnetA.id , aws_subnet.public-subnetB.id]   
    security_groups = [aws_security_group.demo2-sec-group.id]
      tags = {
        Name        = "${var.project}-mylb"    
        
     }
}

#---------------------------------------------------
# Create ALB- listener
#---------------------------------------------------

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.mytarget.arn
  }
  }
#---------------------------------------------------
# Create ALB- TARGET GROUP
#---------------------------------------------------

resource "aws_lb_target_group" "mytarget" {
    name = "target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.mydemo2.id
    health_check {
        path = "/index.html"
        protocol = "HTTP"
        matcher = "200"
        interval = 15
        timeout = 3
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
}

#---------------------------------------------------
# Attach EC2 instances to TARGET GROUP
#---------------------------------------------------


resource "aws_lb_target_group_attachment" "attacheA" {
  target_group_arn = aws_lb_target_group.mytarget.arn
  target_id        = aws_instance.websrv-privateA.id
    port             = 80
}
resource "aws_lb_target_group_attachment" "attacheB" {
  target_group_arn = aws_lb_target_group.mytarget.arn
  target_id        = aws_instance.websrv-privateB.id
    port             = 80
}

