FROM oven/bun:1 as base

WORKDIR /app

FROM base AS install
RUN mkdir -p /temp/prod
COPY package.json bun.lockb /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile --production

FROM base AS prerelease
COPY --from=install /temp/prod/node_modules node_modules
COPY . .

FROM base AS release
COPY --from=install /temp/prod/node_modules node_modules
COPY --from=prerelease /app/src ./src
COPY --from=prerelease /app/package.json .

# Run the application as a non-root user.
USER bun
# Expose the port that the application listens on.
EXPOSE 3000/tcp

# Run the application.
ENTRYPOINT [ "bun", "start" ]
