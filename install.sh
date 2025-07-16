#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables (Replace with your domain and local IP)
DOMAIN="local.meet.jitsi.com"
PRIVATE_IP=$(hostname -I | awk '{print $1}')  # Automatically detect the primary private IP

# Update system
apt update && apt upgrade -y

# Enable Universe repository
apt-add-repository universe
apt update

# Install required dependencies
apt install -y gnupg2 nginx-full curl apt-transport-https lua5.2 ufw

# Add Prosody repository
curl -sL https://prosody.im/files/prosody-debian-packages.key -o /usr/share/keyrings/prosody-debian-packages.key
echo "deb [signed-by=/usr/share/keyrings/prosody-debian-packages.key] http://packages.prosody.im/debian $(lsb_release -sc) main" > /etc/apt/sources.list.d/prosody-debian-packages.list

# Add Jitsi repository
curl -sL https://download.jitsi.org/jitsi-key.gpg.key | gpg --dearmor -o /usr/share/keyrings/jitsi-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/jitsi-keyring.gpg] https://download.jitsi.org stable/" > /etc/apt/sources.list.d/jitsi-stable.list

# Update repositories again
apt update

# Set hostname
hostnamectl set-hostname "$DOMAIN"
echo "127.0.0.1 localhost" >> /etc/hosts
echo "$PRIVATE_IP $DOMAIN" >> /etc/hosts

# Configure firewall
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 10000/udp
ufw allow 22/tcp
ufw allow 3478/udp
ufw allow 5349/tcp
ufw --force enable

# Install Jitsi Meet
apt install -y jitsi-meet

# Setup SSL certificate using Let's Encrypt (non-interactive)
/usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh

echo "✅ Jitsi Meet installation complete!"
echo "Visit https://$DOMAIN to start using your video conferencing server."
