[default]
max_idle_conns = 100
dial_timeout = 30
dns_ttl = 1800
prefer_ipv6 = false
reject_intranet = false

[[http2]]
listen = ":443"
server_name = ["example.org"]
keyfile = "example.org.key"
certfile = "example.org.cer/fullchain.cer"
proxy_pass = "file:///var/www/html"
enable_pprof = true
enable_metrics = true
