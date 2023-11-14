#!/bin/bash

# Script para agregar los repositorios de Arch Linux en Artix Linux

# Verificamos si el usuario tiene privilegios de administrador
if [ "$(id -u)" -ne 0 ]; then
  echo "Este script debe ejecutarse con privilegios de administrador (root)."
  exit 1
fi

# Realizamos una copia de seguridad del archivo /etc/pacman.conf
cp /etc/pacman.conf /etc/pacman.conf.bak

# Agregamos los repositorios de Arch Linux al final del archivo /etc/pacman.conf
cat <<EOL >> /etc/pacman.conf

# Repositorios de Arch Linux para Artix Linux
[universe]
Server = https://universe.artixlinux.org/\$arch
Server = https://mirror1.artixlinux.org/universe/\$arch
Server = https://mirror.pascalpuffke.de/artix-universe/\$arch
Server = https://artixlinux.qontinuum.space/artixlinux/universe/os/\$arch
Server = https://mirror1.cl.netactuate.com/artix/universe/\$arch
Server = https://ftp.crifo.org/artix-universe/\$arch
Server = https://artix.sakamoto.pl/universe/\$arch

# Descomentar las siguientes líneas si es necesario
#[testing]
#Include = /etc/pacman.d/mirrorlist-arch

[extra]
Include = /etc/pacman.d/mirrorlist-arch

#[community-testing]
#Include = /etc/pacman.d/mirrorlist-arch

[community]
Include = /etc/pacman.d/mirrorlist-arch

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist-arch

[multilib]
Include = /etc/pacman.d/mirrorlist-arch

EOL

# Actualizamos la base de datos de paquetes y el sistema
sudo pacman -Sy
sudo pacman -Syu artix-archlinux-support

# Configuramos las claves de Arch Linux
sudo pacman-key --populate archlinux

echo "Repositorios de Arch Linux agregados exitosamente."
