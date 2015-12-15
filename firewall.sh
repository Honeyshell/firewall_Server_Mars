
#!/bin/sh

### BEGIN INIT INFO
# Provides:          firewall.sh
# Required-Start:    $syslog $network
# Required-Stop:     $syslog $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start firewall daemon at boot time
# Description:       Personalised Firewall scrip.
### END INIT INFO

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
/sbin/iptables -t filter -F 
/sbin/iptables -t filter -X

# On bloque par défaut tout le trafic 
/sbin/iptables -t filter -P INPUT DROP 
/sbin/iptables -t filter -P FORWARD DROP 
/sbin/iptables -t filter -P OUTPUT DROP

# On ne ferme pas les connexions déjà établies
/sbin/iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
/sbin/iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# On autorise le loopback
/sbin/iptables -t filter -A INPUT -i lo -j ACCEPT 
/sbin/iptables -t filter -A OUTPUT -o lo -j ACCEPT


# Ouvrir les ports utilisés : 

# ICMP (Ping)
/sbin/iptables -t filter -A INPUT -p icmp -j ACCEPT 
/sbin/iptables -t filter -A OUTPUT -p icmp -j ACCEPT 
 
# SSH / HTTPS
/sbin/iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT 
/sbin/iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT 

# Transmission
/sbin/iptables -t filter -A OUTPUT -p tcp --dport 6001 -j ACCEPT 
/sbin/iptables -t filter -A INPUT -p tcp --dport 6001 -j ACCEPT
 
# DNS
/sbin/iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT 
/sbin/iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT 
/sbin/iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT 
/sbin/iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT 
 
# HTTP
/sbin/iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT 
/sbin/iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT 

# FTP 
# /sbin/iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT 
# /sbin/iptables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT 

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
/sbin/iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT

# service		port d’écoute 	protocole
# ssh			22				tcp
# web/HTTP		80				tcp
# FTP			20 et 21		tcp
# mail/SMTP		25				tcp
# mail/POP3		110				tcp
# mail/IMAP		143				tcp
# DNS			53				tcp et udp

# Flood ou déni de service
/sbin/iptables -A FORWARD -p tcp --syn -m limit --limit 1/second -j ACCEPT
/sbin/iptables -A FORWARD -p udp -m limit --limit 1/second -j ACCEPT
/sbin/iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/second -j ACCEPT









