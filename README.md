# firewall_mars

Firewall for my own server mars

HOW TO INSTALL

$ sudo wget --no-check-certificate -O /etc/init.d/firewall.sh https://raw.githubusercontent.com/Honeyshell/firewall_mars/master/firewall.sh 
$ sudo chmod a+x /etc/init.d/firewall.sh 
$ sudo update-rc.d firewall.sh defaults 20

Redémarrer le serveur
$ sudo shutdown -r now
