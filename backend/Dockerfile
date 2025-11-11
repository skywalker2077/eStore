FROM node:18-alpine

WORKDIR /app

# Copiar package.json e yarn.lock
COPY package*.json ./
COPY yarn.lock* ./

# Instalar dependências
RUN yarn install --frozen-lockfile

# Copiar código fonte
COPY . .

# Expor porta
EXPOSE 3001

# Comando para iniciar
CMD ["yarn", "start"]
