resource "local_file" "file1" {
  filename = "one.txt"
  content  = var.text
}

resource "local_file" "file2" {
  filename = "second.txt"
  content  = var.text2
}

resource "local_file" "test" {
  filename = "HELLOOO.txt"
  content  = "Terraform finally works"
}

