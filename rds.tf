resource "aws_db_instance" "default" {
	allocated_storage    = 10
	name = "mydb"
	engine               = "mysql"
    engine_version       = "5.7"
	instance_class       = "db.t2.micro"
	username             = "foo"
	password             = "foobarbaz"
	parameter_group_name = "default.mysql5.7"
	deletion_protection = false
	skip_final_snapshot  = true
}

