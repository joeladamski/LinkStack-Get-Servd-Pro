FROM linkstackorg/linkstack:latest

USER root

COPY --chown=apache:apache . /opt/linkstack-fork
COPY --chmod=755 docker-entrypoint-fork.sh /usr/local/bin/docker-entrypoint-fork.sh

USER apache:apache
WORKDIR /htdocs

CMD ["docker-entrypoint-fork.sh"]
