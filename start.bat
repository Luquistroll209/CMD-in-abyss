@echo off

echo Que sistema grafico quieres usar?
echo.
echo 1. Sistema ANSI (Mejor calidad, peor compatibilidad)
echo 2. Sistema ASCII (Peor calidad, mayor compatibilidad)

choice /c 12 /m "Eleccion:"

if %errorlevel% == 2 (
        call ascii.bat
)
if %errorlevel% == 1 (
    call ansi.bat
)