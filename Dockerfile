FROM nginx

COPY nginx.conf /etc/nginx/conf.d/default.template
ENV PROXY_TARGET https://google.com
RUN mkdir -p /var/cache/nginx/ && \
  chown -R 1000001 /var/cache/nginx && \
  touch /var/run/nginx.pid && chown 1000001 /var/run/nginx.pid && \
  chown -R 1000001 /etc/nginx/conf.d/ && \
  mkdir /nginxcache && chown 1000001 /nginxcache

EXPOSE 8000

USER 1000001

CMD /bin/sh -c "envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
