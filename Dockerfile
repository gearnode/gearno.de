FROM alpine:3.4
RUN apk add --update nginx && rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/nginx/client-body

# Create folder for nginx PID
RUN mkdir -p /run/nginx

CMD ["nginx", "-g", "daemon off;"]
