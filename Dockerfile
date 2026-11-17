FROM node:22-alpine

WORKDIR /app

COPY package.json ./
# Vite 8 declares a newer optional esbuild peer than the version locked for
# the server bundle; Bun accepts this graph, so keep npm from rejecting it.
RUN npm install --legacy-peer-deps

COPY . .
RUN npm run build

ENV NODE_ENV=production
EXPOSE 80
CMD ["sh", "-c", "PORT=${PORT:-80} npm start"]
