FROM microsoft/azure-cli

ADD clean.sh /
ENTRYPOINT [ "/clean.sh" ]
RUN apk add --no-cache docker jq && chmod +x /clean.sh
