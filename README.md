## Prom
a bot with web server so you can autoupdate certs.

### Env
ENV DOMAIN=your.domain
ENV PORT_80=80
ENV PORT_443=443
ENV EMAIL=you@your.domain (Optional)
ENV USER=
ENV PASSWORD=
ENV USE_SAMPLE=true (Enable Random Website)
ENV BACKEND=file:///var/www/html
ENV ALLOW_EMPTY_SNI=true
ENV HTTP_MODE=http2 (http2 is compatible with Swtichomega, https is compatible with Shadowrocket or Surge)
ENV DNS_SERVER=
ENV HOSTS_FILE=

### Features
* tls1.3 + http2 + quic
* autocert(Let's Encrypt) support
* share certs with HyperApp
* a ramdom website
* custom dns server support
* dns over tls support
* hosts file support

### Installation
```
docker run
```

### Configuraion
see [example.toml](example.toml)

### Tuning
see [sysctl.conf](https://phuslu.github.io/sysctl.conf)

### Build
```
docker build
```
