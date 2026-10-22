#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

echo "======================================"
echo " Ambiente local de bancos de dados"
echo "======================================"

# Verifica se o Docker está instalado.
if ! command -v docker >/dev/null 2>&1; then
    echo "ERRO: Docker não encontrado."
    echo "Instale o Docker antes de continuar."
    exit 1
fi

# Verifica se o Docker Compose está disponível.
if ! docker compose version >/dev/null 2>&1; then
    echo "ERRO: Docker Compose não encontrado."
    echo "Instale o plugin Docker Compose."
    exit 1
fi

# Verifica se o daemon está funcionando.
if ! docker info >/dev/null 2>&1; then
    echo "ERRO: não foi possível acessar o Docker."
    echo "Verifique se o serviço está ativo e se você"
    echo "tem permissão para utilizar o Docker."
    exit 1
fi

# Verifica o arquivo de configuração.
if [ ! -f ".env" ]; then
    echo "ERRO: arquivo .env não encontrado."
    exit 1
fi

echo
echo "🐳 Iniciando ambiente de desenvolvimento..."

docker compose up -d

echo
echo "Serviços iniciados."
echo
echo "PostgreSQL: localhost:5432"
echo "MySQL:      localhost:3306"
echo
echo "Para verificar os serviços:"
echo "docker compose ps"
echo
echo "Para consultar os logs:"
echo "docker compose logs -f"