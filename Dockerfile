FROM java:8-alpine

ENV version_url=https://jeremylong.github.io/DependencyCheck/current.txt
ENV download_url=https://dl.bintray.com/jeremy-long/owasp

RUN apk update && \
    apk add bash curl wget && \
    rm -rf /tmp/* /var/cache/apk/*

RUN wget -q -O /tmp/current.txt ${version_url} && \
    version=$(cat /tmp/current.txt) && \
    file="dependency-check-${version}-release.zip" && \
    wget -q -O owasp.zip $download_url/$file && \
    unzip owasp.zip && \
    rm owasp.zip && \
    mv dependency-check /tmp/

RUN /tmp/dependency-check/bin/dependency-check.sh --updateonly

# This is intended to be a sane fallback, but you should override this via your .gitlab-ci.yml
CMD ["--scan","/builds","--format","ALL","--project","GENERIC"]
ENTRYPOINT ["/tmp/dependency-check/bin/dependency-check.sh"]