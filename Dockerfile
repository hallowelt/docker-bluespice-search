FROM opensearchproject/opensearch:2

ENV discovery.type=single-node
ENV DISABLE_INSTALL_DEMO_CONFIG=true
ENV DISABLE_SECURITY_PLUGIN=true
USER root
COPY --chown=opensearch:opensearch --chmod=755 ./root-fs/app/bin /app/bin
RUN ln -sf /app/bin/removeROtag /usr/local/bin
USER 1000
RUN /usr/share/opensearch/bin/opensearch-plugin install --batch ingest-attachment

RUN chown -R 1000:0 /usr/share/opensearch /app/bin
RUN chmod -R g=u /usr/share/opensearch /app/bin
RUN chmod g+s /usr/share/opensearch
