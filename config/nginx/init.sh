#!bin/sh

mkdir -p /etc/ngnix/ssl

# Generate ticket and dhparam certificate for nginx session
openssl rand 48 -out /etc/ngnix/ssl/ticket.key
openssl dhparam -out /etc/ngnix/ssl/dhparam4.key 4096

# Request Let's Encrypt certificate
docker run -it --rm --name letsencrypt \
  -v "/etc/letsencrypt:/etc/letsencrypt" \
  -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
  --volumes-from web \
  quay.io/letsencrypt/letsencrypt \
  certonly \
  --webroot \
  --webroot-path /var/www/{{ domain }} \
  --agree-tos \
  --renew-by-default \
  -d gearnode.me \
  -m bfrimin@me.com
  --rsa-key-size 4096

# Run webapp
docker run --rm -p 80:80 -p 443:443 --name web -v /etc/letsencrypt:/etc/letsencrypt/ -v /etc/ngnix/ssl:/etc/ngnix/ssl gearnode:latest