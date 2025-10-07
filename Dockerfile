FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./
RUN npm install --production=false

# Copy source and build
COPY . .
RUN npm run build

# Production stage
FROM node:18-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# Copy built application
COPY --from=0 --chown=nextjs:nodejs /app/.next ./.next
COPY --from=0 --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=0 --chown=nextjs:nodejs /app/package.json ./package.json
COPY --from=0 --chown=nextjs:nodejs /app/public ./public

USER nextjs

EXPOSE 3000

ENV PORT=3000

CMD ["npm", "start"]
