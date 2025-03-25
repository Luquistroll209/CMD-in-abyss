@echo off
setlocal EnableDelayedExpansion
::msg * Para una mejor experiencia, use cascos y tenga VLC instalado en su ordenador
::msg * ATENCION: No cierre el CMD mientras suene alguna musica o cancion y ponga el CMD en pantalla completa
::msg * No cotiene spoilers importantes de la serie original unicamente nombres de las bestias
:: Variables iniciales
:: 0 = false
:: 1 = true
set "nombre="
set /a Layer=0
set /a Live=350
set /a Hunger=100
set /a PeleasHechas=0
set "inventario=Agua,Agua,Carne,Carne,PocionDeCura,PocionDedanio"
set "efecto[Agua]=[+35 de hambre]"
set "efecto[Carne]=[+35 de hambre]"
set "efecto[PocionDeCura]=[+75%% de vida]"
set "efecto[RaizNutritiva]=[+5 de hambre +25 vida]"
set "efecto[Orbe]=[Seras teletransportado a ORTH y terminaras tu mision Ganando una fortuna]"
set "efecto[FlorExtrania]=[#?#?#?#?]"
set "efecto[PocionDedaño]=[+10%% de daño]"
set "efecto[Vallas]=[+10 de hambre +5 vida]"
set "EscenaIRConsumir="
:: Agua [+10 de hambre]
:: Carne [+15 de hambre]
:: PocionDeCura [+75% de vida]
:: RaizNutritiva [+5 de hambre]
:: Orbe [Te pasas el juego]
:: FlorExtraniaa [?¿?¿?¿?¿?¿]
:: PociónDedanio [+10% de daño]

set /a incrementoDeDaño=0

set /a puedesPasar=0
set /a llegadoCapa5=0
set /a Danio=15
set "objDefensa="

set /a UsosIncinerador=0
set /a UsosPalo=0
set /a iaAtacar=0
set /a spoilers=0
set /a CombateEmpezado=0
set /a delObj=""

set /a EscenaIrConsumir=""
set /a EscenaIr=""
:: 0 No
:: 1 Si

set /a ContadorDeCambios=0

:Principio
    color c
    cls
    echo Este proyecto contiene spoilers del manga y anime original, aunque he intentado que sean los menos posible, esta historia no se basa en la historia principal por tanto no hay spoilers fuertes, unicamente sobre algunas de las capas aunque no muestra como son
    choice /c YN /m "Quieres Spoilers? (Y/N):"
    if %errorlevel% == 2 (
        set /a spoilers=0
        echo No tendras nada de spoilers disfruta

    )
    if %errorlevel% == 1 (
        set /a spoilers=1
        echo Tendras spoilers del manga y anime, disfruta
    )
    pause>nul
    cls
    color 07
    type Resources\Title.txt
    title Made In Abyss
    set /p nombre="Introduce un nombre: "

    echo Hola %nombre%, acabas de llegar al pueblo de Orth situado alrededor del abismo. Eres un explorador de cuevas.
    echo Pulsa cualquier tecla para seguir.
    pause>nul
    echo Vas a bajar al abismo a recuperar un viejo artefacto llamado *Hilo infinito*, aunque si quieres puedes seguir bajando.
    echo .
    echo Pulsa cualquier tecla para seguir.
    pause>nul
    echo Aunque ten cuidado, hay una maldicion que si subes te pueden suceder cosas:
    echo.
    echo ========= Maldicion ==========
    echo Capa 1: Mareo
    echo Capa 2: Vomito
    echo Capa 3: Paranoia
    echo Capa 4: Bajara tu vida
    echo Capa 5: Perdida de los sentidos totales
    echo Capa 6: Perdida de la humanidad
    echo Capa 7: Muerte
    echo ==============================
    echo Esto solo te afectara si subes.
    echo ==============================
    choice /c NY /m "Pon N si no quieres e Y si quieres: "

    if !errorlevel! == 2 (
        echo Bien, te he proporcionado una mochila con algunas cosas como: !inventario!.
        pause
        echo Buena suerte %nombre%.
        echo pulsa cualquier tecla para abrir el Eleccionador de avilidades
        pause>nul

        goto eleccionAvilidades
    ) else (
        goto Muerte
    )
:eleccionAvilidades
    cls
    color a
    echo ================== Eleccion de habilidades ============================================
    echo                          Defensa
    echo ---------------------------------------------------------------------------------------
    echo 1. Escudo Maximo [10%% de recibir danio] [-50 de hambre] 
    echo 2. Escudo Medio [50%% de recibir danio y reducido] [-30 de hambre]
    echo 3. Escudo pequeno [75%% de recibir danio] [-10 de hambre]
    echo 4. Escudo reflector [devuelve su ataque x2] [-10 de vida y -100 de hambre] 
    echo 5. Palo de madera [puede devolver cualquier ataque] [unicamente lo puedes usar 1 vez]
    echo =======================================================================================

    choice /c 12345 /m "Elige un numero de avilidad podras cambiarlo antes de empezar la partida: "
    if errorlevel 5 set /a objDefensa=5
    if errorlevel 4 set /a objDefensa=4
    if errorlevel 3 set /a objDefensa=3
    if errorlevel 2 set /a objDefensa=2
    if errorlevel 1 set /a objDefensa=1
    cls 
    color c
    echo ================== Eleccion de habilidades ============================================
    echo                          Ataque
    echo ---------------------------------------------------------------------------------------
    echo 1. Incinerador [100%% de danio] [-100 de hambre y -20 de vida, uso 2 veces] 
    echo 2. Cuchillo [10 de danio] [-3 de hambre]
    echo 3. Hacha [20 de danio] [-20 de hambre]
    echo 4. Lanza [30 de danio] [-25 de hambre]
    echo 5. Lanzallamas portatil [70%% de danio] [-40 de vida]
    echo 6. Mazo [30%% de danio] [-30 de hambre]
    echo =======================================================================================

    echo Elige 3 habilidades de ataque (ingresa los numeros separados por espacios, por ejemplo: 1 2 3)
    set /p elecciones="Elige tus 3 habilidades: "
    for /f "tokens=1,2,3" %%a in ("%elecciones%") do (
        set habilidad1=%%a
        set habilidad2=%%b
        set habilidad3=%%c
        
    )
    


    cls
	color e
    echo ================ Avilidades de %nombre% ================
    echo Defensa:     
	if "%objDefensa%"=="1" echo 1. Escudo Maximo [10%% de recibir danio] [-50 de hambre] 
    if "%objDefensa%"=="2" echo 2. Escudo Medio [50%% de recibir danio y reducido] [-30 de hambre] [-30 de hambre] [-30 de hambre] [-30 de hambre] [-30 de hambre] [-30 de hambre]
    if "%objDefensa%"=="3" echo 3. Escudo pequeno [75%% de recibir danio] [-10 de hambre]
    if "%objDefensa%"=="4" echo 4. Escudo reflector [devuelve su ataque x2] [-10 de vida y -100 de hambre]
    if "%objDefensa%"=="5" echo 5. Palo de madera [puede devolver cualquier ataque] [unicamente lo puedes usar 1 vez]
    echo ------------------------Ataque--------------------------
    set habilidades[1]=1. Incinerador [100%% de danio] [-100 de hambre y -20 de vida, uso 2 veces]
    set habilidades[2]=2. Cuchillo [10 de danio] [-3 de hambre]
    set habilidades[3]=3. Hacha [20 de danio] [-20 de hambre]
    set habilidades[4]=4. Lanza [30 de danio] [-25 de hambre]
    set habilidades[5]=5. Lanzallamas portatil [70%% de danio] [-40 de vida]
    set habilidades[6]=6. Mazo [30%% de danio] [-30 de hambre]

    for %%i in (1 2 3) do (
        for /f "tokens=2 delims==" %%h in ('set habilidad%%i 2^>nul') do (
            if defined habilidades[%%h] echo !habilidades[%%h]!
        )
    )
    echo ========================================================

    choice /c YN /m "Estas seguro de tus elecciones? (Y/N): "
    if errorlevel 2 goto eleccionAvilidades
    paus
    goto Presentacion

