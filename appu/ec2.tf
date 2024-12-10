#Fetching the existing ami id
# data "aws_ami" "my-ami" {
#     most_recent = true
#     name_regex = "my-new-ami"
#     owners = [242201281931]
# }

data "aws_ami" "my-ami" {
  most_recent = true
  name_regex  = ".*"             # Match any AMI name for testing
  owners      = ["242201281931"] # Replace with a known owner
}



#using that ami id creating an instance and deploying nginx server
# resource "aws_instance" "Nginx-Server" {
#   ami           = data.aws_ami.my-ami.id
#   instance_type = var.instance_type
#   availability_zone = "us-east-1a"
#   subnet_id = "${aws_subnet.public-subnet-1}"
#   vpc_security_group_ids = "${aws_security_group.security_group}"
#   associate_public_ip_address = true
#   key_name = var.key_name
#   user_data = <<-EOF
#     #!/bin/bash
#     yum install -y tmux
#     sudo dnf update -y
#     sudo dnf install nginx -y
#     sudo systemctl start nginx
#     sudo systemctl enable nginx
#     echo "<div><h1>$(cat /etc/hostname)</h1></div>" > /usr/share/nginx/html/index.html
#   EOF

#   tags = {
#     Name = "Nginx-Server"
#   }
# }


resource "aws_instance" "Nginx-Server" {
  ami                         = data.aws_ami.my-ami.id
  instance_type               = var.instance_type
  availability_zone           = "us-east-1a"
  subnet_id                   = aws_subnet.public-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  # User data script to deploy Nginx
  user_data = <<-EOF
    #!/bin/bash
    yum install -y tmux
    sudo dnf update -y
    sudo dnf install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "<div><h1>Deployed via Through Terraform</h1><br>
          <h1>$(cat /etc/hostname)</h1>
    </div>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name       = "${var.vpc_name}-Nginx-Server"
    Env        = "Prod"
    Owner      = "Aparna"
    CostCenter = "ABCD"
  }
}
