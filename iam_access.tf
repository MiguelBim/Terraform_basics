
# EVERYTHING IS COMMENTED OUT SO WE DO NOT MANAGE IAM USERS ON THIS PROJECT

# # IAM

# # Group creation
# resource "aws_iam_group" "administradores"{
#     name = "Administradores"
# }

# # Policy attachment
# # https://www.terraform.io/docs/providers/aws/r/iam_policy_attachment.html
# resource "aws_iam_policy_attachment" "admins-attach"{
#     name = "admins-attach"
#     groups = [aws_iam_group.administradores.name]
#     policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
#     # The policy arn is gotten directly from AWS in the policy details
# }

# # Users creation
# resource "aws_iam_user" "admin1" {
#     name = "admin1"
# }

# resource "aws_iam_user" "admin2" {
#     name = "admin2"
# }

# # Adding these users to the created group
# resource "aws_iam_group_membership" "admins-users"{
#     name = "admins-users"
#     users = [
#         aws_iam_user.admin1.name,
#         aws_iam_user.admin2.name,
#     ]
#     group = aws_iam_group.administradores.name
# }


# # Secret and access key for the users
# resource "aws_iam_access_key" "admin1-access"{
#     user = aws_iam_user.admin1.name
# }

# resource "aws_iam_access_key" "admin2-access"{
#     user = aws_iam_user.admin2.name
# }

# # The keys are displayed by terraform at the end of the creation.
# # To obatin them we use output.
# # Output values are like the return values of a Terraform module
# # https://www.terraform.io/docs/configuration/outputs.html
# output "admin1_access_key" {
#   value = "${aws_iam_access_key.admin1-access.id}"
# }
# output "admin1_secret_key" {
#   value = "${aws_iam_access_key.admin1-access.secret}"
# }

# # User 2
# output "admin2_access_key" {
#   value = "${aws_iam_access_key.admin2-access.id}"
# }
# output "admin2_secret_key" {
#   value = "${aws_iam_access_key.admin2-access.encrypted_secret}" # Using encrypted_secret, the val is not displayed
# }
# # IMPORTANT
# # For some reason, when using the function "output", it is necessary to use the old syntax "${}"
# # otherwise, it will not display the values correctly