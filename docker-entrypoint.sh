#!/bin/sh

mkdir /etc/config
mkdir /etc/certs

echo $USER":"$PASSWORD >> /etc/config/auth.txt

if [ "$USE_SAMPLE" = "true" ]; then
	echo 'Generating Website for ' $DOMAIN
	curl https://raw.githubusercontent.com/wuzhongyi1105/goproxy/master/html.zip -O
	unzip html.zip -d /var/www/html
fi

if [ ! -n "$DNS_SERVER" ];then
  DNS_SERVER="#dns_server = '"$DNS_SERVER"'"
  echo 'Disable DNS over TLS'
else
  DNS_SERVER="dns_server = '"$DNS_SERVER"'"
  echo 'Disable DNS over TLS'
fi

if [ ! -n "$HOSTS_FILE" ];then
  HOSTS_FILE="#dns_files = ['/etc/hosts', '/etc/config/hosts.txt']"
  echo 'Enable Hosts file'
else
  HOSTS_FILE="dns_files = ['/etc/hosts', '/etc/config/hosts.txt']"
  echo 'Enable Hosts file'
fi

cat <<EOF >/etc/config/production.toml
[default]
max_idle_conns = 100
dial_timeout = 30
dns_ttl = 1800
prefer_ipv6 = ${IPV6}
reject_intranet = true
allow_empty_sni = ${ALLOW_EMPTY_SNI}
#graceful_timeout = 300
${DNS_SERVER}
#dns_map = {'example.org'=['127.0.0.1', '127.0.1.1']}
${HOSTS_FILE}

[log]
level = 'info'
stderr = true
backups = 2
maxsize = 1073741824
localtime = true
rotate = 'daily'

[[${HTTP_MODE}]]
listen = ':${PORT_443}'
server_name = ['${DOMAIN}']
proxy_pass = '${BACKEND}'
auth_command = './auth --servername {servername} --username {username} --password {password} --remote {remote}'
EOF

/usr/bin/promvps/promvps /etc/config/production.toml

start_line=`sed -n -e '/BEGIN EC PRIVATE KEY/=' /Users/wzy/Desktop/banvz.dylanwu.space`
end_line=`sed -n -e '/END EC PRIVATE KEY/=' /Users/wzy/Desktop/banvz.dylanwu.space`
key_content=`cat /Users/wzy/Desktop/banvz.dylanwu.space | head -n $end_line |tail -n +$start_line`
cat <<EOF >/etc/certs/${DOMAIN}.key
${key_content}
EOF

start_line=`grep -n "BEGIN CERTIFICATE" /Users/wzy/Desktop/banvz.dylanwu.space | head -1 | cut -d ":" -f 1`
end_line=`grep -n "END CERTIFICATE" /Users/wzy/Desktop/banvz.dylanwu.space | head -1 | cut -d ":" -f 1`
cert_content=`cat /Users/wzy/Desktop/banvz.dylanwu.space | head -n $end_line |tail -n +$start_line`
cat <<EOF >/etc/certs/${DOMAIN}.crt
${cert_content}
EOF

