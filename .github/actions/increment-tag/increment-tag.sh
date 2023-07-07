#!/bin/bash

TAG=$1

TAG_PREFIX=${TAG%-snapshot}  # Elimina la palabra "snapshot" al final del tag
TAG_SUFFIX=${TAG#"$TAG_PREFIX"}  # Obtiene la parte del tag después del prefijo

if [$TAG =~ '^refs/tags/v?[0-9]+\.[0-9]+\.[0-9]+$']; then
    major = $(expr "${BASH_REMATCH[1]}" + 0)
    minor = $(expr "${BASH_REMATCH[2]}" + 0)
    patch = $(expr "${BASH_REMATCH[3]}" + 0)

    # Incrementar el patch hasta llegar a 9
    if [$patch -lt 9]; then
        patch=$((patch + 1))
    else
        # Incrementar el minor y reiniciar el patch a 0
        if [$minor -lt 9]; then
            minor = $((minor + 1))
            patch = 0
        else 
            # Incrementar el major, reiniciar el minor y el patch a 0
            if [$major -lt 9]; then
                major = $((major + 1))
                minor = 0
                patch = 0
            fi
        fi
    fi

    newTag = "v${major}.${minor}.${patch}"
    newTagWithSnapshot = "${newTag}-snapshot"
    echo "El nuevo tag: $newTagWithSnapshot"
    
else 
    echo "El tag no tiene el formato esperado"
fi

echo "Nuevo Tag es: $newTag"
