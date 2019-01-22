# Pull the NodeJS 11 alpine image from DockerHub
FROM node:11-alpine

# Application metadata
LABEL VERSION="1.0.0"
LABEL AUTHOR="Harsha Kuchampudi"
LABEL AUTHOR_EMAIL="hkuchampudi@mail.usf.edu"
LABEL GITHUB="https://github.com/hkuchampudi/gab-server"

# Copy the source code into the /app directory
# which is set as the working directory
WORKDIR /app
COPY . .

# Set Environment variables
ENV TESTING="true"
ENV BIND_ADDRESS="0.0.0.0"

# NPM install PM2 dependnecy as well as
# dependencies for the applicaiton
RUN npm config set unsafe-perm true && \
    npm install -g pm2 && \
    npm install

CMD ["pm2-runtime", "start", "index.js"]