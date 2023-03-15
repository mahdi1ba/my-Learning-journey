module "us_payroll" {
  source = "../modules/payroll-app"
  app_region = "us-east-2"
  ami = "ami-24e14087654avm"
}