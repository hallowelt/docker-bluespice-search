FROM opensearchproject/opensearch:2

ENV discovery.type=single-node
ENV DISABLE_INSTALL_DEMO_CONFIG=true
ENV DISABLE_SECURITY_PLUGIN=true

USER root
COPY --chown=1000:0 --chmod=755 ./root-fs/app/bin /app/bin

RUN /usr/share/opensearch/bin/opensearch-plugin remove opensearch-security \
    && /usr/share/opensearch/bin/opensearch-plugin install --batch ingest-attachment \
    && chown -R 1000:0 /usr/share/opensearch \
    && chmod -R g=u /usr/share/opensearch /app/bin \
    && chmod g+s /usr/share/opensearch \
    && ln -sf /app/bin/removeROtag /usr/local/bin
# Support Arbitrary User IDs. See https://github.com/opensearch-project/opensearch-build/issues/3625
USER 1000

