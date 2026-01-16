# Image officielle Node.js
FROM node:24-alpine

# Définir le dossier de travail
WORKDIR /app

# Copier les fichiers package.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du code
COPY . .

# Exposer le port utilisé par l'app
EXPOSE 8080

# Lancer l'application
CMD ["npm", "start"]
