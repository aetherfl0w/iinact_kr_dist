FROM nginx:alpine
COPY FFXIV_ACT_Plugin_*.zip /data/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
