#Create EC2 Instance
resource "aws_instance" "jenkins-ec2" {
  ami           = var.ami_id 
  instance_type = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]


  tags = {
    Name = "Jenkins-server"
  }
  
  
  # wait for ec2 to be created
  depends_on = [aws_instance.jenkins-ec2]
}

# print the url of the jenkins server
output "website_url" {
  value     = join ("", ["http://", aws_instance.jenkins-ec2.public_dns, ":", "8080"])
}



resource "aws_instance" "webapp-ec2" {
  ami           = var.ami_id 
  instance_type = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]


  tags = {
    Name = "Cstore-Web-App"
  }

   # wait for ec2 to be created
  depends_on = [aws_instance.webapp-ec2] 
}

#Jenkins Security Group Resource
resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Allow Port 22 and 8080"

  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 8080 Traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "Allow 5000 port for Public Access"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
