@echo off
setlocal enabledelayedexpansion

:: Título do console
title Nexo PDV - Modo App
:: Configurações
set "KEEP_OPEN=true"
set "KEEP_OPEN=true"

echo.
echo  ===================================
echo    NEXO PDV - MODO APP SEM BARRA URL
echo  ===================================
echo.

:: Verifica se o Chrome está instalado
set "CHROME_PATH="

:: Locais comuns do Chrome
set "CHROME_PATHS=C:\Program Files\Google\Chrome\Application\chrome.exe C:\Program Files (x86)\Google\Chrome\Application\chrome.exe %LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"

for %%p in (%CHROME_PATHS%) do (
    if exist "%%p" (
        set "CHROME_PATH=%%p"
        goto :CHROME_FOUND
    )
)

:: Tenta encontrar o Chrome usando where
where chrome.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
    for /f "delims=" %%i in ('where chrome.exe') do (
        set "CHROME_PATH=%%i"
        goto :CHROME_FOUND
    )
)

:CHROME_NOT_FOUND
echo ERRO: Google Chrome não encontrado.
echo.
echo Por favor, instale o Google Chrome e tente novamente.
echo.
echo Você pode baixar o Chrome em: https://www.google.com/chrome/
echo.
pause
exit /b 1

:CHROME_FOUND
echo Chrome encontrado: %CHROME_PATH%
echo.

:MENU
echo Selecione o ambiente:
echo.
echo  1. Produção (nexopdv.emasoftware.io)
echo  2. Desenvolvimento (localhost:5000)
echo  3. Homologação
echo  4. URL Personalizada
echo  5. Sair
echo.

set /p CHOICE="Digite o número da opção desejada: "

if "%CHOICE%"=="1" (
    set "URL=https://nexopdv.emasoftware.io/login"
) else if "%CHOICE%"=="2" (
    echo.
    set /p PORT="Digite a porta em que o projeto está rodando (padrão: 5000): "
    
    :: Se o usuário não digitar nada, usa a porta padrão 5000
    if "!PORT!"=="" set "PORT=5000"
    
    set "URL=http://localhost:!PORT!/login"
    echo.
    echo URL configurada: !URL!
    echo.
) else if "%CHOICE%"=="3" (
    set "URL=https://homolog.nexopdv.emasoftware.io/login"
) else if "%CHOICE%"=="4" (
    echo.
    set /p URL="Digite a URL completa do Nexo PDV: "
) else if "%CHOICE%"=="5" (
    exit /b 0
) else (
    echo.
    echo Opção inválida. Por favor, tente novamente.
    echo.
    goto :MENU
)

echo.
echo Iniciando Nexo PDV em modo app (sem barra de URL) para: %URL%
echo.
echo Iniciando em 3 segundos...
timeout /t 3 >nul

:: Inicia o Chrome em modo app
echo Executando: "%CHROME_PATH%" --app=%URL% --disable-pinch --overscroll-history-navigation=0 --disable-features=TranslateUI --no-first-run --disable-infobars
start "" "%CHROME_PATH%" --app=%URL% --disable-pinch --overscroll-history-navigation=0 --disable-features=TranslateUI --no-first-run --disable-infobars

if %ERRORLEVEL% neq 0 (
    echo.
    echo ERRO: Falha ao iniciar o Chrome. Código de erro: %ERRORLEVEL%
    echo.
)

echo.
echo Chrome iniciado em modo app.
echo.
echo O Nexo PDV foi aberto em uma nova janela sem barra de URL.
echo.

:MAIN_MENU
echo.
echo ===================================
echo   MENU PRINCIPAL - NEXO PDV KIOSK
echo ===================================
echo.
echo  1. Abrir outra instância do Nexo PDV
echo  2. Mudar de ambiente (produção, desenvolvimento, etc.)
echo  3. Sair
echo.

set /p MAIN_CHOICE="Digite o número da opção desejada: "

if "%MAIN_CHOICE%"=="1" (
    echo.
    echo Iniciando nova instância do Nexo PDV em: %URL%
    start "" "%CHROME_PATH%" --app=%URL% --disable-pinch --overscroll-history-navigation=0 --disable-features=TranslateUI --no-first-run --disable-infobars
    goto :MAIN_MENU
) else if "%MAIN_CHOICE%"=="2" (
    goto :MENU
) else if "%MAIN_CHOICE%"=="3" (
    echo.
    echo Saindo...
    exit /b 0
) else (
    echo.
    echo Opção inválida. Por favor, tente novamente.
    goto :MAIN_MENU
)

exit /b 0