#the name that we set for the hosted zone 
variable "dns-name" {
    type = string
    default = "cmcloudlab0929.info."
}

#dns.tf
#DNS Configuration
#get already, publicly configured hosted zone on route53 - must exist

data "aws_route53_zone" "dns"{
    provider = aws.region-master
    name = var.dns-name
}
# to fetch the aws route 53 zone 


#acm AWS Certificate Manager
#acm.tf
#ACM CONFIGURATION
#Creates ACM certificate and requests validation via DNS (Route53)

resource "aws_acm_certificate" "jenkins-lb-https" {
    provider = aws.region-master
    domain_name = join(".",["jenkins",data.aws_route53_zone.dns.name])
    validation_method = "DNS"
    tags = {
        Name = "Jenkins-ACM"
    }
}

#dns.tf
#Create record in hosted zone for ACM certificate Domain verification 

resource "aws_route53_record" "cert_validation" {
    provider = aws.region-master
    for_each = {
        for val in aws_acm_certificate.jenkins-lb-https.domain_validation_options : val.domain_name => {
            name = val.resource_record_name
            record = val.resource_record_value
            type = val.resource_record_type
        }
    }
    name = each.value.name
    records = [each.value.record]
    ttl =60
    type = each.value.type
    zone_id = data.aws_route53_zone.dns.zone_id
}

#validates ACM issued certificate via route53
resource "aws_acm_certificate_validation" "cert" {
    provider = aws.region-master
    certificate_arn = aws_acm_certificate.jenkins-lb-https.arn
    for_each = aws_route53_record.cert_validation
    validation_record_fqdns = [aws_route53_record.cert_validation[each.key].fqdn]
}


# load balancer
resource "aws_lb_listener" "jenkins-listener-http" {
    provider = aws.region-master
    load_balancer_arn = aws_lb.application-lb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        type = "redirect"
        redirect {
          port = "443"
          protocol = "HTTPS"
          status_code = "HTTP_301"
        }
    }
  
}

resource "aws_lb_listener" "jenkins-listener-https" {
    provider = aws.region-master
    load_balancer_arn = aws_lb.application-lb.arn
    ssl_policy = "ELBSecurityPolicy-2016-08"
    port = "443"
    protocol = "HTTPS"
    certificate_arn = aws_acm_certificate.jenkins-lb-https.arn
    default_action {
      type = "forward"
      target_group_arn = aws_lb-target_group.app-lb-tg.arn
    }
  
}

resource "aws_route53_record" "jenkins" {
    provider = aws.region-master
    zone_id = data.aws_route53_zone.dns.zone_id
    name = join(".",["jenkins",data.aws_route53_zone.dns.name])
    type = "A"
    alias {
      name = aws_lb.application-lb.dns_name
      zone_id = aws_lb.application-lb.zone_id
      evaluate_target_health = true
    }
  
}
