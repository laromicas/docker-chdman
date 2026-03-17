FROM debian:trixie-slim

# Install modern MAME tools (includes a recent chdman with `createdvd` support)
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      mame-tools \
      bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the entrypoint so you only have to pass the chdman arguments
ENTRYPOINT ["chdman"]