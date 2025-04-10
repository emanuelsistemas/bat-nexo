@echo off
:: Nexo PDV - Modo App (Sem Barra de URL) - Com Seleção de Porta
:: Este arquivo abre o Nexo PDV em modo app no Chrome, sem mostrar a barra de URL

echo.
echo  ===================================
echo    NEXO PDV - MODO APP SEM BARRA URL
echo  ===================================
echo.

:: Solicita a porta
set /p PORT="Digite a porta em que o projeto está rodando (padrão: 5173): "

:: Se o usuário não digitar nada, usa a porta padrão 5173
if "%PORT%"=="" set "PORT=5173"

:: Define a URL com a porta especificada
set "URL=http://localhost:%PORT%/"

echo.
echo URL configurada: %URL%
echo.
echo Pressione qualquer tecla para abrir o Nexo PDV...
pause >nul

:: Tenta abrir com o Chrome em diferentes locais possíveis
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --app=%URL% --start-fullscreen
) else if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app=%URL% --start-fullscreen
) else if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" (
    start "" "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" --app=%URL% --start-fullscreen
) else (
    echo Chrome não encontrado. Por favor, instale o Google Chrome.
    pause
)