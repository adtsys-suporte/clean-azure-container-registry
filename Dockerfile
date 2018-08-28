FROM microsoft/azure-cli
RUN apk add --no-cache docker jq

ADD clean.sh /
ENTRYPOINT [ "/clean.sh" ]
