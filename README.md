# Bunker IA: Infraestructura Local de Inferencia

Entorno auto-alojado diseñado para ejecucion de LLMs en hardware x86_64 con recursos limitados.

## Stack Tecnologico
- Ollama: Backend de inferencia.
- Open WebUI: Interfaz de usuario profesional.
- Docker Compose: Orquestacion de microservicios.
- Tailscale: Acceso remoto via red mesh privada.

## Modelos Predeterminados
1. Qwen 2.5 Coder 1.5B: Especializado en desarrollo de software.
2. Gemma-3-1B Thinking: Razonamiento ligero (Uncensored) para CPUs domesticas.

## Instrucciones de Instalacion
Clonar el repositorio y ejecutar el script de provisionamiento:
```bash
git clone https://github.com/bagpotato/bunker-ia.git
cd bunker-ia
./instalar.sh
```

## Puertos y Acceso
- Interfaz Web: http://localhost:3000
- Ollama API: http://localhost:11434
- Remoto: IP_Tailscale:3000
