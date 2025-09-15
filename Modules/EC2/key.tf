resource "aws_key_pair" "key" {
    key_name = "Project_key"
    public_key = file("./Modules/Key/project.pub")

}