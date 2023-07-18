#!/bin/sh

##
## Usage: ./make-ovpn.sh SERVER CA_CERT CLIENT_CERT CLIENT_KEY SHARED_SECRET > client.ovpn
##
client=${1?"The client identity is required"}
server_ip=${2?"The server FQDN or IP is required"}
if [ ! -f ./pki/issued/${client}.crt ]
then
   ./easyrsa build-client-full ${client} nopass
fi

cat << EOF
client
dev tun
remote ${server_ip}
resolv-retry infinite
nobind
user nobody
group nobody
persist-key
persist-tun
ca [inline]
cert [inline]
key [inline]
tls-auth [inline] 1
verb 3
keepalive 10 120
port 1194
proto udp
;cipher AES-256-CBC
auth SHA512
comp-lzo
remote-cert-tls server
<ca>
EOF
cat ./pki/ca.crt
cat << EOF
</ca>
<cert>
EOF
cat ./pki/issued/${client}.crt
cat << EOF
</cert>
<key>
EOF
cat ./pki/private/${client}.key
cat << EOF
</key>
<tls-auth>
EOF
cat ./ta.key
cat << EOF
</tls-auth>
EOF
