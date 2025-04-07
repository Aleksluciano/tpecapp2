#!/bin/sh
set -e

echo "Forçando criação do banco (deploy)..."
./node_modules/.bin/cds deploy --to sqlite:db.sqlite
echo "Banco de dados atualizado/criado com sucesso."

echo "Iniciando o servidor CAP..."
exec ./node_modules/.bin/cds serve