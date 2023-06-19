# Utilisez une image de base avec Python préinstallé
FROM python:3.11.0-slim

# Définissez le répertoire de travail dans l'image Docker
WORKDIR /app

# Installez les dépendances système nécessaires
RUN apt-get update \
    && apt-get install -y default-libmysqlclient-dev build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiez le fichier requirements.txt dans l'image
COPY requirements.txt .

# Installez les dépendances du projet Django
RUN pip install --no-cache-dir -r requirements.txt

# Copiez le reste du code source dans l'image
COPY . .

# Exposez le port sur lequel votre application Django écoute (par exemple, 8000)
EXPOSE 8000

# Définissez la commande par défaut pour lancer votre application Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]