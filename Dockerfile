FROM ghost:6-alpine
EXPOSE 2368
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget -qO- http://localhost:2368/ghost/ || exit 1
