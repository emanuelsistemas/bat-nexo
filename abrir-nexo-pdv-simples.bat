@echo off
:: Nexo PDV - Modo App (Sem Barra de URL)
:: Este arquivo abre o Nexo PDV em modo app no Chrome, sem mostrar a barra de URL

:: URL do Nexo PDV
set "URL=https://nexopdv.emasoftware.io/login"

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