:MostrarHabilidad
    if "%1"=="1" echo 1. Incinerador [100% de daño] [-100 de hambre y -20 de vida, uso 2 veces]
    if "%1"=="2" echo 2. Cuchillo [10 de daño] [-3 de hambre]
    if "%1"=="3" echo 3. Hacha [20 de daño] [-20 de hambre]
    if "%1"=="4" echo 4. Lanza [30 de daño] [-25 de hambre]
    if "%1"=="5" echo 5. Lanzallamas portatil [70% de daño] [-40 de vida]
    if "%1"=="6" echo 6. Mazo [30% de daño] [-30 de hambre]




:Presentacion
    rem start /B vlc --intf dummy "Music/intro.mp3"
    rem taskkill /IM vlc.exe /F
    cls
    type Resources\Title.txt
    goto Juego

    :Juego
    cls
    type Resources\Title.txt

:Menu
    cls
    color 07
    if !Hunger! LSS 15 (
        echo Tienes hambre, tu vida esta bajando
        set /a Live-=!random! %% 30
    )
    if %live% LSS 0 (
        goto Muerte
    )
    echo ================ Menu ================
    echo Estas en la capa %Layer%
    echo Vida: %Live% Hambre: %Hunger%
    echo --------- Acciones ---------
    echo 1. Ascender
    echo 2. Descender
    echo 3. Inventario
    echo 4. Buscar artefactos
    echo 5. Informacion
    rem En la Capa 2 deberias hablar con ozen la inamovible para que te diga que Bondriew es un mentiroso cochino y que te intentara mentir pero que en la capa 6 no esta el hilo no sabe donde esta pero esta antes de la capa 6
    rem La capa 6 sera una tranpa que te dira bondriew
    if %Layer% == 5 echo 6. Hablar con Bondrewd
    if %Layer% == 6 echo 7. Nota de Bondrewd
    echo ======================================
    if %Layer% == 5 (
        choice /c 123456 /m "Elige un numero de accion: "
    ) else if %Layer% == 6 (
        choice /c 123456 /m "Elige un numero de accion: "
    ) else (
        choice /c 12345 /m "Elige un numero de accion: "
    )

    if %Layer% == 6 (
        if !errorlevel! == 6 goto NotaBondrewd
    )
    if %Layer% == 5 (
        if !errorlevel! == 6 goto HablarBondrewd
    )
    if !errorlevel! == 5 goto Informacion
    if !errorlevel! == 4 goto BuscarArtefactos
    if !errorlevel! == 3 (
        set /a EscenaIr="InventoryList"
        goto InventoryList
    )
    if !errorlevel! == 2 goto Descender rem EleccionDeCombate  rem Descender
    if !errorlevel! == 1 goto Ascender

:Informacion
    cls
    echo ================ Info de %nombre% ================
    echo 1. Mapa
    echo 2. avilidades
    echo 3. Misiones
    echo 4. Consejos de Supervivencia
    echo 5. Lore del Abismo
    echo 6. Maldiciones Conocidas
    echo 7. Volver al Menu
    echo ==================================================
    choice /c 1234567 /m "Selecciona una opcion: "

    if errorlevel == 7 goto Menu
    if errorlevel == 6 goto MaldicionesConocidas
    if errorlevel == 5 goto LoreAbismo
    if errorlevel == 4 goto ConsejosSupervivencia
    if errorlevel == 3 goto Misiones
    if errorlevel == 2 goto Avilidades
    if errorlevel == 1 goto Mapa

:Avilidades
    cls
    color e
    echo ================ Avilidades de %nombre% ================
    echo Defensa:     
	if "%objDefensa%"=="1" echo 1. Escudo Maximo [10%% de recibir danio] [-50 de hambre] 
    if "%objDefensa%"=="2" echo 2. Escudo Medio [50%% de recibir danio y reducido] [-30 de hambre] [-30 de hambre] [-30 de hambre] [-30 de hambre] [-30 de hambre] [-30 de hambre]
    if "%objDefensa%"=="3" echo 3. Escudo pequeno [75%% de recibir danio] [-10 de hambre]
    if "%objDefensa%"=="4" echo 4. Escudo reflector [devuelve su ataque x2] [-50 de vida y -100 de hambre]
    if "%objDefensa%"=="5" echo 5. Palo de madera [puede devolver cualquier ataque] [unicamente lo puedes usar 1 vez]
    echo ------------------------Ataque--------------------------
    set habilidades[1]=1. Incinerador [100%% de danio] [-100 de hambre y -20 de vida, uso 2 veces]
    set habilidades[2]=2. Cuchillo [10 de danio] [-3 de hambre]
    set habilidades[3]=3. Hacha [20 de danio] [-20 de hambre]
    set habilidades[4]=4. Lanza [30 de danio] [-25 de hambre]
    set habilidades[5]=5. Lanzallamas portatil [70%% de danio] [-40 de vida]
    set habilidades[6]=6. Mazo [30%% de danio] [-30 de hambre]

    for %%i in (1 2 3) do (
        for /f "tokens=2 delims==" %%h in ('set habilidad%%i 2^>nul') do (
            if defined habilidades[%%h] echo !habilidades[%%h]!
        )
    )
    echo ========================================================

    pause>nul
    goto Informacion
:Mapa
    type Resources\mapLayer%Layer%.txt
    echo .
    echo pulsa cualquier tecla para volver al menu de Informacion
    pause>null
    goto Informacion

:Misiones
    cls
    echo ================ Misiones ================
    echo - Recuperar el artefacto "Hilo Infinito" (Principal)
    if %llegadoCapa5% == 1 (
        echo - Descender hasta la Capa 5 y hablar con Bondrewd (Secundaria)
    )
    ::echo - Recolectar 5 artefactos raros (Opcional)
    echo ===========================================
    echo Pulsa cualquier tecla para volver.
    pause>nul
    goto Información

:ConsejosSupervivencia
    cls
    echo ========= Consejos de Supervivencia =========
    echo 1. Mantente bien alimentado, la falta de hambre reduce tu vida.
    echo 2. Asciende con cuidado o moriras
    echo 3. Explora cada capa en busca de artefactos y recursos.
    echo 4. Habla con personajes clave antes de seguir descendiendo.
    echo 5. Guarda recursos esenciales como agua y comida.
    echo ============================================
    echo Pulsa cualquier tecla para volver.
    pause>nul
    goto Información

:LoreAbismo
    cls
    echo ================ Lore del Abismo ================
    echo El Abismo es un gigantesco pozo que se adentra en la Tierra.
    echo Cada capa tiene peligros unicos y criaturas misteriosas.
    echo La "maldicion del abismo" afecta a quien intente ascender.
    echo Exploradores legendarios han dejado artefactos invaluables.
    echo Muchos han desaparecido buscando el fondo del abismo...
    echo =====================================================
    echo Pulsa cualquier tecla para volver.
    pause>nul
    goto Información

:MaldicionesConocidas
    cls
    echo ========= Maldiciones Conocidas =========
    echo Capa 1: Mareo leve.
    echo Capa 2: Vomito intenso.
    echo Capa 3: Paranoia.
    echo Capa 4: Disminucion de vida.
    echo Capa 5: Perdida total de los sentidos.
    echo Capa 6: Perdida de la humanidad.
    echo Capa 7: Muerte inevitable.
    echo ========================================
    echo Pulsa cualquier tecla para volver.
    pause>nul
    goto Información


