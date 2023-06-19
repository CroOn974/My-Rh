# Utilisez une image de base avec Node.js préinstallé (version 14.x)
FROM node:20.1.0-alpine

# Définissez le répertoire de travail dans l'image Docker
WORKDIR /app

# Copiez les fichiers package.json et package-lock.json
COPY package*.json ./

# Installez les dépendances du projet Vue.js
RUN npm install

# Copiez le reste du code source dans l'image
COPY . .

# Construisez votre application Vue.js pour la production
RUN npm run build

# Exposez le port sur lequel votre application Vue.js écoute (par exemple, 8080)
EXPOSE 8080

# Définissez la commande par défaut pour lancer votre application Vue.js
CMD ["npm", "run", "serve"]