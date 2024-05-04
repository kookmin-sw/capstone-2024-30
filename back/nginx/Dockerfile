FROM nginx
COPY test.conf.template /etc/nginx/conf.d/default.conf.template
ENTRYPOINT ["/bin/bash", "-c", "envsubst '${SERVER_NAME}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
