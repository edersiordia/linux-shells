#!/bin/bash

cripto_file='/home/azureuser/apps/criptomonedas/cripto_file.txt'
timestamp="$(date +'%Y%m%d_%I_%M_%p')"

echo "Iniciando el programa..."
echo "Descargando bitcoins data..."
bitcoin_url='https://www.google.com/finance/quote/BTC-MXN'
bitcoin_datos=$(curl -s "$bitcoin_url")
bitcoin_amount=$(grep -o 'data-last-price="[^"]*' <<< "$bitcoin_datos" | sed 's/data-last-price="//;s/"$//' | awk '{printf "%.2f", $1}')

echo "Descargando ethereum data..."
ethereum_url='https://www.google.com/finance/quote/ETH-MXN'
ethereum_datos=$(curl -s "$ethereum_url")
ethereum_amount=$(grep -o 'data-last-price="[^"]*' <<< "$ethereum_datos" | sed 's/data-last-price="//;s/"$//' | awk '{printf "%.2f", $1}')

echo "Descargando cardano data..."
cardano_url='https://www.google.com/finance/quote/ADA-MXN'
cardano_datos=$(curl -s "$cardano_url")
cardano_amount=$(grep -o 'data-last-price="[^"]*' <<< "$cardano_datos" | sed 's/data-last-price="//;s/"$//' | awk '{printf "%.2f", $1}')

echo "Actualizando el archivo..."
if [ ! -f "$cripto_file" ]; then
    touch /home/azureuser/apps/criptomonedas/cripto_file.txt
    echo -e "Fecha\t\t\tBitcoin\t\tEthereum\tCardano" > /home/azureuser/apps/criptomonedas/cripto_file.txt
    echo -e "$timestamp\t$bitcoin_amount\t$ethereum_amount\t$cardano_amount" >> /home/azureuser/apps/criptomonedas/cripto_file.txt
else
    echo -e "$timestamp\t$bitcoin_amount\t$ethereum_amount\t$cardano_amount" >> /home/azureuser/apps/criptomonedas/cripto_file.txt
fi

echo "Programa ejecutado con exito."
