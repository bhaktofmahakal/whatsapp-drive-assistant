# Alternative Dockerfile for custom n8n setup
FROM n8nio/n8n:latest

USER root

# Install additional dependencies if needed
RUN npm install -g @google-cloud/storage googleapis

# Switch back to n8n user
USER node

# Copy custom workflows and credentials
COPY --chown=node:node workflows/ /home/node/.n8n/workflows/
COPY --chown=node:node credentials/ /home/node/.n8n/credentials/

# Expose n8n port
EXPOSE 5678

CMD ["n8n", "start"]