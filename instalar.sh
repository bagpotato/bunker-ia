#!/bin/bash

echo "[INFO] Iniciando despliegue de infraestructura de IA..."

# 1. Levantar contenedores
echo "[DOCKER] Levantando servicios..."
sudo docker compose up -d

# 2. Pausa para inicialización
echo "[STATUS] Esperando respuesta del servicio Ollama..."
sleep 5

# 3. Aprovisionamiento de modelos
echo "[MODEL 1] Descargando Qwen 2.5 Coder (1.5B)..."
sudo docker exec -it ollama ollama pull qwen2.5-coder:1.5b

echo "[MODEL 2] Descargando Gemma-3-1B-Thinking (HuggingFace)..."
sudo docker exec -it ollama ollama pull hf.co/Andycurrent/Gemma-3-1B-it-GLM-4.7-Flash-Heretic-Uncensored-Thinking_GGUF:latest

echo "[SUCCESS] Despliegue completado con exito."
echo "[URL] Acceso disponible en puerto 3000."
