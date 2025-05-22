data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}

resource "aws_security_group" "bastion_security_group" {
  description = "Allow traffic for EC2 Bastion Host"
  vpc_id      = var.vpc_id


  dynamic "ingress" {
    for_each = var.sg_ingress_ports
    iterator = sg_ingress
    content {
      description = sg_ingress.value["description"]
      to_port     = sg_ingress.value["port"]
      from_port   = sg_ingress.value["port"]
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, { Name = "${var.naming_prefix}-sg-bastion" })


}


resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id]
  # user_data              = filebase64("${path.module}/web-install.sh")
  tags = merge(var.common_tags, { Name = "${var.naming_prefix}-ec2-${var.ec2_name}" })
}

resource "null_resource" "copy_ec2_keys" {
  connection {
    type        = "ssh"
    host        = aws_instance.bastion_host.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("${path.module}/private-key/tf-key.pem")
  }
  provisioner "file" {
    source      = "${path.module}/private-key/tf-key.pem"
    destination = "/tmp/tf-key.pem"
  }

  provisioner "remote-exec" {
    inline = ["sudo chmod 400 /tmp/tf-key.pem"]
  }

  # provisioner "local-exec" {
  #   command = "echo VPC created on `date` and VPC ID : ${ aws_instance.bastion_host.public_dns} >> bastion-host-public-dns.txt"
  # }
  depends_on = [aws_instance.bastion_host]
}

