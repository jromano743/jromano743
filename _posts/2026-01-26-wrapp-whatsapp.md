---
layout: post
title: "WPP-Visualization: Chats de WhatsApp en data pura"
categories: [techie]
---

Siempre he pensado que nuestros chats dicen mucho más de nosotros de lo que creemos. No solo por el contenido, sino por los patrones: quién escribe más, a qué hora se mueren los grupos o cuál es ese emoji que ya perdió todo su sentido de tanto usarlo. Así que, siguiendo mi costumbre de armar herramientas para entender lo que pasa por mis manos, creé **WPP-Visualization**.

Es un proyecto que funciona como un "analizador de laboratorio" para los archivos de exportación de WhatsApp, permitiendo generar un reporte visual de lo que realmente sucede en una conversación.

### ¿Por qué analizar WhatsApp?
La curiosidad fue el motor principal. WhatsApp te permite exportar el historial en un `.txt` que, a simple vista, es una pared de texto inmanejable. Quería una forma rápida de procesar eso y obtener métricas reales sin tener que subir mis datos a páginas de terceros que no sé qué hacen con la información. 

Con este script, el procesamiento es local y los resultados son directos. Es, básicamente, crearte tu propio "WhatsApp Wrapped" cuando quieras.

### El desafío de la "data sucia"
Para los que venimos del lado del código, sabemos que el mundo real no viene en un JSON ordenado. El mayor reto aquí fue la **sanitización de los datos**. 

El archivo de WhatsApp es traicionero: cambia según el idioma del teléfono, el sistema operativo y el formato de fecha. El script tiene que ser capaz de identificar qué es un mensaje real y qué es "ruido" del sistema (como cuando alguien cambia la descripción del grupo o sale de la llamada). Lograr que el parser sea lo suficientemente robusto para no romperse con un emoji mal puesto fue la parte más entretenida.

### ¿Qué hay bajo el capó?
El proyecto está construido principalmente con **Python**, aprovechando la potencia de `pandas` para el manejo de estructuras de datos y `matplotlib/seaborn` para la parte visual. Aquí algunas de las métricas que saca:

* **Activity Heatmap:** ¿El grupo está vivo a las 3 AM o es estrictamente de horario laboral?
* **User Contributions:** El ranking definitivo de quién manda más mensajes y quién solo aparece para leer.
* **Emoji Counter:** Un análisis de los emojis más frecuentes para entender el "mood" general del chat.
* **Media Tracking:** Identifica cuántos mensajes fueron fotos, videos o audios (aunque WhatsApp los marque como "omitidos" en el texto).

<div class="gallery">

  <div class="img-frame">
    <img
      src="{{ '/assets/images/wppvisualization/emojis.webp' | relative_url }}"
      alt="Tabla de Emojis">
      <span>FIG 01 · Tabla de emojis</span>
  </div>

  <div class="img-frame">
    <img
      src="{{ '/assets/images/wppvisualization/messages.webp' | relative_url }}"
      alt="Tabla de mensajes">
      <span>FIG 02 · Tabla de mensajes</span>
  </div>

</div>

### Estructura y Modularidad
Al igual que con mis otros proyectos, traté de mantener el código organizado. El procesamiento se divide en etapas claras: limpieza, transformación y finalmente la visualización. Esto me permite, en el futuro, agregar nuevos módulos de análisis (como análisis de sentimiento) sin tener que reescribir la base del parser.

### Estado del proyecto: Funcional y abierto
A diferencia de otros prototipos, **WPP-Visualization** ya es funcional y lo pueden encontrar en mi GitHub. Todavía hay detalles que pulir, especialmente en el soporte para diferentes formatos de exportación regionales, pero la base ya está lista para que cualquiera pueda tirar su `.txt` y ver qué sale.

### Conclusión
Proyectos como este me recuerdan por qué me gusta programar: transformar un archivo de texto aburrido en información visual y comprensible es casi como hacer magia. Si te da curiosidad saber qué tan intenso es tu grupo de amigos o cuántos stickers mandas por día, dale una mirada al repo.

¡Nos vemos en el próximo commit!

<a href="https://github.com/jromano743/wpp-visualization" target="_blank">Repo en GitHub: wpp-visualization</a>