#!/bin/bash

echo "[INFO] Iniciando despliegue de infraestructura de IA..."

# Verificacion de contenedores
echo "[DOCKER] Levantando servicios definidos en docker-compose.yml..."
sudo docker compose up -d

# Pausa de seguridad para inicializacion de API
echo "[STATUS] Esperando respuesta del servicio Ollama..."
sleep 5

# Aprovisionamiento de modelos
echo "[MODEL] Descargando Qwen 2.5 Coder (1.5B)..."
sudo docker exec -it ollama ollama pull qwen2.5-coder:1.5b

echo "[SUCCESS] Despliegue completado con exito."
echo "[URL] Acceso disponible en puerto 3000."
