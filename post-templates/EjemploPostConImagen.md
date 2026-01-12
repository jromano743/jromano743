---
layout: post
title: "Post con imagen"
categories: [inicio]
---
<h3>Imagen en parrafos</h3>
<h4>Link absoluto</h4>
<p align="center">
  <img
    src="https://imgsrv.crunchyroll.com/cdn-cgi/image/fit=cover,format=auto,quality=85,width=1920/keyart/GYQ4MW246-backdrop_wide"
    alt="Key visual"
    width="800">
</p>

<h4>Link a la carpeta assets</h4>
<div class="img-frame">
  <img
    src="{{ '/assets/images/captura.png' | relative_url }}"
    alt="Descripción de la imagen"
    >
    <span>FIG 01 · Captura de los logros</span>
</div>

<h4>Formato MD</h4>
![Descripción de la imagen]({{ "/assets/images/captura.png" | relative_url }})  

<h3>Vides embebidos</h3>
<center>
  <iframe
    width="560"
    height="315"
    src="https://www.youtube.com/embed/EJXk0HrBxkI"
    title="YouTube video"
    frameborder="0"
    allowfullscreen>
  </iframe>
</center>
