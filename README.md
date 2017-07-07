# termux webserver with ngrok

#### how to make things right

- install termux android app from google appstore
- start termux app on your android and wait for the installation to finish
- update , install curl with:

```apt update && apt install -y curl```

- download the script and execute it with the command below and wait for a while:

```sh -c "$(curl -fsSL https://raw.githubusercontent.com/brunobell/termux_webserver_with_ngrok/master/install.sh)"```

- when you are done with the contemporary mobile server, remember to shut apache/nginx server down with pkill