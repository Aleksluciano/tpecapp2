# Etapa 1: builder
FROM node:22-alpine AS builder

WORKDIR /app

# Instalar dependências para compilar better-sqlite3
RUN apk add --no-cache python3 make g++ sqlite

# Copiar apenas package.json e package-lock.json para instalar dependências
COPY package*.json ./

# Instalar dependências (sem devDependencies)
RUN npm install --omit=dev \
    && npm uninstall better-sqlite3 || true \
    && npm install better-sqlite3 --build-from-source

# Copiar o restante do código
COPY . .

# Etapa 2: imagem final
FROM node:22-alpine

WORKDIR /app

# Instalar apenas runtime necessário
RUN apk add --no-cache sqlite

# Copiar os arquivos da etapa de build
COPY --from=builder /app /app

# Dar permissão de execução ao script
RUN chmod +x docker-entrypoint.sh

VOLUME ["/app/db.sqlite"]

EXPOSE 4004

ENTRYPOINT ["./docker-entrypoint.sh"]