# Utiliser une image de base Python plus légère
FROM python:3.9-slim

# Définir un argument de construction pour l'URL du modèle
ARG MODEL_URL=https://github.com/benob/recasepunc/releases/download/0.4/fr.24000
ARG MODEL_NAME=fr.24000

# Définir des variables d'environnement pour l'application
ENV MODEL_PATH=/app/recasepunc/checkpoints/${MODEL_NAME}

# Mettre à jour le système et installer git et curl seulement (moins de paquets installés)
RUN apt-get update && apt-get install -y git curl --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail pour l'application
WORKDIR /app

# Cloner le dépôt recasepunc depuis GitHub
RUN git clone https://github.com/benob/recasepunc.git

# Définir le répertoire de travail à l'intérieur du dépôt cloné
WORKDIR /app/recasepunc

# Installer les dépendances Python pour recasepunc
RUN pip install --no-cache-dir -r requirements.txt -f https://download.pytorch.org/whl/torch_stable.html

# Télécharger le modèle depuis l'URL spécifiée
RUN mkdir -p /app/recasepunc/checkpoints && \
    curl -L -o ${MODEL_PATH} ${MODEL_URL}

# Revenir au répertoire de travail de l'application
WORKDIR /app

# Installer Flask pour l'API
RUN pip install Flask

# Copier le script de l'application Flask
COPY app.py /app/app.py

# Exposer le port 5000 pour l'API Flask
EXPOSE 5000

# Définir le point d'entrée pour démarrer l'application Flask
CMD ["python", "/app/app.py"]
