resource "aws_secretmanager_secret" "access_key" {
    name = "aws_access_key"
}

resource "aws_secretmanager_secret" "secret_key" {
    name = "aws_secret_key"
}