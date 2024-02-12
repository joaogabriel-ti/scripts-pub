#!/bin/bash
############################
#
#
# Author: Joao Gabriel
# Data: 01/02/2024
# Descrição: Gerar informações do sistema
#
#
####################################################################

# Definindo códigos de cores ANSI (atualizado para uso mais amplo)
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # Sem cor

echo -e "${GREEN}========================================= Inicio =========================================${NC}"

# Atribuindo valores às variáveis
NOME_MAQUINA="$(hostname)"
DATA_ATUAL="$(date)"
ATIVO_DESDE="$(uptime -p)"
KERNEL_VERSION="$(uname -or)"
MEMORIA="$(free -h)"
CPU_INFO="$(lscpu | grep -v '^Vulnerability')"
ENDERECO_IP="$(hostname -I | cut -d' ' -f1)"
PROCESSOS="$(ps aux)"
VERSAO_SHELL="$BASH_VERSION"
INFO_REDE="$(ifconfig $(route | grep '^default' | grep -o '[^ ]*$'))"
ESPACO_EM_DISCO="$(df -h)"
USUARIOS_CONECTADOS="$(who)"
#DISTRO="$(cat /etc/*release* | grep DISTRIB_DESCRIPTION | cut -d'=' -f2 | sort | uniq)"

# Informações sobre a distribuição
if [ -f /etc/lsb-release ]; then
  DISTRO=$(grep '^DISTRIB_DESCRIPTION' /etc/lsb-release | cut -d'=' -f2)
elif [ -f /etc/os-release ]; then
  DISTRO=$(grep '^PRETTY_NAME' /etc/os-release | cut -d'"' -f2)
elif [ -f /etc/redhat-release ]; then
  DISTRO=$(cat /etc/redhat-release)
else
  DISTRO="Não foi possível determinar a distribuição."
fi

# Saída formatada com cores
echo -e "${RED}Hostname da Máquina:${NC}\n$NOME_MAQUINA\n"
echo -e "${RED}Endereço IP:${NC}\n$ENDERECO_IP\n"
echo -e "${RED}Informações de Rede:${NC}\n$INFO_REDE\n"
echo -e "${RED}Data e Hora Atuais:${NC}\n$DATA_ATUAL\n"
echo -e "${RED}Ativo Desde:${NC}\n$ATIVO_DESDE\n"
echo -e "${RED}Usuários Conectados:${NC}\n$USUARIOS_CONECTADOS\n"
echo -e "${RED}Distribuição:${NC}\n$DISTRO\n"
echo -e "${RED}Versão do Shell:${NC}\n$VERSAO_SHELL\n"
echo -e "${RED}Versão do Kernel:${NC}\n$KERNEL_VERSION\n"
echo -e "${RED}Quantidade de Memória:${NC}\n$MEMORIA\n"
echo -e "${RED}Espaço em Disco:${NC}\n$ESPACO_EM_DISCO\n"
echo -e "${RED}Informações da CPU:${NC}\n$CPU_INFO\n"
echo -e "${RED}Informações de Processos:${NC}\n$PROCESSOS\n"


echo -e "${GREEN}========================================= FIM =========================================${NC}"
