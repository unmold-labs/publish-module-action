FROM quay.io/unmold/unmold-cli:latest

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use exec form; the script's shebang is /bin/sh so it will run in the container
ENTRYPOINT ["/entrypoint.sh"]
