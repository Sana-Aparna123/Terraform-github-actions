# #Creating three s3 buckets using count variable or function
# resource "aws_s3_bucket" "terraform-bucket-new" {
#   count         = var.bucket_count #-->it will create three buckets based on indexes [0,1,2]
#   bucket        = "terraform-bucket-new-${count.index+1}"
#   force_destroy = true #-->even if its contains data it will deleted.
#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }


# #after buckets is created then only it addes the packer_001.zip file into buckets.
# resource "aws_s3_object" "object" {
#   count  = var.bucket_count # 0, 1, 2
#   bucket = "terraform-bucket-new-${count.index+1}"
#   key    = "packer_00${count.index+1}.zip"
#   source = "packer_001.zip"
#   depends_on = [ aws_s3_bucket.terraform-bucket-new ]
# }