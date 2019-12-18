# SECURITY GROUPS
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg-1"{
    name = "sg_ping_ssh"
    # The name cannot have dash on it, should be underscore
    vpc_id = aws_vpc.main1.id
    description = "Allow ping and SSH"

    # Inbound in AWS
    # SSH ingress
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Inbound in AWS
    # Ping (ICMP) ingress
    ingress{
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Outbound in AWS
    egress{
        # Connect to any
        from_port = 0
        to_port = 0
        protocol = "-1"
        # If you select a protocol of "-1" (semantically equivalent to "all"), you must specify a 
        # "from_port" and "to_port" equal to 0. 
        # If not icmp, tcp, udp, or "-1" use the protocol number
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Ping y SSH"
    }
}

# Security group for HTTP
resource "aws_security_group" "sg-2"{
    name = "sg_http"
    vpc_id = aws_vpc.main1.id
    description = "Allow ping and SSH"

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "HHTP"
    }
}


# It is important to add all the mandatory fields, otherwise, terraform will fail.