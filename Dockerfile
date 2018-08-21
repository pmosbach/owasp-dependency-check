FROM openjdk:8-alpine

LABEL org.label-schema.vcs-url="https://github.com/pmosbach/owasp-dependency-check"

ENV version_url=https://jeremylong.github.io/DependencyCheck/current.txt
ENV download_url=https://dl.bintray.com/jeremy-long/owasp

RUN apk update && \
    apk add bash curl wget ruby && \
    gem install bundler-audit --no-rdoc --no-ri && \
    gem cleanup && \
    apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    apk add --no-cache --virtual=.build-dependencies ca-certificates && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    apk del .build-dependencies && \
    rm -rf /tmp/* /var/cache/apk/* /usr/lib/ruby/gems/*/cache/*

RUN wget -q -O /tmp/current.txt ${version_url} && \
    version=$(cat /tmp/current.txt) && \
    file="dependency-check-${version}-release.zip" && \
    wget -q -O owasp.zip $download_url/$file && \
    unzip owasp.zip && \
    rm owasp.zip && \
    mv dependency-check /tmp/

RUN /tmp/dependency-check/bin/dependency-check.sh --updateonly

# This is intended to be a sane fallback, but you should override this via your .gitlab-ci.yml
CMD ["--scan","/builds","--format","ALL","--project","GENERIC","--enableExperimental"]
ENTRYPOINT ["/tmp/dependency-check/bin/dependency-check.sh"]