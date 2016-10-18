resource "aws_db_instance" "rds" {
    allocated_storage           = "10" # 10 GBS
    engine                      = "postgres"
    engine_version              = "9.4.1"
    instance_class              = "db.t2.micro"
    name                        = "postgres"
    username                    = "postgres"
    password                    = "postgres"

    vpc_security_group_ids      = [
        "${aws_security_group.rds-ec2-sg.id}",
    ]

    # Disable snapshots
    skip_final_snapshot         = "True"
    backup_retention_period     = 0

    # Apply all database modifications immediately
    apply_immediately = "True"

    #       begin:  07:00 UTC -> 01:00 CST or 02:00 CDT.
    #       end:    08:00 UTC -> 02:00 CST or 03:00 CDT.
    backup_window               = "07:00-08:00"
    #   Maintenance definitions. Times are expressed in UTC.
    #       begin:  09:00 UTC -> 03:00 CST or 04:00 CDT.
    #       end:    10:00 UTC -> 04:00 CST or 05:00 CDT.
    maintenance_window          = "Sun:09:00-Sun:10:00"
}
