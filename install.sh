#!/data/data/com.termux/files/usr/bin/bash

# device arch
DEVICE_ARCH=$(uname -m)
# echo $DEVICE_ARCH

# which country
COUNTRY=$(curl -s "http://api.ipaddress.com/iptocountry?format=txt")

if [ "$COUNTRY" = "CN" ]
then
    echo "You are in China, switching to tuna mirrors..."
     SOURCES_OLD=/data/data/com.termux/files/usr/etc/apt/sources.list
     SOURCES_NEW=/data/data/com.termux/files/usr/etc/apt/sources.list.bak
     if [ -f "$SOURCES_OLD" ]; then  # backup
        cp $SOURCES_OLD $SOURCES_NEW
        echo $SOURCES_OLD" ---> "$SOURCES_NEW" ok!"
     fi
    # update  to tsinghua :)
    echo "deb [arch=all,"$DEVICE_ARCH"] http://mirrors.tuna.tsinghua.edu.cn/termux stable main" > $SOURCES_OLD
    apt update && echo "update cache success"
fi

if [ ! -f /data/data/com.termux/files/home/ngrok]
then
    case $DEVICE_ARCH in
        arm | aarch64)
            NGROK_URL=https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
        ;;
        i686)
            NGROK_URL=https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
        ;;
        x86_64)
            NGROK_URL=https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
        ;;
        *)
            echo "Unknown arch detected"
            exit 1
        ;;
    esac

    echo "ngrok download url: "$NGROK_URL
    curl -o /data/data/com.termux/files/home/ngrok.zip $NGROK_URL
    unzip /data/data/com.termux/files/home/ngrok.zip
fi

echo "a. apache,    b. nginx,    c. python simple HTTP server"

while true
do
    read -p "which backend of webserver would you prefer?    " OPTION
    case $OPTION in
        a | b | c | A | B | C )
        break
    ;;
        *)
        continue
    ;;
    esac
done

case $OPTION in
    a | A)
        apt install -y apache2 && nohup httpd 1>/dev/null 2>&1 &
    ;;
    b | B)
        apt install -y nginx && nohup nginx 1>/dev/null 2>&1 &
    ;;
    c | C)
        nohup python -m http.server 8080 1>/dev/null 2>&1 &
    ;;
    *)
        break
    ;;
esac

chmod 755 /data/data/com.termux/files/home/ngrok
./ngrok http 8080