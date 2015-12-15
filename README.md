# firewall_mars

Firewall for my own server mars

HOW TO INSTALL

$ sudo wget --no-check-certificate -O /etc/init.d/firewall.sh https://raw.github.com/honeyshell/firewall_mars/firewall.sh 
$ sudo chmod a+x /etc/init.d/firewall.sh 
$ sudo update-rc.d firewall.sh defaults 20 
$ sudo service firewall start