:Ascender
    if not %Layer% == 0 (
        echo Subiendo capa...
        set /a Layer-=1
        if %Layer% == 1 echo Sientes un leve mareo...
		if %Layer% == 2 echo (
			echo Tienes nauseas y vomitas.
			set /a Hunger-=!random! %% 20
		)
		if %Layer% == 3 echo Sufres paranoia.
		if %Layer% == 4 (
			echo Tu vida disminuye por la maldicion.
			set /a Live-=2!random! %% 40
		)
		if %Layer% == 4 (
			echo Tu vida disminuye por la maldicion.
			set /a Live-=2!random! %% 40
		)
		if %Layer% == 6 goto Muerte
		if %Layer% == 7 goto Muerte
        pause>nul
        call :Hambre
    ) else (
        echo ya estar en orth
    )
echo Pulsa cualquier tecla para avanzar
pause>nul
goto Menu

:Descender
    if %Layer% == 5 (
        if %puedesPasar% == 1 (
            if %Layer% == 7 (
                echo Has llegado al limite de la capa 6 en la entrada del 7. Ya no puedes bajar mas.
                set /a llegadoCapa5=1
            ) else (
                echo Descendiendo capa...
                set /a Layer+=1
                pause>nul
                echo Ahora estas en la capa %Layer%
            
            )
        ) else (
            echo Tienes que hablar con un tal Bondrewd para poder entrar
        )
    ) else (
        if %Layer% == 7 (
            echo Has llegado al limite de la capa 6 en la entrada del 7. Ya no puedes bajar mas.
        ) else (
            echo Descendiendo capa...
            set /a Layer+=1
   
            echo Ahora estas en la capa %Layer%
            call :Hambre
            pause>nul

        )
    )
    pause
    goto Menu

:BuscarArtefactos
    echo Buscando artefactos...
    set /a encontradoCapa=!random! %% 2
    set /a encontrado=!random! %% 10

    if %Layer% == 6 (
        if !encontradoCapa! == 1 (
            echo Has encontrado un artefacto raro: Hilo Infinito
            set "inventario=!inventario!,Hilo Infinito"
        ) else (
            call :BuscarObjetos
        )
    ) else (
        call :BuscarObjetos
    )
    goto Menu

:BuscarObjetos
    if not %layer% == 0 (
        if !encontrado! == 1 (
            echo Has encontrado: Carne
            set "inventario=!inventario!,Carne"
        )
        if !encontrado! == 2 (
            echo Has encontrado: Agua
            set "inventario=!inventario!,Agua"
            )
        if !encontrado! == 3 (
            echo Has encontrado: RaizNutritiva
            set "inventario=!inventario!,RaizNutritiva"
            )
        if !encontrado! == 4 (
            echo Has encontrado: Pocion De Cura
            set "inventario=!inventario!,PocionDeCura"
            )
        if !encontrado! == 5 (
            echo Has encontrado: Vallas
            set "inventario=!inventario!,Vallas"
            )
        if !encontrado! GEQ 6 (
            echo No se ha encontrado nada.
            )
    ) else (
        echo En la capa 0 no hay nada que ver
    )
    if %Layer% == 4 (
        set "inventario=!inventario!,Orbe"
        echo has encontrado un orbe, puedes usarlo y te teletransportara a ORTH y lo podras vender si quieres, por 10.000.000$
    )
    echo Pulsa cualquier tecla para avanzar.
    pause>nul
    goto Menu

:InventoryList
:InvMenu
    color 07
    cls
    set /a contador=0
    echo ================ Inventario ================
    echo 0. Exit


    set /a contador=0
    set "itemList="

    for %%a in (%inventario%) do (
        set "found=0"
        if defined itemList (
            for %%i in (!itemList!) do (
                if "%%i"=="%%a" (
                    set "found=1"
                )
            )
        )
        if "!found!"=="0" (
            if defined itemList (
                set "itemList=!itemList!,%%a"
            ) else (
                set "itemList=%%a"
            )
        )
    )

    set /a contador=0
    for %%a in (!itemList!) do (
        set /a contador+=1
        set "item[!contador!]=%%a"

        set /a "cantidad=0"
        for %%b in (%inventario%) do (
            if "%%b"=="%%a" (
                set /a cantidad+=1
            )
        )
        set "cantidad[!contador!]=!cantidad!"
        

        echo !contador!. %%a x!cantidad! !efecto[%%a]!
    )

    echo ============================================
    echo 1. Consumir
    echo 2. Volver al menu
    echo ============================================
    choice /c 12 /m "Selecciona una opcion: "

    if !errorlevel! == 2 (
        goto Menu
    )
    if !errorlevel! == 1 (
        
        goto Consumir
        set "EscenaIRConsumir=InvMenu"
    )
    goto %EscenaIr%

:AgregarObjeto
    rem no se usa pero por si acaso
    set /p nuevoObj="Introduce el nombre del objeto a agregar: "
    set "inventario=!inventario!,!nuevoObj!"
    echo Objeto agregado: !nuevoObj!
    echo Pulsa cualquier tecla para avanzar.
    pause>nul
    
    goto InvMenu

:Consumir
    cls
    color a
    echo ================ Inventario ================
    echo 0. Exit

    set /a contador=0
    set "itemList="
    for %%a in (%inventario%) do (
        set "found=0"
        if defined itemList (
            for %%i in (!itemList!) do (
                if "%%i"=="%%a" (
                    set "found=1"
                )
            )
        )
        if "!found!"=="0" (
            if defined itemList (
                set "itemList=!itemList!,%%a"
            ) else (
                set "itemList=%%a"
            )
        )
    )

    set /a contador=0
    for %%a in (!itemList!) do (
        set /a contador+=1
        set "item[!contador!]=%%a"

        set /a "cantidad=0"
        for %%b in (%inventario%) do (
            if "%%b"=="%%a" (
                set /a cantidad+=1
            )
        )
        set "cantidad[!contador!]=!cantidad!"

        echo !contador!. %%a x!cantidad! !efecto[%%a]!
    )

    echo ============================================
    echo.
    set /p seleccion=Elige el numero del objeto a consumir: 

    if "%seleccion%" == "0" (
        if "%CombateEmpezado%" == "1" (
            goto Combate
        ) else (
            goto InvMenu
        )
    ) else if !seleccion! LSS 1 (
        color c
        echo Opcion no valida.
        pause>nul
        goto Consumir
    ) else if !seleccion! GTR !contador! (
        color c
        echo Opcion no valida.
        pause>nul
        goto Consumir
    )

    set "objeto=!item[%seleccion%]!"
    echo Has consumido: !objeto! !efecto[%objeto%]!

    rem Efectos de los objetos
    if /i "!objeto!"=="Agua" (
        set /a Hunger=!Hunger!+35
        set /a Live=!Live!+15
        echo +35 de hambre sube un poco tu vida a +15
    ) else if /i "!objeto!"=="Carne" (
        set /a Hunger=!Hunger!+35
        set /a Live=!Live!+15
        echo +35 de hambre sube un poco tu vida a +15
    ) else if /i "!objeto!"=="PocionDeCura" (
        set /a Live=!Live!+15
        set /a Live=!Live!+!Live!*70/100
        echo tu vida a subido a !Live!
    ) else if /i "!objeto!"=="Orbe" (
        echo ¡Felicidades! Te has pasado el juego.
        goto GanasteFIN
        exit
    ) else if /i "!objeto!"=="RaizNutritiva" (
        set /a Hunger=!Hunger!+5
        set /a Live=!Live!+25
        echo +5 de hambre +15 de vida
    ) else if /i "!objeto!"=="FlorExtrania" (
        cls 
        echo empieza a dolerte la barriga 
        pause
        for /l %%i in (1,1,5) do (
            echo ves colores
            color 1
            color 2
            color 3
            color 4
            color 5
            color 6
            color 7
            color 8
            color 9
            color a
            color b
            color c
        )
    ) else if /i "!objeto!"=="PocionDedanio" (
        set /a incrementoDeDaño=!incrementoDeDaño!+!incrementoDeDaño!*10/100
        echo Tu daño ha aumentado un 10%%
    )

    set "nuevoInv="
    set "eliminado=0"
    for %%a in (%inventario%) do (
        if "!eliminado!"=="0" (
            if /i "%%a"=="!objeto!" (
                set "eliminado=1"
            ) else (
                if defined nuevoInv (
                    set "nuevoInv=!nuevoInv!,%%a"
                ) else (
                    set "nuevoInv=%%a"
                )
            )
        ) else (
            if defined nuevoInv (
                set "nuevoInv=!nuevoInv!,%%a"
            ) else (
                set "nuevoInv=%%a"
            )
        )
    )
    set "inventario=!nuevoInv!"

    echo.
    echo Presiona cualquier tecla para continuar...
    pause>nul

    if "%CombateEmpezado%" == "1" (
        goto Combate
    ) else (
        goto InvMenu
    )


