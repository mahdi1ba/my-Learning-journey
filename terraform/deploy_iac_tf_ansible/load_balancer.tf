resource "aws_lb" "application-lb"{
    provider = aws.region-master
    name = "jenkins-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lb-sg.id]
    subnets = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
    tags = {
        Name = "Jenkins-LB"
    }
}

resource "aws_lb_target_group" "app-lb-tg" {
    provider = aws.region-master
    name = "app-lb-tg"
    port = var.webserver-port
    target_type = "instance"
    vpc_id = aws_vpc.vpc_master.id
    protocol = "HTTP"
    health_check {
      enabled  = true
      interval = 10
      path = "/"
      port = var.webserver-port
      protocol = "HTTP"
      matcher = "200-299"
    }
    tags = {
      Name = "jenkins-target-group"
    }
}

resource "aws_lb_listener" "jenkins-listener-http" {
    provider = aws.region-master
    load_balancer_arn = aws_lb.application-lb.arn
    port  = "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.app-lb-tg.id
    }
  
}

resource "aws_lb_target_group_attachment" "jenkins-master-attach" {
    provider = aws.region-master
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
    target_id =  aws_instance.jenkins-master.id
    port = var.webserver-port 
}

#add LB DNS to outputs
output "LB-DNS-NAME" {
  value = aws_lb.application-lb.dns_name
}

########
#install httpd
#ansible playbook:
- hosts: jenkins-master
  become: yes
  become_user: root
  tasks:
    - name: install httpd
      yum:
         name:httpd
         state: present
    - name: Start and Enable Apache
      service:
        name: httpd
        state: started
        enabled: yes
