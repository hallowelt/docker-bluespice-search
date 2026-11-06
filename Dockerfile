FROM opensearchproject/opensearch:2

ENV discovery.type=single-node
ENV DISABLE_INSTALL_DEMO_CONFIG=true
ENV DISABLE_SECURITY_PLUGIN=true
USER root
COPY --chown=opensearch:opensearch --chmod=755 ./root-fs/app/bin /app/bin
RUN ln -sf /app/bin/removeROtag /usr/local/bin \
 && /usr/share/opensearch/bin/opensearch-plugin install \
      --batch ingest-attachment \
 && /usr/share/opensearch/bin/opensearch-plugin remove \
      opensearch-security \
 && mkdir -p \
      /usr/share/opensearch/data \
      /usr/share/opensearch/logs \
      /usr/share/opensearch/tmp \
 && chgrp -R 0 \
      /usr/share/opensearch/data \
      /usr/share/opensearch/logs \
      /usr/share/opensearch/tmp \
 && chmod -R g=u \
      /usr/share/opensearch/data \
      /usr/share/opensearch/logs \
      /usr/share/opensearch/tmp

# Build info: value of build arg BUILDINFO, falls back to the UTC build timestamp (YmdHis)
ARG BUILDINFO
RUN mkdir -p /image && echo "${BUILDINFO:-$(date -u +%Y%m%d%H%M%S)}" > /image/BUILDINFO

USER 1000


