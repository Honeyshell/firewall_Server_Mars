
#!/bin/sh

# information (install sans github)
# 1 - créer le fichier sous /etc/init.d/firewall
# 2 - donner les droits : 
#		$ sudo chmod +x /etc/init.d/firewall
# 3	- tester le firewall avec la commande : 
#		$ sudo /etc/init.d/firewall
# 4 - Indiquer d'exécuter le script au démarrage
#		$ sudo update-rc.d firewall defaults 20
# 5 - Démarrage du firewall
#       $ sudo service firewall start

# information avec github
# $ sudo wget --no-check-certificate -O /etc/init.d/firewall.sh https://raw.github.com/honeyshell/firewall_mars/firewall.sh 
# $ sudo chmod a+x /etc/init.d/firewall.sh 
# $ sudo update-rc.d firewall.sh defaults 20 
# $ sudo service firewall start


# On efface les règles précédentes pour partir sur de bonnes bases
sudo iptables -t filter -F 
sudo iptables -t filter -X

# On bloque par défaut tout le trafic 
sudo iptables -t filter -P INPUT DROP 
sudo iptables -t filter -P FORWARD DROP 
sudo iptables -t filter -P OUTPUT DROP

# On ne ferme pas les connexions déjà établies
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
sudo iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# On autorise le loopback
sudo iptables -t filter -A INPUT -i lo -j ACCEPT 
sudo iptables -t filter -A OUTPUT -o lo -j ACCEPT


# Ouvrir les ports utilisés : 

# ICMP (Ping)
sudo iptables -t filter -A INPUT -p icmp -j ACCEPT 
sudo iptables -t filter -A OUTPUT -p icmp -j ACCEPT 
 
# SSH / HTTPS
sudo iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT 
sudo iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT 

# Transmission
sudo iptables -t filter -A OUTPUT -p tcp --dport 6001 -j ACCEPT 
sudo iptables -t filter -A INPUT -p tcp --dport 6001 -j ACCEPT
 
# DNS
sudo iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT 
sudo iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT 
sudo iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT 
sudo iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT 
 
# HTTP
sudo iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT 
sudo iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT 

# FTP 
# sudo iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT 
# sudo iptables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT 

# Mail SMTP 
# iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT 
# iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT 
 
# Mail POP3
# iptables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT 
# iptables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT 
 
# Mail IMAP
# iptables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT 
# iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT 

# NTP (horloge du serveur) 
sudo iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT

# service		port d’écoute 	protocole
# ssh			22				tcp
# web/HTTP		80				tcp
# FTP			20 et 21		tcp
# mail/SMTP		25				tcp
# mail/POP3		110				tcp
# mail/IMAP		143				tcp
# DNS			53				tcp et udp









