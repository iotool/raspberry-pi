#!/usr/bin/env bash
# 
# chmod +x raspi-install-tor-proxy.sh
# sudo bash raspi-install-tor-proxy.sh
# 
# sudo systemctl status tor.service
# sudo systemctl status tor@default.service
# sudo systemctl restart tor@default.service
# sudo service tor@default restart
# sudo service polipo restart
# 
echo "raspi-install-tor-proxy.sh"

# update system
sudo apt-get update && sudo apt-get upgrade

# install lynx browser
sudo apt-get install lynx

# install elinks browser
sudo apt-get install elinks

# install w3m browser
sudo apt-get install w3m

# install tor network
sudo apt-get install tor
sudo chmod go+w /etc/tor/torrc
sudo echo "SocksPort 127.0.0.1:9050" > /etc/tor/torrc
sudo echo "SocksPolicy accept 127.0.0.1/1" >> /etc/tor/torrc
sudo echo "RunAsDaemon 1" >> /etc/tor/torrc
sudo echo "DataDirectory /var/lib/tor" >> /etc/tor/torrc
sudo echo "ControlPort 9051" >> /etc/tor/torrc
sudo echo "CookieAuthentication 1" >> /etc/tor/torrc
sudo service tor@default restart

# install nyx tor-monitor (start with nyx)
sudo apt-get install nyx
sudo chmod 755 /run/tor/control.authcookie

# install http proxy
sudo apt-get install polipo
sudo chmod go+w /etc/polipo/config
sudo echo "# proxy http to socks" > /etc/polipo/config
sudo echo "socksParentProxy = \"127.0.0.1:9050\"" >> /etc/polipo/config
sudo echo "socksProxyType = socks5" >> /etc/polipo/config
sudo echo "proxyAddress = \"::0\"" >> /etc/polipo/config
sudo echo "proxyPort = 8123" >> /etc/polipo/config
sudo sync
sudo chmod go-w /etc/polipo/config
sudo service polipo restart

# browse source
sudo curl --proxy http://127.0.0.1:8123 https://check.torproject.org/
export http_proxy="http://127.0.0.1:8123"
export https_proxy="http://127.0.0.1:8123"
cd /tmp
sudo wget https://check.torproject.org/

# browse dialoge
export http_proxy="http://127.0.0.1:8123"
export https_proxy="http://127.0.0.1:8123"
sudo lynx https://check.torproject.org/
sudo elinks https://check.torproject.org/
sudo w3m https://check.torproject.org/
