#! /bin/sh
# Remember to install and run dos2unix on this file

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

printf "${BLUE}--== Updating OS ==--${NC}\n"
apt-get update
apt-get upgrade -y

printf "${BLUE}--== Configure Network ==--${NC}\n"
echo "# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto enp0s3
iface enp0s3 inet static
address 192.168.0.51
netmask 255.255.255.0
gateway 192.168.0.1
dns-nameservers 192.168.0.50 194.168.4.100 194.168.8.100
dns-domain localdomain.vm
dns-search localdomain.vm" > /etc/network/interfaces

ip addr flush enp0s3
systemctl restart networking.service

printf "${BLUE}--=== Installing Firewall ===--${NC}\n"
apt install -y firewalld
systemctl start firewalld
systemctl enable firewalld

printf "${PURPLE}--=== Installing ELK ===--${NC}\n"
echo "Getting GPG Key..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "Adding apt source..."
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
apt-get update
echo "Installing JRE..."
apt install default-jre -y
echo "Installing ELKBEE Stack..."
apt install -y elasticsearch logstash kibana metricbeat filebeat heartbeat packetbeat

echo "Configuring Firewall for ELKBEE..."
firewall-cmd --permanent --add-port=9200/tcp
firewall-cmd --permanent --add-port=5601/tcp
firewall-cmd --reload

printf "${GREEN}--=== Complete ===--${NC}\n"