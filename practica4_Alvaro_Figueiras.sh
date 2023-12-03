#!/bin/bash


if [[ $USER == "root" ]]; then
    
    indice=0
    #Comprobar si ya esta uinst6alado el paquete
    existe=$(whereis PACKAGENAME | grep bin | wc -l)
    #antes de nada actualizamos los repositorios
    apt update

    while IFS=: read PACKAGENAME ACTION;
    do
        paquete[$indice]=$PACKAGENAME
        accion[$indice]=$ACTION

        case $accion in
            remove | r)
                if [[ $existe -eq 0 ]]; then
                    echo "$paquete no esta instalado por lo que no se puede eliminar"
                else
                    apt remove $paquete -y
                fi
            ;;
            add | i)
                if [[ $existe -eq 0  ]]; then
                    apt install $paquete -y
                else
                    echo "$paquete ya esta instalado"
                fi

            ;;
            status | s)
                if [[ $existe -eq 0 ]]; then
                    echo "Se a comprobado y $paquete no esta instalado"
                else
                    echo "Se a comprobado y $paquete esta instalado"
                fi
            ;;
        esac


    done < paquetes.txt
else
    echo "Este script solo funciona si eres root"
    exit
fi