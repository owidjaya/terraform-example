provider "aws" {
    region = "us-west-2"  
}

resource "aws_instance" "webapp" {
  ami = "ami-6e1a0117"
  instance_type = "t2.micro"
  tags {
      Name = "nodejs-server"
  }
  user_data = <<-EOF
        #!/bin/bash
        echo "Hello, World" > index.html
        nohup busybox httpd -f -p 8080 &
        EOF
}
resource "aws_security_group" "instance" {
  name = "nodejs-server"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}