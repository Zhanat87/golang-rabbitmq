package main

import "mypackage"

// npm i
// export GOPATH=$HOME/sites/microservices/golang-rabbitmq
// go run src/main.go
// gulp watch и можно менять код в go файле
func main() {
	println(mypackage.PublicVar)
	mypackage.PublicFunc()

}
