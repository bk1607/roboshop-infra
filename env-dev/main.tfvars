instances = {
  frontend = {
    name = "frontend"
    type = "t3.micro"
    Monitor = "yes"
  }
  catalogue = {
    name = "catalogue"
    type = "t3.micro"
    Monitor = "yes"
  }
  user = {
    name = "user"
    type = "t3.micro"
    Monitor = "yes"
  }
  cart = {
    name = "cart"
    type = "t3.micro"
    Monitor = "yes"
  }
  shipping = {
    name = "shipping"
    type = "t3.micro"
    Monitor = "yes"
  }
  payment = {
    name = "payment"
    type = "t3.micro"
    Monitor = "yes"
  }
  redis = {
    name = "redis"
    type = "t3.micro"
  }
  mysql = {
    name = "mysql"
    type = "t3.micro"
  }
  mongodb = {
    name = "mongodb"
    type = "t3.micro"
  }
  rabbitmq = {
    name = "rabbitmq"
    type = "t3.micro"
  }
  dispatch = {
    name= "dispatch"
    type= "t3.micro"
    Monitor = "yes"
  }
}
env = "dev"