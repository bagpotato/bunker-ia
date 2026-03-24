# Bunker IA: Infraestructura de Inferencia Local

Este repositorio contiene la configuracion necesaria para desplegar un entorno privado de Inteligencia Artificial optimizado para asistencia en programacion y ejecucion en hardware de recursos limitados (x86_64).

## Arquitectura del Sistema

La solucion se basa en un stack de contenedores orquestados mediante Docker Compose, segmentado en los siguientes componentes:

1. **Motor de Inferencia (Ollama):** Gestiona la carga y ejecucion de modelos cuantizados. Configurado para utilizar el modelo Qwen 2.5 Coder (1.5B parametros) optimizado para CPUs sin aceleracion GPU dedicada.
2. **Interfaz de Usuario (Open WebUI):** Panel de control web compatible con multiples usuarios y persistencia de historial en base de datos local.
3. **Capa de Red Mesh (Tailscale):** Protocolo WireGuard para establecer un tunel cifrado punto a punto, permitiendo el acceso remoto seguro sin exposicion de puertos publicos ni necesidad de nombres de dominio.

## Requisitos del Sistema

- Sistema Operativo: Linux (Ubuntu/WSL2 recomendado).
- Motor de Contenedores: Docker Engine y Docker Compose.
- Recursos: Minimo 8GB RAM (16GB recomendado para multitarea).

## Proceso de Instalacion y Despliegue

Siga estos pasos para la replicacion del nodo:

1. Clonar el repositorio:
   git clone https://github.com/bagpotato/bunker-ia.git
   cd bunker-ia

2. Ejecucion del script de aprovisionamiento:
   chmod +x instalar.sh
   ./instalar.sh

## Gestion de Acceso y Puertos

El despliegue habilita los siguientes servicios en la red local y privada:

- **Web UI:** Puerto 3000 (Mapeado a 8080 interno).
- **Ollama API:** Puerto 11434 (Para conexiones externas de IDEs como VS Code).
- **Acceso Tailscale:** http://[IP_PRIVADA_TAILSCALE]:3000

## Mantenimiento

Para actualizar los modelos o reiniciar los servicios:
- Reiniciar stack: sudo docker compose restart
- Actualizar modelo: sudo docker exec -it ollama ollama pull qwen2.5-coder:1.5b
