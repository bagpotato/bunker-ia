#!/bin/bash

# Inicio de despliegue de infraestructura IA
echo "[INFO] Iniciando servicios de Docker Compose..."
sudo docker compose up -d

# Tiempo de espera para inicializacion
echo "[INFO] Esperando respuesta de la API de Ollama..."
sleep 10

# Descarga de modelos
echo "[MODEL] Descargando Qwen 2.5 Coder 1.5B..."
sudo docker exec -it ollama ollama pull qwen2.5-coder:1.5b

echo "[MODEL] Descargando Gemma-3-1B Thinking..."
sudo docker exec -it ollama ollama pull hf.co/Andycurrent/Gemma-3-1B-it-GLM-4.7-Flash-Heretic-Uncensored-Thinking_GGUF:latest

echo "[SUCCESS] Instalacion finalizada."
