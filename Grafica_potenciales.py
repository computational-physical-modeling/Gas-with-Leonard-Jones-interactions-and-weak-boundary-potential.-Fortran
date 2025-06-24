import pandas as pd
import matplotlib.pyplot as plt

# Nombre del archivo con los datos
archivo = "E_ww.txt"  # Asegúrate de que esté en el mismo directorio o da la ruta completa

# Leer los datos ignorando comentarios y espacios
columnas = ["step", "Etot", "Epot", "Temp"]
datos = pd.read_csv(archivo, delim_whitespace=True, comment='#', names=columnas)

# --- Gráfica de Energías ---
plt.figure()
plt.plot(datos["step"], datos["Etot"], label="Energía Total", color="blue")
plt.plot(datos["step"], datos["Epot"], label="Energía Potencial", color="green")
plt.xlabel("Paso de Simulación")
plt.ylabel("Energía")
plt.title("Energías durante la Simulación")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig("grafica_energia.png", dpi=300)  # También se guarda como imagen
plt.show()

# --- Gráfica de Temperatura ---
plt.figure()
plt.plot(datos["step"], datos["Temp"], label="Temperatura", color="orange")
plt.xlabel("Paso de Simulación")
plt.ylabel("Temperatura")
plt.title("Temperatura durante la Simulación")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.savefig("grafica_temperatura.png", dpi=300)
plt.show()
