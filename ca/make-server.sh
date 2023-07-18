#!/bin/bash
server=${1?"The server identity is required"}
cidr=${2?"The CIDR block of the server"}
subnet_mask=${3?"The subnet mask of the CIDR block"}
vpn_cidr=${4?"VPN CIDR"}
vpn_cidr_subnet_mask=${5?"VPN CIDR subnet mask"}

if [ ! -f ./pki/issued/${server}.crt ]
then
  ./easyrsa build-server-full ${server} nopass
fi
if [ ! -f ./pki/dh.pem ]
then
  ./easyrsa gen-dh
fi
if [ ! -f ./ta.key ]
then
  openvpn --genkey secret ta.key
fi

mkdir -p server
cp {ta.key,./pki/dh.pem,./pki/ca.crt,./pki/private/${server}.key,./pki/issued/${server}.crt} server
cd server
tee server.conf << END
port 1194
proto udp
dev tun
ca ca.crt
cert ${server}.crt
key ${server}.key  # This file should be kept secret
dh dh.pem
;server 10.8.0.0 255.255.255.0
server ${vpn_cidr} ${vpn_cidr_subnet_mask}
ifconfig-pool-persist /var/log/openvpn/ipp.txt
;push "route 10.0.0.0 255.255.0.0"
push "route ${cidr} ${subnet_mask}"
;push "redirect-gateway def1 bypass-dhcp"
;duplicate-cn
keepalive 10 120
tls-auth ta.key 0
;cipher AES-256-CBC
auth SHA512
;compress lz4-v2
;push "compress lz4-v2"
comp-lzo
user nobody
group nogroup
persist-key
persist-tun
status /var/log/openvpn/openvpn-status.log
;log         /var/log/openvpn/openvpn.log
;log-append  /var/log/openvpn/openvpn.log
verb 3
explicit-exit-notify 1
END

if [ -f ${server}.tar.gz ]
then
  rm ${server}.tar.gz
fi
tar -cvzf ${server}.tar.gz *
cd ..

