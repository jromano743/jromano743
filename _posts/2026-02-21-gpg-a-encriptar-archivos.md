---
layout: post
title: "GPG: A encriptar archivos"
categories: [techie]
---

Volví a jugar con GPG y me recordó algo importante: la mayoría de las personas usa criptografía todos los días… sin entenderla. Y de repente pensé que hoy, más que nunca, es importante conocer este tipo de prácticas ya que vivimos en un mundo enteramente digitalizado.

El día de hoy vine con ganas de escribir una pequeña guía para que puedas conocer y utilizar GPG para cifrar y firmar archivos. La idea es tener un post con la información completa sobre cómo usar esta herramienta tanto en su versión de Linux con la CLI como en Windows utilizando Gpg4win con su GUI **Kleopatra**. El día de hoy, toca Linux.

#### Índice
1. [Qué es GPG](#qué-es-gpg)
2. [GPG en el día a día](#gpg-en-el-día-a-día)
3. [Cifrado Simétrico](#cifrado-simétrico)
   - [Cifrado Simétrico - Linux](#cifrado-simétrico-ejemplo)
   - [Descifrado Simétrico - Linux](#descifrado-simétrico-ejemplo)
4. [Identidad digital](#identidad-digital)
   - [Llave privada](#llave-privada)
   - [Llave pública](#llave-pública)
5. [Sign: Firmar archivos](#sign-firmar-archivos)
   - [Firma adjunta (Attached / Binary Signature)](#firma-adjunta-attached--binary-signature)
     - [Validar la firma y ver el contenido](#validar-la-firma-y-ver-el-contenido)
   - [Firma separada (Detached Signature)](#firma-separada-detached-signature)
     - [Validar firma](#validar-firma)
   - [Firma clear (Clearsign)](#firma-clear-clearsign)
     - [Validar firma](#validar-firma-1)
6. [Generar claves](#generar-claves)
7. [Clave pública y clave privada: cómo se usan](#clave-pública-y-clave-privada-cómo-se-usan)
   - [Clave privada](#clave-privada)
   - [Clave pública](#clave-pública)
8. [Importar claves](#importar-claves) 
9. [Un ejemplo de uso](#un-ejemplo-de-uso)
   - [Cifrar para otra persona (usando su clave pública)](#cifrar-para-otra-persona-usando-su-clave-pública)
   - [Firmar con nuestra clave privada](#firmar-con-nuestra-clave-privada)
10. [Advertencias](#advertencias)
   -  [Errores comunes](#errores-comunes)
   -  [Verificación de identidad](#verificación-de-identidad)
   -  [Buenas Practicas](#buenas-prácticas)
10. [Resumen conceptual](#resumen-conceptual)

---

## Qué es GPG
No podemos empezar sin saber de qué estamos hablando. **GPG** es la sigla de **GNU Privacy Guard**, una implementación libre del estándar **OpenPGP**. Es una herramienta de criptografía de clave pública para cifrar, descifrar y firmar información.

Básicamente, con GPG puedes: 
- cifrar archivos
- firmar archivos digitalmente (para garantizar integridad y autenticidad)
- verificar firmas
- gestionar claves públicas/privadas.

O en español: proteger la confidencialidad e integridad de tus datos.

---

## GPG en el día a día
GPG es la misma herramienta, pero puede utilizarse desde la línea de comandos (CLI) en Linux o mediante distribuciones como Gpg4win en Windows, que incluyen herramientas gráficas como Kleopatra. En esta guía tocaremos paso por paso algunas de las características más interesantes en la versión de Linux (próximamente Windows con Kleopatra).

---

## Cifrado Simétrico
El cifrado simétrico consiste en un proceso al que conceptualmente estamos acostumbrados: usar una única clave para acceder a un recurso. Solo que en lugar de un sitio web, esta vez es para un archivo. Con el cifrado simétrico podemos cifrar el archivo con una clave para que su contenido no sea visible excepto por quienes poseen dicha clave.

En el caso de GPG, la passphrase que ingresamos no se usa directamente como clave, sino que se deriva internamente una clave criptográfica real a partir de ella.

### Cifrado Simétrico ejemplo
Para aplicar un cifrado simétrico en Linux debemos ubicarnos con la terminal en la misma carpeta donde se encuentra el archivo que queremos cifrar y ejecutar el siguiente comando:
```bash
gpg -c file1.txt
```
O también su versión extensa:
```bash
gpg --symmetric file1.txt
```

Esto nos solicitará un passphrase que será nuestra contraseña para descifrar el archivo y nos generará un archivo **file1.txt.gpg**. El **.gpg** es nuestro archivo cifrado. Este nuevo archivo es el archivo cifrado. Podemos compartirlo o mantenerlo y eliminar el original según nuestra necesidad. Es muy importante que **NO PIERDAS LA CLAVE**.

### Descifrado Simétrico ejemplo
Ya tenemos nuestro archivo **file1.txt.gpg**. Lo siguiente es descifrarlo para conocer su contenido. Tenemos nuevamente 2 opciones, el comando abreviado o el comando extenso.

Empecemos con el abreviado:
```bash
gpg -d file1.txt.gpg > file1.txt
```
Este comando usa la flag **-d** (desencriptar/descifrar) y la aplica sobre el archivo **.gpg** que le pasemos. Una vez descifrado redirige la salida (el conjunto de bits que forman el archivo) a un nuevo archivo. Para redirigirlo utilizamos el operador **>** y le indicamos hacia qué archivo dirigir dicha salida; si el archivo no existe, lo creará.

Si no estás acostumbrado a la redirección puedes utilizar la flag **-o** (output) para indicarle en qué archivo se guardarán los bits:
```bash
gpg -d file1.txt.gpg -o file1.txt
```
O en su versión extensa:
```bash
gpg --decrypt file1.txt.gpg --output file1.txt
```

Te regalo un archivo cifrado... SI te gana la curiosidad. La clave es **loblab_gpg_linux**  
<a href="{{ '/assets/files/gpgaencriptararchivos/ArchivoCifrado.txt.gpg' | relative_url }}" download="ArchivoCifrado.txt.gpg">Descargar archivo .gpg</a>

---

## Identidad digital
Hasta ahora solo utilizamos una clave simétrica. Lo cual nos sirve para proteger un archivo, pero nada garantiza quién lo creó. Para poder asociar acciones criptográficas a una identidad, GPG nos provee un par de llaves criptográficas: una clave privada y una pública.

Este par nos permite:
- Cifrar para que solo el dueño de la clave privada pueda descifrar.
- Firmar para demostrar que algo fue generado con una clave privada específica.

En GPG cada llave tiene capacidades:
- S → Sign (firmar)
- E → Encrypt (cifrar)
- C → Certify (firmar otras claves)
- A → Authenticate (SSH, etc.)

### Llave privada
La llave privada es tu llave personal. Esta es la que no se comparte y se utiliza para descifrar los archivos cifrados con tu clave pública y para generar firmas digitales.

### Llave pública
Pensemos en la llave pública como un candado. Imagina que tienes infinitas copias del candado que corresponde a tu llave disponibles y los puedes repartir por ahí. Si me das un candado yo puedo cifrar archivos con tu candado, pero solo tú puedes abrirlos utilizando tu llave privada.

De la misma manera, si firmas algo con tu llave privada, cualquiera que tenga tu llave pública puede verificar que esa firma fue generada con esa clave. La identidad real dependerá de que el receptor confíe en que esa clave pública realmente te pertenece.

---

## Sign: Firmar archivos
Cuando se quiere asegurar la integridad de un archivo, es decir, validar que no fue modificado y que fue firmado con una clave privada específica, se debe comprobar la firma del mismo. Existen 3 tipos de firmas, las cuales veremos a continuación:

### Firma adjunta (Attached / Binary Signature)
Esta firma:
1. Calcula el hash del archivo.
2. Genera la firma con tu clave privada.
3. Empaqueta el archivo y la firma en un solo archivo **.gpg**.

Se podría decir que guardamos nuestro archivo en un sobre y le ponemos nuestro sello. El resultado es un archivo binario **.gpg** que contiene tanto el contenido como la firma.

Firma:
```bash
gpg -s file2.txt
```
```bash
gpg --sign file2.txt
```

#### Validar la firma y ver el contenido
Con el binario firmado podemos hacer 2 cosas. Validar su firma:
```bash
gpg --verify archivo.txt.gpg
```
Y ver el contenido del archivo:
```bash
gpg --decrypt archivo.txt.gpg
```
En el caso de necesitarlo podemos redirigir el contenido similar al cifrado simétrico:
```bash
gpg --decrypt archivo.txt.gpg > archivo.txt
```

### Firma separada (Detached Signature)
Esta firma:
1. Calcula el hash del archivo.
2. Firma el hash.
3. Guarda SOLO la firma en **.sig**.

El archivo original no se modifica, sino que se genera un nuevo archivo **.sig** con la firma del hash del archivo. Este archivo contiene la firma criptográfica asociada a la clave del firmante (identificada por su KeyID o fingerprint).

#### Validar firma
En este caso, al tratarse de un par de archivos, se lee el archivo, se calcula el hash y se comprueba con la firma para validar la integridad del mismo:
```bash
gpg --verify archivo.txt.sig archivo.txt
```

### Firma clear (Clearsign)
Esta firma:
1. Firma el texto.
2. Mantiene el contenido legible.
3. Añade la firma en formato ASCII armor.

Al final del archivo se coloca la firma:
```bash
gpg --clearsign archivo.txt
```

#### Validar firma
La firma se incluye en el archivo, por lo que solo hay que ejecutar:
```bash
gpg --verify archivo.txt.asc
```

---

## Generar claves

Hasta ahora trabajamos con cifrado simétrico y firmas, pero para poder firmar archivos o cifrar usando clave pública necesitamos primero crear nuestra identidad criptográfica.

Para eso utilizamos el comando:

```bash
gpg --full-generate-key
```

Este comando nos permite crear un par de claves: una **clave privada** y una **clave pública**.

Cuando ejecutamos:

```bash
gpg --full-generate-key
```

GPG nos pedirá:

1. Tipo de algoritmo (RSA, ECC, etc.).
2. Tamaño de clave (si aplica).
3. Fecha de expiración.
4. Nombre.
5. Email (El email no tiene que existir realmente, pero es el identificador que otros verán asociado a tu clave.).
6. Comentario (opcional).
7. Passphrase para proteger la clave privada.

Al finalizar, se crea:

- Una **clave privada** (secreta, la llave).
- Una **clave pública** (compartible, un candado).

Podemos ver nuestras claves con:

```bash
gpg --list-keys
```

Y nuestras claves privadas con:

```bash
gpg --list-secret-keys
```

---

## Clave pública y clave privada: cómo se usan

### Clave privada

La clave privada:

- Se guarda en tu sistema.
- Está protegida por passphrase (una contraseña).
- Se usa para:
  - Firmar archivos.
  - Descifrar archivos cifrados con tu clave pública.

Nunca debe compartirse.

Conceptualmente:
> Es tu identidad digital real. Si alguien la obtiene, puede hacerse pasar por vos.

### Clave pública

La clave pública:

- Se puede compartir libremente.
- Se usa para:
  - Cifrar archivos destinados a vos.
  - Verificar firmas que generaste.

Podemos exportarla para compartirla:

```bash
gpg --export --armor tu@email.com > clave_publica.asc
```

El flag `--armor` la convierte en formato ASCII legible.

---

## Importar claves

Cuando recibimos una clave pública de otra persona y queremos cifrar archivos para ella o verificar sus firmas, primero debemos importarla a nuestro keyring (almacén local de claves).

Para hacerlo utilizamos el comando:
```bash
gpg --import clave_de_mi_amigo.asc
```

También es posible que la clave venga en formato binario (.gpg). En ese caso, el comando es exactamente el mismo:
```bash
gpg --import clave_de_mi_amigo.gpg
```

GPG detecta automáticamente el formato del archivo y lo procesa correctamente.

Una vez importada, podemos verificar que la clave esté en nuestro sistema ejecutando:
```bash
gpg --list-keys
```
Importar claves privadas

El mismo principio aplica para las claves privadas, por ejemplo cuando necesitamos migrar nuestra identidad criptográfica a un nuevo dispositivo:
```bash
gpg --import mi_clave_privada.asc
```

---

## Un ejemplo de uso

### Cifrar para otra persona (usando su clave pública)

Si tenemos la clave pública de alguien importada en nuestro sistema:

```bash
gpg --encrypt --recipient persona@email.com archivo.txt
```

Solo esa persona podrá descifrarlo con su clave privada.

### Firmar con nuestra clave privada

```bash
gpg --sign archivo.txt
```

Cualquiera con nuestra clave pública podrá verificar la firma:

```bash
gpg --verify archivo.txt.gpg
```

---

## Advertencias
### Errores comunes
Errores comunes y puntos críticos a tener en cuenta al trabajar con GPG:
- La clave privada representa tu identidad digital.
- Si alguien obtiene tu clave privada, puede firmar o descifrar archivos en tu nombre.
- Nunca debe compartirse.
- Siempre debe almacenarse protegida por una passphrase robusta.
- Es recomendable mantener un backup cifrado del keyring o de la clave privada exportada.

### Verificación de identidad
Nunca confíes automáticamente en una clave pública importada.
Siempre verifica su fingerprint por un canal seguro antes de usarla.

Puedes ver el fingerprint con:
```bash
gpg --fingerprint email@ejemplo.com
```

### Buenas prácticas
- Define una fecha de expiración para tus claves.
- Evita usar tamaños de clave débiles.
- Nunca subas tu clave privada a repositorios públicos.
- Si pierdes tu clave privada, pierdes el acceso a todo lo cifrado con tu clave pública.

---

## Resumen conceptual

Con `--full-generate-key` creamos una identidad digital compuesta por:

- Clave privada → para firmar y descifrar.
- Clave pública → para compartir y permitir que otros cifren o verifiquen.

Cifrar protege el contenido.  
Firmar protege la integridad y permite asociar el archivo a una clave específica.

A partir de aquí, ya no dependemos solo de una passphrase como en el cifrado simétrico, sino que entramos en el modelo de criptografía asimétrica.
