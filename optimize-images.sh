#!/bin/bash

BASE_DIR="assets/images"

find "$BASE_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r img; do
    output="${img%.*}.webp"

    # Evita reconvertir si ya existe
    if [ ! -f "$output" ]; then
        cwebp -q 80 "$img" -o "$output"
        echo "Convertido: $img → $output"
    fi
done
