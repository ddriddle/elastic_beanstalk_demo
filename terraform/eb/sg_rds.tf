resource "aws_security_group" "ec2-rds-sg" {
    name_prefix = "ec2-rds-sg"
    description = "ec2 instances joined to this group can access Postgres"

    egress {
        from_port       = "5432"
        to_port         = "5432"
        protocol        = "tcp"
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
}
