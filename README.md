# Bunker IA: Infraestructura de Inferencia Local

Este repositorio contiene la configuracion necesaria para desplegar un entorno privado de Inteligencia Artificial optimizado para asistencia en programacion y ejecucion en hardware de recursos limitados (x86_64).

## Modelos Incluidos

El sistema despliega automaticamente los siguientes modelos:
- **Qwen 2.5 Coder 1.5B:** Especializado en generacion y depuracion de codigo.
- **Gemma-3-1B Thinking:** Modelo ligero de razonamiento (uncensored) optimizado para baja latencia en CPUs domesticas.

## Instalacion y Despliegue

Siga estos pasos para la replicacion del nodo:

1. Clonar el repositorio:
   git clone https://github.com/bagpotato/bunker-ia.git
   cd bunker-ia

2. Ejecucion del script de aprovisionamiento:
   chmod +x instalar.sh
   ./instalar.sh

## Configuracion de Acceso

- **Web UI:** Puerto 3000
- **Ollama API:** Puerto 11434
- **Acceso Remoto:** http://[IP_PRIVADA_TAILSCALE]:3000

## Especificaciones Tecnicas
- Orquestacion: Docker Compose.
- Seguridad: Red privada mesh via Tailscale.
