resource "aws_instance" "Moalaa_Instance" {
  for_each               = aws_subnet.public_subnet
  subnet_id              = each.value.id
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = each.value.availability_zone
  vpc_security_group_ids = [aws_security_group.allow_http_https_ssh-sg.id]
  user_data              = <<EOF
       #!/bin/bash
       yum update -y
       yum install -y httpd
       systemctl start httpd
       systemctl enable httpd
       echo '<center><h1>Moalaa<strong>is</strong> here </h1></center>' > /var/www/html/index.txt
       EOF

  tags = {
    Name = "Moalaa_Instance"
  }
}