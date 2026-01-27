---
layout: post
title: "De Sherlock a Holmes: organizando información OSINT"
categories: [techie]
---

Recientemente construí el prototipo de una aplicación que vengo pensando desde hace tiempo. La idea principal detrás de Holmes es poder estructurar información OSINT de una forma visual, ordenada y orientada al análisis de relaciones.

Hace casi 4 años, creo, en mis inicios como ciberentusiasta, descubrí la aplicación Sherlock. Sherlock es básicamente un indexador de información para un usuario: trae muchos datos de perfiles cuyo nombre coincide con el que estás buscando. Era muy bueno. Sin embargo, esto solo servía como un vistazo general, ya que existían muchos falsos positivos y la información quedaba dispersa.

Ahí es donde aparece Holmes: Sherlock encuentra datos, Holmes los organiza, los conecta y los vuelve analizables.

Abrí un bloc de notas para rescatar lo que quería, pero era un proceso algo tedioso. Pensé que debería poder guardar esta información y presentarla de forma más eficiente. De ahí nace la idea de Holmes como complemento de Sherlock. Y sí, el nombre es solo para completar el “Sherlock Holmes”.

La aplicación guarda los datos en una base de datos SQLite bajo el principio de que todo es una entidad. Estas entidades son nodos que pueden conectarse entre sí; de esta forma puedes graficar las relaciones para tener un vistazo general de un posible vector de análisis o de la superficie de exposición de un objetivo.

### Holmes, base de datos para OSINT

<div class="img-frame">
    <img
        src="{{ '/assets/images/desherlockaholmes/holmes_banner.webp' | relative_url }}"
        alt="Banner HOMES">
</div>

Lo primero es definir los tipos de entidades. El programa trae algunas entidades por defecto, pero se pueden crear según se necesite. Por ejemplo, se podría agregar la entidad “Dispositivo”, “Vehículo”, etc. Todo lo que consideres necesario registrar puede ser una entidad.

<div class="img-frame">
    <img
        src="{{ '/assets/images/desherlockaholmes/entidades.webp' | relative_url }}"
        alt="Entidades IMG">
</div>

El segundo paso es definir las relaciones. Para definirlas tomamos dos entidades y creamos una relación, o usamos las ya existentes. En esta vista se traerán todas las entidades que cargaste en el paso anterior y algunas relaciones por defecto como “owns” o “uses”. Al igual que con las entidades, puedes crear más.

<div class="img-frame">
    <img
        src="{{ '/assets/images/desherlockaholmes/relaciones.webp' | relative_url }}"
        alt="Relaciones IMG">
</div>

Tras crear las entidades solo hay que renderizar el gráfico y tendrás el árbol con la información que cargaste. Este gráfico te puede ayudar a crear mejores vectores de análisis, detectar puntos de fuga o simplemente tener una visión más clara de cómo se relaciona toda la información que fuiste recopilando.

<div class="img-frame">
    <img
        src="{{ '/assets/images/desherlockaholmes/grafo.webp' | relative_url }}"
        alt="Grafo IMG">
</div>

### Para el futuro

Con el tiempo la idea es hacer un gráfico más interactivo y generar informes que ayuden al usuario a encontrar puntos de fuga o mejores vectores de análisis.  
Holmes todavía es un MVP muy temprano: la prioridad fue validar el concepto antes de pulir la experiencia de usuario o agregar automatizaciones más complejas.

Holmes nació como una necesidad personal, pero la idea es que con el tiempo pueda convertirse en una herramienta útil para cualquiera que trabaje con OSINT de forma estructurada.

Si tienes curiosidad, te animo a probarla en:  
<a href="https://github.com/jromano743/holmes" target="_blank">Este enlace</a>
