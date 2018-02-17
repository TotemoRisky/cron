package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"time"
)

func main() {
	//content := []byte(time.Now().Local().String())
	//ioutil.WriteFile("ok", content, os.ModePerm)

	html := []byte(`
<html>
  <head>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  </head>
<body>
  <div style="text-align: center;">
      <h1>Status</h1>
      <hr/>
    <div style="font-size: 70%;">VERSION:<span id="version"></span></div>
    <script type="text/javascript">
      fetch(
        "http://rawgit.com/onoie/status/master/VERSION",
        { method: "get" }
      )
      .then(res => res.text())
      .then(text => {
        document.getElementById("version").innerHTML = text;
      });
    </script>
  </div>
</body>
</html>
	`)
	ioutil.WriteFile("index.html", html, os.ModePerm)
	fmt.Println("complete")
}
