import requests
import time

URL = "http://localhost:8080"
MI_NUMERO = "+34617285345"

print("--- MODO PRUEBA DE ECO ACTIVO ---")

while True:
    try:
        # Pedimos mensajes de forma que NO bloquee (timeout corto)
        r = requests.get(f"{URL}/v1/receive/{MI_NUMERO}", timeout=5)
        if r.status_code == 200:
            for m in r.json():
                texto = m.get("envelope", {}).get("dataMessage", {}).get("message")
                if texto:
                    print(f"He leído: {texto}")
                    # Intentamos devolver el eco
                    requests.post(f"{URL}/v1/send", json={
                        "message": f"Búnker dice: {texto}",
                        "number": MI_NUMERO,
                        "recipients": [MI_NUMERO]
                    })
    except Exception as e:
        print(f"Esperando... {e}")
    time.sleep(2)
