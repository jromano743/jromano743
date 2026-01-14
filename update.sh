#!/bin/bash

# ------------------------------
# Configuración
# ------------------------------
SITE_DIR="_site"           # Carpeta compilada local
GH_PAGES_BRANCH="gh-pages" # Rama que servirá en GitHub Pages

# ------------------------------
# Guardar rama actual
# ------------------------------
CURRENT_BRANCH=$(git branch --show-current)

# ------------------------------
# Verificar que _site exista
# ------------------------------
if [ ! -d "$SITE_DIR" ]; then
  echo "Error: la carpeta $SITE_DIR no existe. Compila primero el sitio."
  exit 1
fi

# ------------------------------
# Cambiar o crear la rama gh-pages
# ------------------------------
if git show-ref --quiet refs/heads/$GH_PAGES_BRANCH; then
  git checkout $GH_PAGES_BRANCH
else
  echo "Rama $GH_PAGES_BRANCH no existe. Creando..."
  git checkout --orphan $GH_PAGES_BRANCH
  git reset --hard
  git commit --allow-empty -m "Inicializando gh-pages"
fi

# ------------------------------
# Limpiar la rama (borrar todo)
# ------------------------------
git rm -rf . > /dev/null 2>&1

# ------------------------------
# Copiar contenido compilado a la raíz
# ------------------------------
cp -r "$SITE_DIR"/. .

# ------------------------------
# Commit de actualización
# ------------------------------
git add .
git commit -m "Actualizar sitio compilado $(date +"%Y-%m-%d %H:%M:%S")"

# ------------------------------
# Volver a la rama original
# ------------------------------
# git checkout $CURRENT_BRANCH

echo "✅ gh-pages actualizado. Para subirlo, ejecuta:"
echo "   git push origin $GH_PAGES_BRANCH"
