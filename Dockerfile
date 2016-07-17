FROM alpine:3.4
RUN apk add --update nginx && rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/nginx/client-body

COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/website.conf /etc/nginx/sites-enabled/gearnode.conf
COPY config/nginx/default.conf /etc/nginx/sites-enabled/default.conf

COPY _site/ /home/gearnode

# Create folder for nginx PID
RUN mkdir -p /var/run/nginx

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
