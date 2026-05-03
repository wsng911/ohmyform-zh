FROM node:20-alpine AS ui

WORKDIR /app

RUN apk add --no-cache git bash g++ make libpng-dev && \
    git config --global user.email "dev@example.com" && \
    git config --global user.name "dev"

COPY ui/package.json ui/yarn.lock ./
RUN yarn install --frozen-lockfile

COPY ui/ ./
RUN yarn build

FROM node:20-alpine AS api

WORKDIR /app

RUN apk add --no-cache git bash g++ make libpng-dev python3

COPY api/package*.json ./
RUN npm install --production

COPY api/ ./

FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git && \
    git config --global user.email "dev@example.com" && \
    git config --global user.name "dev"

COPY --from=api /app ./api
COPY --from=ui /app/dist ./ui/dist

RUN git init && git add -A && git commit -m "init" || true

RUN mkdir -p /app/data

ENV NODE_ENV=production
ENV MONGODB_URI=mongodb://localhost:27017/ohmyform

EXPOSE 3000

CMD ["node", "api/dist/main.js"]
