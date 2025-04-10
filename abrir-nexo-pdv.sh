#!/bin/bash
# Nexo PDV - Modo App (Sem Barra de URL)
# Este script abre o Nexo PDV em modo app no Chrome/Chromium, sem mostrar a barra de URL

# Cores para o terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para tentar abrir com diferentes navegadores
open_with_browser() {
    # Tenta com Google Chrome
    if command -v google-chrome &> /dev/null; then
        echo -e "${GREEN}Abrindo com Google Chrome...${NC}"
        google-chrome --app="$URL" --disable-pinch --overscroll-history-navigation=0 --disable-features=TranslateUI --no-first-run --disable-infobars
        exit 0
    fi
    
    # Tenta com Chromium
    if command -v chromium-browser &> /dev/null; then
        echo -e "${GREEN}Abrindo com Chromium...${NC}"
        chromium-browser --app="$URL" --disable-pinch --overscroll-history-navigation=0 --disable-features=TranslateUI --no-first-run --disable-infobars
        exit 0
    fi
    
    # Tenta com Chrome no macOS
    if [ -d "/Applications/Google Chrome.app" ]; then
        echo -e "${GREEN}Abrindo com Google Chrome (macOS)...${NC}"
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --app="$URL" --disable-pinch --overscroll-history-navigation=0 --disable-features=TranslateUI --no-first-run --disable-infobars
        exit 0
    fi
    
    # Se chegou aqui, não encontrou nenhum navegador compatível
    echo -e "${RED}Erro: Não foi possível encontrar o Google Chrome ou Chromium.${NC}"
    echo "Por favor, instale o Google Chrome e tente novamente."
    echo "Você pode baixar o Chrome em: https://www.google.com/chrome/"
    exit 1
}

# Função para selecionar o ambiente
select_environment() {
    echo -e "${BLUE}===================================${NC}"
    echo -e "${BLUE}  NEXO PDV - MODO APP SEM BARRA URL${NC}"
    echo -e "${BLUE}===================================${NC}"
    echo ""
    echo "Selecione o ambiente:"
    echo ""
    echo "  1. Produção (nexopdv.emasoftware.io)"
    echo "  2. Desenvolvimento (localhost)"
    echo "  3. Homologação"
    echo "  4. URL Personalizada"
    echo "  5. Sair"
    echo ""
    
    read -p "Digite o número da opção desejada: " choice
    
    case $choice in
        1)
            URL="https://nexopdv.emasoftware.io/login"
            ;;
        2)
            echo ""
            read -p "Digite a porta em que o projeto está rodando (padrão: 5000): " port
            
            # Se o usuário não digitar nada, usa a porta padrão 5000
            if [ -z "$port" ]; then
                port="5000"
            fi
            
            URL="http://localhost:${port}/login"
            echo ""
            echo -e "URL configurada: ${GREEN}${URL}${NC}"
            echo ""
            ;;
        3)
            URL="https://homolog.nexopdv.emasoftware.io/login"
            ;;
        4)
            echo ""
            read -p "Digite a URL completa do Nexo PDV: " URL
            ;;
        5)
            echo -e "${GREEN}Saindo...${NC}"
            exit 0
            ;;
        *)
            echo ""
            echo -e "${RED}Opção inválida. Por favor, tente novamente.${NC}"
            echo ""
            select_environment
            ;;
    esac
}

# Seleciona o ambiente
select_environment

# Exibe informações
echo -e "Abrindo Nexo PDV em modo app para: ${GREEN}$URL${NC}"
echo ""

# Tenta abrir com um navegador compatível
open_with_browser