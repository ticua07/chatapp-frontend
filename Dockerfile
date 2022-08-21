FROM node:lts-alpine3.16

WORKDIR /app

# COPY *.js /app/
# COPY *.json /app/
# COPY .prettier* /app/
# COPY .eslint* /app/
# COPY /src /app/
# COPY /static /app/

COPY . /app/

# Make sure npm has the latest version
RUN npm install -g npm@latest
#* If you are building your code for production
#* RUN npm ci --only=production
RUN npm install
RUN npm run vite-build

EXPOSE 4173
CMD [ "npm", "run", "vite-preview" ] 