:EliminarObjeto rem para el futuro alomejor ni se usa
    set "nuevoInv="
    for %%a in (!inventario:,= !) do (
        if /i not "%%a"=="!delObj!" (
            echo %%a
            if defined nuevoInv (
                set "nuevoInv=!nuevoInv!,%%a"
            ) else (
                set "nuevoInv=%%a"
            )
        )
    )
    set "inventario=!nuevoInv!"
    echo Objeto consumido (si existia): !delObj!

    goto %EscenaIr%
:Hambre
    rem if !live! LSS 0(
        if !ContadorDeCambios! GTR !random! %% 6 (
            set /a ContadorDeCambios=0
            set /a Hunger-=!random! %% 15
        )
   rem  )

    goto EleccionDeCombate

    
:AplicarMaldicion
    if %Layer% == 1 echo Sientes un leve mareo...
    if %Layer% == 2 echo (
        echo Tienes nauseas y vomitas.
        set /a Hunger-=!random! %% 20
    )
    if %Layer% == 3 echo Sufres paranoia.
    if %Layer% == 4 (
        echo Tu vida disminuye por la maldicion.
        set /a Live-=2!random! %% 40
    )
    if %Layer% == 4 (
        echo Tu vida disminuye por la maldicion.
        set /a Live-=2!random! %% 40
    )
    if %Layer% == 6 goto Muerte
    if %Layer% == 7 goto Muerte
    pause
    goto Menu





:HablarBondrewd
    cls
    color 0D
    echo ===============================
    echo        ^^^^ Bondrewd ^^^^ 
    echo ===============================
    echo Te encuentras con Bondrewd. Ten cuidado...
    echo.
    echo Que quieres hacer, %nombre%?
    echo [1] Preguntar por el hilo misterioso.
    echo [2] Preguntar sobre las capas del Abismo.
    echo [3] Quedarte en silencio...
    echo [4] Hablar mas a fondo...
    echo [5] Pedir Permiso para bajar a la 6 capa [ Mision Secundaria ]
    echo [6] Decir adios y volver al menu.
    echo.
    choice /c 123456 /m "Selecciona una opcion:"

    if %errorlevel% == 6 ( goto Menu ) 
    if %errorlevel% == 5 ( goto permisoCapa )
    if %errorlevel% == 4 ( goto HablarMas )
    if %errorlevel% == 3 ( goto Silencio )
    if %errorlevel% == 2 ( goto CapasAbismo )
    if %errorlevel% == 1 ( goto HiloMisterioso )
    
:permisoCapa
    cls
    set /a puedesPasar=1
    echo ===============================
    echo        ^^^^ Bondrewd ^^^^ 
    echo ===============================
    Color 4
    echo SOBRE MI CADAVER ALMENOS QUE ME MATES
    echo Te descuartizare, te hare pedazos, esparcire la sangre de tu profana forma por las ESTRELLAS! 
    echo Te triturare hasta que las chispas pidan piedad! Mis manos disfrutaran de tu fin... ¡AQUI! ¡Y! ¡AHORA!
    pause
    set NomBicho=Bondrewd
    set /a vidaBicho=!random! %% 50 + 10
    set /a dañoBicho=!random! %% 20 + 10  
    set /a numProbabilidadBich=50 
    goto Combate
    
:HiloMisterioso
    cls
    color 0A
    echo Bondrewd: "Ah, el hilo misterioso... si, si, lo conozco bien."
    timeout /t 2 >nul
    echo Bondrewd: "Esta... en la septima capa. ¡Nadie lo ha alcanzado! Es la ultima capa accesible, alli todo se vuelve mas... *peculiar*."
    timeout /t 2 >nul
    echo Bondrewd: "Los que han ido mas alla... bueno, ya no regresan. Pero... ¿quien sabe? Tal vez algun dia logres alcanzarlo."
    echo Bondrewd: "No te preocupes por la dificultad, el Abismo tiene sus... *formas* de probar a aquellos que buscan la verdad."
    timeout /t 3 >nul
    echo.
    echo Pulsa cualquier tecla para volver a hablar con Bondrewd.
    pause>nul
    goto HablarBondrewd

:CapasAbismo
    cls
    color 0E
    echo Bondrewd: "Las capas del Abismo... cada una tiene su propia naturaleza, su propia... *personalidad*."
    timeout /t 2 >nul
    echo Bondrewd: "Desde la capa mas superficial, hasta la septima, son como pruebas, cada una mas peligrosa y desafiante que la anterior. Y aunque algunos creen que el hilo esta en la septima... yo diria que esa es solo una... interpretacion."
    timeout /t 2 >nul
    echo Bondrewd: "La verdad... oh, la verdad, esta mas cerca de la cuarta capa. Pero claro, no es algo que muchos quieran aceptar."
    timeout /t 2 >nul
    echo Bondrewd: "Cada capa es una pieza de un rompecabezas que aun no hemos logrado entender del todo. La septima capa... eso es solo una *idea*. Lo que realmente importa esta mucho mas cerca."
    echo.
    echo Pulsa cualquier tecla para volver a hablar con Bondrewd.
    pause>nul
    goto HablarBondrewd

:Silencio
    cls
    color 07
    echo Bondrewd observa tu silencio con una sonrisa inquietante...
    timeout /t 2 >nul
    echo Bondrewd: "El silencio tambien es una respuesta interesante, ¿no lo crees?"
    echo.
    echo ===============================
    echo        ^^^^ Bondrewd ^^^^ 
    echo ===============================
    echo.
    echo Que quieres hacer, %nombre%?
    echo [1] Preguntar sobre el HiloMisterioso
    echo [2] Seguir en Silencio
    echo Pulsa cualquier tecla para volver a hablar con Bondrewd.
    choice /c 12 /m "Selecciona una opcion:"

    if errorlevel 2 goto HiloMisterioso
    if errorlevel 1 goto seguirSilencio
    goto HablarBondrewd

:seguirSilencio
    cls
    color 40
    echo Recibiste 20 de daño y saliste corriendo
    set /a live=%live%-20
	timeout /t 1 >nul
    color 07
    goto Menu
    

