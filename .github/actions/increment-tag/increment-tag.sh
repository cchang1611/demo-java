#!/bin/bash

TAG=$1

TAG_PREFIX=${TAG%-snapshot}  # Elimina la palabra "snapshot" al final del tag
TAG_SUFFIX=${TAG#"$TAG_PREFIX"}  # Obtiene la parte del tag después del prefijo

if [$TAG -match '^(\d+)\.(\d+)\.(\d+)$']; then
    $major = [int]$Matches[1]
    $minor = [int]$Matches[2]
    $patch = [int]$Matches[3]

    # Incrementar el patch hasta llegar a 9
    if [$patch -lt 9]; then
        $patch++
    else
        # Incrementar el minor y reiniciar el patch a 0
        if [$minor -lt 9]; then
            $minor++
            $patch = 0
        else 
            # Incrementar el major, reiniciar el minor y el patch a 0
            if [$major -lt 9]; then
                $major++
                $minor = 0
                $patch = 0
            fi
        fi
    fi

    $newTag = "$major.$minor.$patch"
    $newTagWithSnapshot = $newTag + "-snapshot"
    Write-Host "Nuevo tag: $newTagWithSnapshot"
    
else 
    Write-Host "El tag no tiene el formato esperado"
fi

echo "Nuevo Tag es: $newTag"
