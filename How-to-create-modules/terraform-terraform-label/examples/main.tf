module "label" {
  source      = "../"
  namespace   = "foo"
  environment = "dev"
  name        = "resource"
  delimiter   = "-"
}