:HablarMas
    cls
    
    color 0C
    echo Bondrewd: "Oh, %nombre%, veo que eres persistente. Quizas pueda revelarte algo mas..."
    echo.
    echo [a] Insistir en saber la verdad.
    echo [b] Hablar sobre sacrificios del Abismo.
    if %spoilers% == 0 (
        echo [c] Preguntar ##### #######. [spoilers]
    ) else (
        echo [c] Preguntar sobre Prushka. [spoilers]
    )
    echo [d] Volver al menu principal.
    echo.
    if %spoilers% == 0 (
        choice /c abcd /m "¿Que deseas saber mas? (a: verdad, b: sacrificios, c: #######, d: regresar)"
    ) else (
        choice /c abcd /m "¿Que deseas saber mas? (a: verdad, b: sacrificios, c: Prushka, d: regresar)"
    )
    if errorlevel 4 goto Menu
    if errorlevel 3 goto Prushka
    if errorlevel 2 goto Sacrificios
    if errorlevel 1 goto Verdad

:Verdad
    cls
    color 0F
    echo Bondrewd: "La verdad... la verdad es... dificil de digerir, pero, sigues insistiendo..."
    timeout /t 2 >nul
    echo Bondrewd: "Muy bien, te lo dire, %nombre%... el hilo esta en la cuarta capa."
    timeout /t 3 >nul
    echo Bondrewd: "No en la septima, como muchos creen... No, no, ese es solo un mito, una leyenda."
    timeout /t 2 >nul
    echo Bondrewd: "Lo encontre alli, en la cuarta capa, entre las sombras y las pruebas. Pero... hay un precio a pagar. ¿Estas dispuesto a pagarlo?"
    echo.
    echo Pulsa cualquier tecla para volver a hablar con Bondrewd.
    pause>nul
    goto HablarBondrewd

:Sacrificios
    cls
    color 05
    echo Bondrewd: "Ah, los sacrificios... ¿Que tan lejos estarías dispuesto a llegar para obtener mas conocimiento?"
    timeout /t 2 >nul
    echo Bondrewd: "El Abismo exige sacrificios, %nombre%. Pero no son solo sacrificios fisicos... no, no... son sacrificios de la mente, de la voluntad, de la esencia misma."
    timeout /t 2 >nul
    echo Bondrewd: "Algunos dicen que el Abismo consume lo que mas aprecias. Pero tal vez... tal vez esa es la unica forma de ganar algo realmente valioso."
    echo.
    echo Pulsa cualquier tecla para volver a hablar con Bondrewd.
    pause>nul
    goto HablarBondrewd

:Prushka
    cls
    color 09
    echo Bondrewd se queda en silencio unos segundos...
    timeout /t 2 >nul
    echo Bondrewd: "Prushka... Ah, mi querida hija. Ella formo parte de mi ascenso. Pero, ¿que es un sacrificio sin la oportunidad de hacer un descubrimiento aun mayor?"
    timeout /t 2 >nul
    echo Bondrewd: "Ella... como todos los demas, fue parte de la ecuacion. Una ecuacion que, tal vez, tu tambien resolveras si sigues descendiendo lo suficiente."
    echo.
    echo Pulsa cualquier tecla para volver a hablar con Bondrewd.
    pause>nul
    goto HablarBondrewd

