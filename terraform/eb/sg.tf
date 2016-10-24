resource "aws_security_group" "ec2-rds-sg" {
    name_prefix = "ec2-rds-sg"
    description = "ec2 instances joined to this group can access Postgres"

    egress {
        from_port       = "5432"
        to_port         = "5432"
        protocol        = "tcp"
    }
  tags {
    Name = "roma-protoapp"
  }
}

resource "aws_security_group" "rds-ec2-sg" {
    name_prefix = "rds-ec2-sg"
    description = "Allows rds-ec2-sg members access to rds"

    ingress {
        from_port       = "5432"
        to_port         = "5432"
        protocol        = "tcp"
        security_groups = [ "${aws_security_group.ec2-rds-sg.id}" ]
    }
  tags {
    Name = "roma-protoapp"
  }
}

resource "aws_security_group" "ec2-cache-sg" {
    name_prefix = "ec2-cache-sg"
    description = "ec2 instances joined to this group can access Postgres"

    egress {
        from_port       = "11211"
        to_port         = "11211"
        protocol        = "tcp"
    }
  tags {
    Name = "roma-protoapp"
  }
}

resource "aws_security_group" "cache-ec2-sg" {
    name_prefix = "cache-ec2-sg"
    description = "Allows cache-ec2-sg members access to elasticache"

    ingress {
        from_port       = "11211"
        to_port         = "11211"
        protocol        = "tcp"
        security_groups = [ "${aws_security_group.ec2-cache-sg.id}" ]
    }
  tags {
    Name = "roma-protoapp"
  }
}
