FROM node:22-alpine AS build
WORKDIR /app
RUN corepack enable && corepack prepare pnpm@10.15.0 --activate
COPY . .
RUN pnpm install
ARG VITE_KEYGEN_ACCOUNT_ID=f18c8e0a-5792-43c7-bbec-e9fb32766107
ARG VITE_KEYGEN_EDITION=CE
ARG VITE_KEYGEN_MODE=singleplayer
ARG VITE_KEYGEN_HOST=licensing.tolearn.online
ARG VITE_KEYGEN_VERSION=1.8
RUN pnpm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
