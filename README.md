# Guía de Despliegue de IA Local con Ollama, Docker y Tailscale

Este repositorio contiene la configuración necesaria para desplegar un entorno de Inteligencia Artificial privado, seguro y accesible desde cualquier lugar sin necesidad de abrir puertos en su router.

## Tabla de Contenidos
1. [Requisitos Previos](#requisitos-previos)
2. [Instalación de Docker](#1-instalación-de-docker)
3. [Instalación de Ollama](#2-instalación-de-ollama)
4. [Interfaz Web con Docker](#3-interfaz-web-con-docker)
5. [Acceso Remoto con Tailscale (Crítico)](#4-acceso-remoto-con-tailscale-crítico)
6. [Uso y Comandos Útiles](#5-uso-y-comandos-útiles)

---

## Requisitos Previos
* **Sistema Operativo:** Linux (Ubuntu recomendado), Windows (WSL2) o macOS.
* **Hardware:** Mínimo 8GB de RAM (16GB o más recomendado para modelos de 7B o superiores).
* **GPU (Opcional):** NVIDIA con drivers actualizados para aceleración por hardware.

---

## 1. Instalación de Docker
Docker es fundamental para aislar los servicios y facilitar la actualización de la interfaz web y otros componentes del sistema.

### En Linux (Ubuntu/Debian)
```bash
# Actualizar sistema e instalar dependencias
sudo apt update && sudo apt upgrade -y
sudo apt install ca-certificates curl gnupg lsb-release

# Añadir llave oficial de Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Configurar repositorio oficial
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker Engine y Compose
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Permitir uso sin privilegios de root (Opcional)
sudo usermod -aG docker $USER
```

---

## 2. Instalación de Ollama
Ollama es el motor que ejecuta los modelos de lenguaje (LLMs) de forma eficiente en el servidor local.

### Instalación Directa
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### Configuración de Red para Ollama
Para que Ollama acepte conexiones externas (indispensable para la interfaz web en Docker y acceso remoto), se debe editar el servicio:

1. Ejecutar: `sudo systemctl edit ollama.service`
2. Insertar el siguiente contenido:
   ```ini
   [Service]
   Environment="OLLAMA_HOST=0.0.0.0"
   Environment="OLLAMA_ORIGINS=*"
   ```
3. Reiniciar el servicio para aplicar cambios:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl restart ollama
   ```

---

## 3. Interfaz Web con Docker
Utilizaremos **Open WebUI** para obtener una experiencia de usuario optimizada, similar a plataformas comerciales pero con ejecución 100% local.

Cree un archivo `docker-compose.yaml` en la raíz de este proyecto:

```yaml
services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: always
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://host.docker.internal:11434
    extra_hosts:
      - "host.docker.internal:host-gateway"
    volumes:
      - open-webui:/app/backend/data

volumes:
  open-webui:
```

Para iniciar el contenedor, ejecute: `docker compose up -d`

---

## 4. Acceso Remoto con Tailscale (Crítico)
Tailscale es la pieza clave para la seguridad y portabilidad del proyecto. Crea una red privada virtual (VPN Mesh) que permite acceder al servidor desde cualquier lugar sin exponer el equipo a internet.

### Ventajas de implementar Tailscale
* **Seguridad:** No requiere la apertura de puertos en el router (Port Forwarding), eliminando vectores de ataque externos.
* **IP Estática Interna:** El servidor recibe una IP fija dentro de la red privada (ej. 100.x.y.z) que no cambia aunque se mueva de ubicación física.
* **Cifrado E2E:** Todo el tráfico entre sus dispositivos está cifrado de extremo a extremo.

### Configuración:
1. **Instalación en el servidor:**
   ```bash
   curl -fsSL https://tailscale.com/install.sh | sh
   sudo tailscale up
   ```
2. **Obtención de la IP privada:**
   Ejecute `tailscale ip -4`. Use esta dirección para conectarse desde otros dispositivos.
3. **Acceso remoto:**
   Instale Tailscale en su dispositivo móvil o laptop. Una vez activo, podrá acceder a la interfaz web mediante:
   `http://[IP-DE-TAILSCALE]:3000`

---

## 5. Uso y Comandos Útiles

### Gestión de Modelos
Es necesario descargar los modelos manualmente antes de su primer uso:
```bash
ollama pull llama3       # Modelo equilibrado de Meta
ollama pull mistral      # Optimizado para eficiencia
ollama pull llava        # Modelo multimodal (soporta imágenes)
```

### Mantenimiento de la Interfaz
* **Ver registros de actividad:** `docker logs -f open-webui`
* **Actualizar a la última versión:**
  ```bash
  docker compose pull
  docker compose up -d
  ```

### Diagnóstico de Red
Para confirmar que el acceso remoto es funcional, verifique que puede realizar un ping a la IP de Tailscale desde un dispositivo externo conectado a la misma cuenta de Tailscale.

---

¿Te gustaría que añada una sección específica sobre cómo configurar la aceleración por GPU (NVIDIA Container Toolkit) para Docker?
