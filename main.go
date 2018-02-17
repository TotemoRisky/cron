package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"time"
)

func main() {
	content := []byte(time.Now().Local().String())
	ioutil.WriteFile("ok", content, os.ModePerm)
	html := []byte(`
<html>
<head></head>
<body><center>Status<ul><li><a href="latest.json">latest.json</a></li></ul></center></body>
</html>
	`)
	ioutil.WriteFile("index.html", html, os.ModePerm)
	fmt.Println("complete")
}