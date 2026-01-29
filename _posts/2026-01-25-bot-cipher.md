---
layout: post
title: "Cipher: Mi nuevo bot de Telegram para jugar con criptografía"
categories: [techie]
---

Últimamente he estado metido en un "agujero de conejo" con el tema de la privacidad y el manejo de datos. Así que, fiel a mi estilo de "aprender haciendo", me puse a programar **Cipher**, un bot de Telegram que funciona como una navaja suiza de bolsillo para cifrar mensajes y manipular texto.

Aún está en etapa de **prototipo** (está en el horno, como quien dice), pero ya tiene una estructura sólida que me tiene bastante emocionado.

### ¿Por qué existe Cipher?
La idea es simple: tener una herramienta a mano que te permita cifrar o procesar información sin salir de la app de mensajería. No es que estemos ocultando secretos de estado, pero hay algo muy satisfactorio en mandar un mensaje que solo alguien con la "llave" pueda leer, o simplemente generar un código QR rápido sin entrar a páginas llenas de publicidad.

<div class="img-frame">
    <img
        src="{{ '/assets/images/cipherbot/commands.webp' | relative_url }}"
        alt="Cipher Bot Commands">
</div>

### El "cerebro" detrás de Cipher
Para los más curiosos, estoy armando el bot con `python-telegram-bot`. La arquitectura está separada por controladores (`Controllers`), lo que me permite escalar las funciones de forma organizada. Aquí les cuento un poco qué puede hacer hasta ahora:

* **Cifrado Clásico (`/cipher`):** La función principal. Permite elegir entre diferentes algoritmos para encriptar y desencriptar texto.
* **Hashing de archivos (`/hash` y `/hashall`):** Si alguna vez necesitas verificar la integridad de un archivo, el bot te genera el hash (MD5, SHA256, etc.) en un segundo.
* **Generador de seguridad:** Tiene comandos para crear **UUIDs** y **contraseñas seguras** de forma aleatoria (`/uuid`, `/password`).
* **Utilidades de texto:** Cosas divertidas como invertir el texto (`/reverse`) o limpiar caracteres especiales.
* **QR Generator:** Le pasas un texto o link y te devuelve el código QR listo para usar.

<div class="img-frame">
    <img
        src="{{ '/assets/images/cipherbot/command_help.webp' | relative_url }}"
        alt="Cipher Bot Help command">
</div>

### Un vistazo a las vistas
Lo que más me gusta de cómo está quedando es el menú interactivo. Uso `CallbackQueryHandler` para que no tengas que escribir comandos complejos; el bot te va guiando con botones para elegir el algoritmo o la acción que querés realizar. 

<div class="img-frame">
    <img
        src="{{ '/assets/images/cipherbot/encrypt.webp' | relative_url }}"
        alt="Cipher Bot Encrypt">
</div>

Incluso le puse un "Job Queue" que limpia el estado de los usuarios cada minuto para que no se quede nada trabado en memoria. Es un detalle técnico, pero hace que la experiencia sea mucho más fluida y eficiente.

### Estado actual: Prototipo
Como les dije, todavía no lo he publicado oficialmente. Estoy puliendo el `unified_handler`, que es el que se encarga de decidir si lo que mandaste es un texto para cifrar o un documento para analizar. 

Todavía hay algunos comandos comentados en el código (como el de inspeccionar metadatos de archivos), porque quiero estar seguro de que funcionen perfecto antes de liberarlos al público.

### Conclusión: Lo que se viene
Me parece genial cómo un simple bot de Telegram puede terminar siendo una herramienta de aprendizaje tan potente sobre criptografía y manejo de servidores. Por ahora, **Cipher** sigue en mi entorno de desarrollo, pero pronto espero poder compartirles el link para que lo prueben y me digan qué les parece.

Me encanta cuando este tipo de proyectos "pequeños" terminan enseñándote más que un curso entero. ¡Estén atentos para cuando salga la versión definitiva!

¡Nos vemos!