FROM node:18

# Prevent CI prompts
ENV CI=true

# Enable pnpm
RUN npm install -g corepack@latest
RUN corepack enable
RUN corepack prepare pnpm@10.2.1 --activate

WORKDIR /app

COPY pnpm-workspace.yaml ./
COPY pnpm-lock.yaml ./
COPY package.json ./

COPY ./shared-interfaces ./shared-interfaces
COPY ./frontend/package.json ./frontend/


RUN pnpm install --no-frozen-lockfile

COPY ./frontend ./frontend

RUN mkdir -p /app/logs && chmod 755 /app/logs

WORKDIR /app/frontend

EXPOSE 3001

CMD ["pnpm", "run", "dev", "--host"]