:EleccionDeCombate
    if %Layer% == 0 (
        set /a tipoDeBicho=!random! %% 5
    
        if !tipoDeBicho! == 0 (
            set NomBicho=Pollo
            set /a vidaBicho=!random! %% 10 + 3
            set /a dañoBicho=0
            set /a numProbabilidadBich=90  
        )
        if !tipoDeBicho! == 1 (
            set NomBicho=Rata
            set /a vidaBicho=!random! %% 6 + 2
            set /a dañoBicho=0
            set /a numProbabilidadBich=92 
        )
        if !tipoDeBicho! == 2 (
            set NomBicho=Rana
            set /a vidaBicho=!random! %% 8 + 2
            set /a dañoBicho=0
            set /a numProbabilidadBich=93 
        )
        if !tipoDeBicho! == 3 (
            set NomBicho=Hormiga
            set /a vidaBicho=!random! %% 5 + 2
            set /a dañoBicho=0
            set /a numProbabilidadBich=94
        )
        if !tipoDeBicho! == 4 (
            set NomBicho=Gusano
            set /a vidaBicho=!random! %% 7 + 3
            set /a dañoBicho=0
            set /a numProbabilidadBich=95
        )
    )

    if %Layer% == 1 (
        set /a tipoDeBicho=!random! %% 6
    
        if !tipoDeBicho! == 0 (
            set NomBicho=Kakurenbo
            set /a vidaBicho=!random! %% 10 + 2
            set /a dañoBicho=!random! %% 6 + 2
            set /a numProbabilidadBich=90
        )
        if !tipoDeBicho! == 1 (
            set NomBicho=Regu
            set /a vidaBicho=!random! %% 7 + 1
            set /a dañoBicho=!random! %% 2 + 1
            set /a numProbabilidadBich=90
        )
        if !tipoDeBicho! == 2 (
            set NomBicho=Armadillo
            set /a vidaBicho=!random! %% 20 + 1
            set /a dañoBicho=!random! %% 4 + 1
            set /a numProbabilidadBich=80
        )
        if !tipoDeBicho! == 3 (
            set NomBicho=Vesp
            set /a vidaBicho=!random! %% 20 + 1
            set /a dañoBicho=!random! %% 2 + 1
            set /a numProbabilidadBich=85
        )
        if !tipoDeBicho! == 4 (
            set NomBicho=Ganja
            set /a vidaBicho=!random! %% 15 + 1
            set /a dañoBicho=!random! %% 3 + 1
            set /a numProbabilidadBich=85
        )
        if !tipoDeBicho! == 5 (
            set NomBicho=Ganja
            set /a vidaBicho=!random! %% 15 + 1
            set /a dañoBicho=!random! %% 3 + 1
            set /a numProbabilidadBich=80
        )
    )

    if %Layer% == 2 (
        set /a tipoDeBicho=!random! %% 6
    
        if !tipoDeBicho! == 0 (
            set NomBicho=Umbra
            set /a vidaBicho=!random! %% 30 + 10
            set /a dañoBicho=!random! %% 6 + 4
            set /a numProbabilidadBich=75
        )
        if !tipoDeBicho! == 1 (
            set NomBicho=Horned_Trunk
            set /a vidaBicho=!random! %% 20 + 20
            set /a dañoBicho=!random! %% 10 + 6
            set /a numProbabilidadBich=70
        )
        if !tipoDeBicho! == 2 (
            set NomBicho=Oozing_Grasshopper
            set /a vidaBicho=!random! %% 20 + 15
            set /a dañoBicho=!random! %% 8 + 5
            set /a numProbabilidadBich=75
        )
        if !tipoDeBicho! == 3 (
            set NomBicho=Ganja 
            set /a vidaBicho=!random! %% 30 + 10
            set /a dañoBicho=!random! %% 8 + 6
            set /a numProbabilidadBich=80
        )
        if !tipoDeBicho! == 4 (
            set NomBicho=Giran
            set /a vidaBicho=!random! %% 23 + 15
            set /a dañoBicho=!random! %% 10 + 7
            set /a numProbabilidadBich=80
        )
        if !tipoDeBicho! == 5 (
            set NomBicho=Inbyo
            set /a vidaBicho=!random! %% 20 + 10
            set /a dañoBicho=!random! %% 12 + 8
            set /a numProbabilidadBich=70
        )
    )
    if %Layer% == 3 (
        set /a tipoDeBicho=!random! %% 6
    
        if !tipoDeBicho! == 0 (
            set NomBicho=Rabid_Large_Worm
            set /a vidaBicho=!random! %% 10 + 2
            set /a dañoBicho=!random! %% 12 + 3
            set /a numProbabilidadBich=50
        )
        if !tipoDeBicho! == 1 (
            set NomBicho=Ghost_Whale
            set /a vidaBicho=!random! %% 29 + 3
            set /a dañoBicho=!random! %% 10 + 2
            set /a numProbabilidadBich=65
        )
        if !tipoDeBicho! == 2 (
            set NomBicho=Explorador_de_Cuevas
            set /a vidaBicho=!random! %% 10 + 1
            set /a dañoBicho=!random! %% 15 + 5
            set /a numProbabilidadBich=65
        )
        if !tipoDeBicho! == 3 (
            set NomBicho=Ogre 
            set /a vidaBicho=!random! %% 30 + 10
            set /a dañoBicho=!random! %% 13 + 20
            set /a numProbabilidadBich=60
        )
        if !tipoDeBicho! == 4 (
            set NomBicho=Yubru
            set /a vidaBicho=!random! %% 70 + 30
            set /a dañoBicho=!random! %% 20 + 12
            set /a numProbabilidadBich=70
        )
        if !tipoDeBicho! == 5 (
            set NomBicho=Uroboro
            set /a vidaBicho=!random! %% 8000000 + 35
            set /a dañoBicho=!random! %% 10 + 1
            set /a numProbabilidadBich=60
        )
    )
    if %Layer% == 4 (
        set /a tipoDeBicho=!random! %% 6
    
        if !tipoDeBicho! == 0 (
            set NomBicho=Umbra_Head
            set /a vidaBicho=!random! %% 100 + 60
            set /a dañoBicho=!random! %% 20 + 20
            set /a numProbabilidadBich=55
        )
        if !tipoDeBicho! == 1 (
            set NomBicho=Phantom_Wyrm
            set /a vidaBicho=!random! %% 250 + 120
            set /a dañoBicho=!random! %% 20 + 50
            set /a numProbabilidadBich=50
        )
        if !tipoDeBicho! == 2 (
            set NomBicho=Giant_Spider
            set /a vidaBicho=!random! %% 300 + 150
            set /a dañoBicho=!random! %% 20 + 40
            set /a numProbabilidadBich=55
        )
        if !tipoDeBicho! == 3 (
            set NomBicho=Swarm_of_Scarabs
            set /a vidaBicho=!random! %% 200 + 100
            set /a dañoBicho=!random! %% 20 + 20
            set /a numProbabilidadBich=50
        )
        if !tipoDeBicho! == 4 (
            set NomBicho=Fake_King_of_Abyss 
            set /a vidaBicho=!random! %% 350 + 200
            set /a dañoBicho=!random! %% 30 + 20
            set /a numProbabilidadBich=60
        )
        if !tipoDeBicho! == 5 (
            set NomBicho=Tamaugachi
            set /a vidaBicho=!random! %% 20000 + 20000
            set /a dañoBicho=!random! %% 10 + 10
            set /a numProbabilidadBich=60
        )
    )
    if %Layer% == 5 (
        set /a tipoDeBicho=!random! %% 6
        if !tipoDeBicho! == 0 (
            set NomBicho=Large_Abyss_Crater
            set /a vidaBicho=!random! %% 450 + 300
            set /a dañoBicho=!random! %% 10 + 10
            set /a numProbabilidadBich=45
        )
        if !tipoDeBicho! == 1 (
            set NomBicho=Enraged_Mist_Demon
            set /a vidaBicho=!random! %% 500 + 350
            set /a dañoBicho=!random! %% 10 + 30
            set /a numProbabilidadBich=50
        )
        if !tipoDeBicho! == 2 (
            set NomBicho=Hollow_Knight
            set /a vidaBicho=!random! %% 600 + 450
            set /a dañoBicho=!random! %% 20 + 20
            set /a numProbabilidadBich=45
        )
        if !tipoDeBicho! == 3 (
            set NomBicho=Rage_Beast
            set /a vidaBicho=!random! %% 700 + 500
            set /a dañoBicho=!random! %% 20 + 30
            set /a numProbabilidadBich=40
        )
    )
    if %Layer% == 6 (
        set /a tipoDeBicho=!random! %% 6

        if !tipoDeBicho! == 0 (
            set NomBicho=Umbra_Head
            set /a vidaBicho=!random! %% 120 + 80
            set /a dañoBicho=!random! %% 40 + 20
            set /a numProbabilidadBich=50
        )
        if !tipoDeBicho! == 1 (
            set NomBicho=Phantom_Wyrm
            set /a vidaBicho=!random! %% 150 + 100
            set /a dañoBicho=!random! %% 60 + 30
            set /a numProbabilidadBich=45
        )
        if !tipoDeBicho! == 2 (
            set NomBicho=Giant_Spider
            set /a vidaBicho=!random! %% 180 + 100
            set /a dañoBicho=!random! %% 50 + 30
            set /a numProbabilidadBich=50
        )
        if !tipoDeBicho! == 3 (
            set NomBicho=Swarm_of_Scarabs
            set /a vidaBicho=!random! %% 160 + 90
            set /a dañoBicho=!random! %% 40 + 20
            set /a numProbabilidadBich=50
        )
        if !tipoDeBicho! == 4 (
            set NomBicho=Fake_King_of_Abyss
            set /a vidaBicho=!random! %% 200 + 150
            set /a dañoBicho=!random! %% 60 + 40
            set /a numProbabilidadBich=55
        )
        if !tipoDeBicho! == 5 (
            set NomBicho=Nightmare_Golem
            set /a vidaBicho=!random! %% 250 + 200
            set /a dañoBicho=!random! %% 80 + 50
            set /a numProbabilidadBich=55
        )
    )

    if %Layer% == 7 (
        set /a tipoDeBicho=!random! %% 6

        if !tipoDeBicho! == 0 (
            set NomBicho=Ryuusazai 
            set /a vidaBicho=!random! %% 300000 + 25000000
            set /a dañoBicho=!random! %% 100000 + 70000
            set /a numProbabilidadBich=40
        )
        if !tipoDeBicho! == 1 (
            set NomBicho=Enraged_Mist_Demon
            set /a vidaBicho=!random! %% 350 + 300
            set /a dañoBicho=!random! %% 110 + 80
            set /a numProbabilidadBich=45
        )
        if !tipoDeBicho! == 2 (
            set NomBicho=Hollow_Knight
            set /a vidaBicho=!random! %% 450 + 350
            set /a dañoBicho=!random! %% 130 + 90
            set /a numProbabilidadBich=40
        )
        if !tipoDeBicho! == 3 (
            set NomBicho=Rage_Beast
            set /a vidaBicho=!random! %% 500 + 400
            set /a dañoBicho=!random! %% 150 + 100
            set /a numProbabilidadBich=35
        )
        if !tipoDeBicho! == 4 (
            set NomBicho=Infernal_Titan
            set /a vidaBicho=!random! %% 500 + 350
            set /a dañoBicho=!random! %% 140 + 90
            set /a numProbabilidadBich=40
        )
        if !tipoDeBicho! == 5 (
            set NomBicho=Chaos_Demon
            set /a vidaBicho=!random! %% 550 + 400
            set /a dañoBicho=!random! %% 130 + 100
            set /a numProbabilidadBich=40
        )
    )

    goto Combate
