# ---------- Builder ----------
FROM node:20-alpine AS builder
WORKDIR /app
COPY backend/package*.json ./
RUN npm ci
COPY backend/ .
RUN NODE_OPTIONS="--max-old-space-size=4096" npm run build && npm prune --production

# ---------- Runtime ----------
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production
# Copy only prod deps and built files
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
# Port your app listens on internally
ENV PORT=3000
EXPOSE 3000
CMD ["node", "dist/index.js"]
