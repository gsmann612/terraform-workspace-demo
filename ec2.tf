# key pair
resource "aws_key_pair" "my_key" {
  key_name   = "pub-key"
  public_key = file("~/.ssh/id_ed25519.pub")
  tags = {
    Environment = var.env
  }
}

# vpc & security group
resource "aws_default_vpc" "default" {} 
resource "aws_security_group" "allow_ssh" {
  name        = "${var.env}-allow-ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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
# ec2 instance
resource "aws_instance" "my_instance" {
  for_each = tomap({
    aws_micro = "t2.micro",
    aws_medium = "t2.medium"
  })
  depends_on = [ aws_security_group.allow_ssh, aws_key_pair.my_key ]
  ami           = var.ec2_ami # Amazon Linux 2 AMI
  instance_type = each.value
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.allow_ssh.name]
  user_data = file("install_nginx.sh")

  
  root_block_device {
    volume_size = var.env == "prd" ? var.ec2_root_storage_size : 8 # condition ? (ternary operator) value_if_true : value_if_false
        volume_type = "gp3"
  }
  tags = {
    Name = each.key
  }
}