import requests
import json
import os

OLLAMA_URL = "http://localhost:11434/api/generate"
MODELO = "qwen2.5-coder:1.5b"

SYSTEM_PROMPT = """
Eres un experto en terminal Linux. 
Si el usuario te pide una tarea de archivos o sistema, responde SOLO con el comando de Bash necesario.
Si es una duda de código, responde con el bloque de código.
No des explicaciones largas a menos que te las pidan.
"""

def preguntar_al_coder(orden):
    payload = {
        "model": MODELO,
        "prompt": f"{SYSTEM_PROMPT}\n\nUsuario: {orden}\nAsistente:",
        "stream": False
    }
    try:
        r = requests.post(OLLAMA_URL, json=payload)
        return r.json().get("response", "Error de respuesta")
    except Exception as e:
        return f"Error: {e}"

print("🤖 Coder-Bunker Activo. ¿Qué necesitas programar o ejecutar?")
while True:
    tarea = input("\n> ")
    if tarea.lower() in ["salir", "exit"]: break
    
    respuesta = preguntar_al_coder(tarea)
    print(f"\n--- RESPUESTA DE QWEN ---\n{respuesta}")