:Combate
    cls
    set "EscenaIRConsumir=Combate"
    if %live% LSS 0 goto Muerte
    if %live% == 0 goto Muerte
    if %Hunger% LSS 0 (
        set /a vidaBajar=!random! %% 15 + 1
        set /a Live-=vidaBajar
        echo tienes hambre, tu vida a bajado %vidaBajar% ahora estas a %Live%
		echo Pulsa cualquier tecla para continuar
		pause>nul
    )
    if !vidaBicho! LSS 0 ( goto GanasteCombate )
    if !vidaBicho! == 0 ( goto GanasteCombate )

    

        set /a IABicho=!random! %% 1
        if %IABicho% == 0 (
            :: Atacar
            if !Defenderse! == 1 (
                cls
                color 02
                if "%objDefensa%"=="1" (
                    set /a numProbabilidad=10
                    set /a probabilidadDaño=!random! %% 100
                    
                    if !probabilidadDaño! leq !numProbabilidad! (
                        :: echo 1. Escudo Maximo [10%% de recibir daño] [-50 de hambre]
                        color 04
                        echo te ha hecho %dañoBicho% daño
                        set /a live=%live%-%dañoBicho%
                        timeout /t 1 >nul
                        color 07
                        echo Pulsa cualquier boton para seguir con el Combate
                        pause>nul
                        set /a Atacar=0
                    ) else (
                        echo no te hizo daño por tus defensas
                    )
                    set /a Hunger=%Hunger%-50
                )
                if "%objDefensa%"=="2" (
                    set /a numProbabilidad=50
                    set /a probabilidadDaño=!random! %% 100
                    
                    if !probabilidadDaño! leq !numProbabilidad! (
                        :: echo 2. Escudo Medio [50%% de recibir daño y reducido] [-30 de hambre]
                        color 04
                        echo te ha hecho %dañoBicho% daño
                        set /a live=%live%-%dañoBicho%/2
                        timeout /t 1 >nul
                        color 07
                        echo Pulsa cualquier boton para seguir con el Combate
                        pause>nul
                        set /a Atacar=0
                    ) else (
                        echo no te hizo daño por tus defensas
                    )
                    set /a Hunger=%Hunger%-30
                )
                if "%objDefensa%"=="3" (

                    set /a numProbabilidad=70
                    set /a probabilidadDaño=!random! %% 100
                    
                    if !probabilidadDaño! leq !numProbabilidad! (
                        :: echo 1. Escudo Maximo [10%% de recibir daño] [-50 de hambre]
                        color 04
                        echo te ha hecho %dañoBicho% daño
                        set /a live=%live%-%dañoBicho%
                        timeout /t 1 >nul
                        color 07
                        echo Pulsa cualquier boton para seguir con el Combate
                        pause>nul
                        set /a Atacar=0
                    )
                    set /a Hunger=%Hunger%-10
                )
                if "%objDefensa%"=="4" (

                    echo le has devuelto el ataque por x2
                    olor 04
                    set /a dañoBicho=%danio%*2
                    set /a live=%live%-50
                    set /a Atacar=0
                    timeout /t 1 >nul
                    color 07
                    echo Pulsa cualquier boton para seguir con el Combate
                    pause>nul
                )
                if "%objDefensa%"=="5" (
                    echo 5. Palo de madera [puede devolver cualquier ataque] [únicamente lo puedes usar 1 vez]
                    echo le has devuelto el ataque
                    olor 04
                    set /a dañoBicho=%danio%*2
                    set /a Atacar=0
                    timeout /t 1 >nul
                    color 07
                    echo Pulsa cualquier boton para seguir con el Combate
                    pause>nul
                )
                set /a Defenderse=0
                echo Te has defendido, no te ha hecho danio
                echo Pulsa cualquier boton para seguir con el Combate
                pause>nul
            ) else (
                cls
                color 04
                echo te ha hecho %dañoBicho% danio
                set /a live=%live%-%dañoBicho%
                timeout /t 1 >nul
                color 07
                echo Pulsa cualquier boton para seguir con el Combate
                pause>nul
            )
        )
        if %IABicho% == 1 (
            set /a probabilidadDaño=!random! %% 100
            
            if !probabilidadDaño! leq !numProbabilidadBich! (
                if !Atacar! == 1 (
                    cls 
                    color a
                    echo Has atacado a %NomBicho% y le has hecho %danio%
                    set /a Atacar=0
                    pause
                )
            ) else (
                color 04
                echo ha conseguido Defenderse
                timeout /t 1 >nul
                color 07
                echo Pulsa cualquier botón para seguir con el Combate
                pause>nul
            )
        ) else (
            if !Atacar! == 1 (
                cls 
                color a
                echo Has atacado a %NomBicho% y le has hecho %danio%
                set /a Atacar=0
                pause
            )
        )
    
    
    set /a CombateEmpezado=1

    cls
    if "%NomBicho%" == "Bondrewd" (
        color 50
    ) else (
        color b
    )

    echo ================ Combate ================   ================ %NomBicho% ================
    echo          Vida: %Live%    hambre: %Hunger%                          Vida: %vidaBicho%   Danio: %dañoBicho%  
    echo             Danio Extra: %incrementoDeDaño%
    echo -----------------------------------------   --------------------------------------------
    echo 1. Atacar
    echo 2. Defenderse
    echo 3. Consumir Objeto
    echo 4. Pasar
    echo 5. Escapar
    echo =========================================   =========================================


    rem Poner algun tipo de imagen de los bichos 
    choice /c 12345 /m "Selecciona una opcion:"

    if !errorlevel! == 5 (
        echo has escapado por los pelos.
        pause>nul
        set /a vidaBicho=0
        set /a dañoBicho=0
        set /a CombateEmpezado=0
        set /a PeleasHechas=%PeleasHechas%+1
        goto menu
    )
    if !errorlevel! == 4 (
        goto Combate
    )
    if !errorlevel! == 3 (
        goto Consumir
    )
    if !errorlevel! == 2 (
        set /a Defenderse=1
        
    )
    if !errorlevel! == 1 (
		cls
        set /a Atacar=1
        color c
        echo ================ Combate ================   ================ %NomBicho% ================
        echo          Vida: %Live%    hambre: %Hunger%                         Vida: %vidaBicho%   Danio: %dañoBicho%  
        echo             Danio Extra: %incrementoDeDaño%
        echo -----------------------------------------   --------------------------------------------           
            set habilidades[1]= Incinerador [100%% de danio] [-100 de hambre y -20 de vida, uso 2 veces]
            set habilidades[2]= Cuchillo [10 de danio] [-3 de hambre]
            set habilidades[3]= Hacha [20 de danio] [-20 de hambre]
            set habilidades[4]= Lanza [30 de danio] [-25 de hambre]
            set habilidades[5]= Lanzallamas portatil [70%% de danio] [-40 de vida]
            set habilidades[6]= Mazo [30%% de danio] [-30 de hambre]

            for %%i in (1 2 3) do (
                for /f "tokens=2 delims==" %%h in ('set habilidad%%i 2^>nul') do (
                    if defined habilidades[%%h] echo %%i. !habilidades[%%h]!
                )
            )
        echo =========================================   =========================================
		choice /c 123 /m "Selecciona una opcion:"
		if !errorlevel! == 3 (
			if !habilidad3! == 1 (
				if not %UsosIncinerador% == 2 (
					rem 1. Incinerador [100%% de danio] [-100 de hambre y -20 de vida, uso 2 veces]
					set /a Live=%Live%-20
					set /a Hunger=%Hunger%-100
					set /a vidaBicho=0
					set /a Danio=%vidaBicho%
					set /a vidaBicho=%vidaBicho%-%vidaBicho%
					set /a UsosIncinerador=%UsosIncinerador%+1
				) else (
					echo Ya lo has usado demasiadas veces
				)

			)
            if !habilidad3! == 2 (
					rem 2. Cuchillo [10 de danio] [-3 de hambre]
					set /a Hunger=%Hunger%-3
					set /a Danio=10
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1
                    
			)
            if !habilidad3! == 3 (
					rem 3. Hacha [20 de danio] [-20 de hambre]
					set /a Hunger=%Hunger%-20
					set /a Danio=20
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
            if !habilidad3! == 4 (
					rem Lanza [30 de danio] [-25 de hambre]
					set /a Hunger=%Hunger%-30
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
            if !habilidad3! == 5 (
					rem Lanzallamas portatil [70%% de danio] [-40 de vida]
                    set /a Live=70*%Live%/100
					set /a Hunger=%Hunger%-40
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			) 
            if !habilidad3! == 6 (
					rem Mazo [30%% de danio] [-30 de hambre]
                    set /a Live=30*%Live%/100
					set /a Hunger=%Hunger%-30
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
		)
		if !errorlevel! == 2 (
			if !habilidad2! == 1 (
				if not %UsosIncinerador% == 2 (
					rem 1. Incinerador [100%% de danio] [-100 de hambre y -20 de vida, uso 2 veces]
					set /a Live=%Live%-20
					set /a Hunger=%Hunger%-100
					set /a vidaBicho=0
					set /a Danio=%vidaBicho%
					set /a vidaBicho=%vidaBicho%-%vidaBicho%
					set /a UsosIncinerador=%UsosIncinerador%+1
				) else (
					echo Ya lo has usado demasiadas veces
				)

			)
            if !habilidad2! == 2 (
					rem 2. Cuchillo [10 de danio] [-3 de hambre]
					set /a Hunger=%Hunger%-3
					set /a Danio=10
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1
                    
			)
            if !habilidad2! == 3 (
					rem 3. Hacha [20 de danio] [-20 de hambre]
					set /a Hunger=%Hunger%-20
					set /a Danio=20
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
            if !habilidad2! == 4 (
					rem Lanza [30 de danio] [-25 de hambre]
					set /a Hunger=%Hunger%-30
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
            if !habilidad2! == 5 (
					rem Lanzallamas portatil [70%% de danio] [-40 de vida]
                    set /a Live=70*%Live%/100
					set /a Hunger=%Hunger%-40
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			) 
            if !habilidad2! == 6 (
					rem Mazo [30%% de danio] [-30 de hambre]
                    set /a Live=30*%Live%/100
					set /a Hunger=%Hunger%-30
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
		)
		if !errorlevel! == 1 (
			if !habilidad1! == 1 (
				if not %UsosIncinerador% == 2 (
					rem 1. Incinerador [100%% de danio] [-100 de hambre y -20 de vida, uso 2 veces]
					set /a Live=%Live%-20
					set /a Hunger=%Hunger%-100
					set /a vidaBicho=0
					set /a Danio=%vidaBicho%
					set /a vidaBicho=%vidaBicho%-%vidaBicho%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1
				) else (
					echo Ya lo has usado demasiadas veces
				)

			)
            if !habilidad1! == 2 (
					rem 2. Cuchillo [10 de danio] [-3 de hambre]
					set /a Hunger=%Hunger%-3
					set /a Danio=10
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1
                    
			)
            if !habilidad1! == 3 (
					rem 3. Hacha [20 de danio] [-20 de hambre]
					set /a Hunger=%Hunger%-20
					set /a Danio=20
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
            if !habilidad1! == 4 (
					rem Lanza [30 de danio] [-25 de hambre]
					set /a Hunger=%Hunger%-30
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
            if !habilidad1! == 5 (
					rem Lanzallamas portatil [70%% de danio] [-40 de vida]
                    set /a Live=70*%Live%/100
					set /a Hunger=%Hunger%-40
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			) 
            if !habilidad1! == 6 (
					rem Mazo [30%% de danio] [-30 de hambre]
                    set /a Live=30*%Live%/100
					set /a Hunger=%Hunger%-30
					set /a Danio=25
					set /a vidaBicho=%vidaBicho%-%danio%-%incrementoDeDaño%
					set /a UsosIncinerador=%UsosIncinerador%+1   
			)
            set /a Atacar=1
		)
    )
    
goto Combate

:NotaBondrewd
    color 6
    echo ====================================================================
    echo                        Nota de Bondrewd
    echo .
    echo he mandado a uno de mis secuaces a poner esta nota 
    echo unicamente esta nota es para decirte de que te menti
    echo No hay ese tal hilo no existe.
    echo si querias conseguir mucho dinero podrias haber buscado en la capa 4 
    echo alli hay un orbe magico que podrias haber vendido por: 1000000000M $

    choice /c SN /m "¿Quieres seguir?: "

    if %errorlevel% == 2 (
        goto GanasteFIN
    )
    if %errorlevel% == 1 (
        goto Menu
    )
:GanasteCombate
    cls
	color 02
    if %NomBicho% == "Bondrewd" (
        color 50
        echo Has logrado matar a Bondrewd
        echo Bondrewd: Que interesante, tienes una reliquia en la cabeza? que interesante acabo de leer tu mente.
        echo Bondrewd: Escuchas voces con un menu y todo?
        echo Bondrewd: A mi no me podras matar tan facil...
        echo Bondrewd: Te dejare pasar y así me desago de una persona más 
        set "inventario=!inventario!,Orbe"
        pause
    ) else (
        echo Has matado a !NomBicho!
        timeout /t 2 > nul
        color 07
        set "inventario=!inventario!,Carne"
    )
    set "NomBicho="
    set /a vidaBicho=0
    set /a dañoBicho=0
    set /a CombateEmpezado=0
    set /a PeleasHechas=%PeleasHechas%+1
	timeout /t 2 > nul
	color 07
	goto menu
    
:Muerte
    title MORISTE
    cls
    color 4F
    echo ================== GAME OVER ==================
    echo.
    echo Has sucumbido a la maldicion del Abismo.
    echo Tu alma ha quedado atrapada en las profundidades oscuras...
    echo.
    timeout /t 2 >nul
    echo ===========================================
    echo Se escuchan susurros lejanos. ¿Te atreveras a regresar?
    echo.
    timeout /t 2 >nul
    echo ===========================================
    echo Recuperando tus recursos... Por ultima vez...
    rem type Resources\Bondriud.txt
    echo.
    echo Espere un momento a que se calculen las estadisticas
    pause>nul

    (for /f "tokens=* delims=" %%A in (HtmlResource/PlantillaPerdiste.html) do (
        set "line=%%A"
        set "line=!line:{{nombre}}=%nombre%!"
        set "line=!line:{{Layer}}=%Layer%!"
        set "line=!line:{{Live}}=%Live%!"
        set "line=!line:{{Hunger}}=%Hunger%!"
        set "line=!line:{{inventario}}=%inventario%!"
        set "line=!line:{{ObjDefensa}}=%ObjDefensa%!"
        set "line=!line:{{PeleasHechas}}=%PeleasHechas%!"
        set "line=!line:{{NomBicho}}=%NomBicho%!"
        set "line=!line:{{Danio}}=%Danio%!"
        echo !line!
    )) > %nombre%_Muerte.html

    echo Archivo salida.html generado.
    start %nombre%_Muerte.html
    exit
    

:GanasteFIN
    (for /f "tokens=* delims=" %%A in (HtmlResource/plantilla.html) do (
        set "line=%%A"
        set "line=!line:{{nombre}}=%nombre%!"
        set "line=!line:{{Layer}}=%Layer%!"
        set "line=!line:{{Live}}=%Live%!"
        set "line=!line:{{Hunger}}=%Hunger%!"
        set "line=!line:{{inventario}}=%inventario%!"
        set "line=!line:{{ObjDefensa}}=%ObjDefensa%!"
        set "line=!line:{{Danio}}=%Danio%!"
        set "line=!line:{{PeleasHechas}}=%PeleasHechas%!"
        echo !line!
    )) > %nombre%.html

    echo Archivo salida.html generado.
    start %nombre%.html
    exit