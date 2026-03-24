cat <<'EOF' > ~/ia-bunker/instalar.sh
#!/bin/bash

echo "🛡️ Iniciando instalación del Búnker IA..."

# 1. Levantar los contenedores
echo "🐳 Levantando Docker Compose..."
sudo docker compose up -d

# 2. Esperar a que Ollama esté listo
echo "⏳ Esperando a que el motor Ollama arranque..."
sleep 5

# 3. Descargar el cerebro (Qwen 2.5 Coder)
echo "🧠 Descargando Qwen 2.5 Coder (1.5B)..."
sudo docker exec -it ollama ollama pull qwen2.5-coder:1.5b

# 4. Recordatorio de Tailscale
echo "🌐 Recuerda tener Tailscale activo para acceso remoto."
echo "✅ ¡Instalación completada! Accede en: http://localhost:3000"
EOF


