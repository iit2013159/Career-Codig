@echo off
SETLOCAL EnableDelayedExpansion
set nameindex=0
set "chathtml=<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>chat History</title><script>"
set "line1=function myFunction(idname) {"
set "line2=var nameArray =this[idname];"
set "line3=var finalcontent='';"
set "line4=for (var ab = 0; ab < nameArray.length ; ab++){"
set "line5=var date1=nameArray[ab];"
set "line6=var content ="^<div id='"+date1+"_dates"+"' style=''^>";"
set "line7=    var datename = idname.concat("_").concat(date1);"
set "line8=content +="^<button id='"+datename+"' value='"+datename+"' onclick='showHtml(this.id)'^>"+date1+"^</button^>^<br /^>\n" ;"
set "line9=content +="^<div id='"+datename.concat("_html") + "' style='visibility: hidden'^>";"
set "line10=content += this[datename];"
set "line11=content +="^</div^>";"
set "line12=    finalcontent+=content;"
set "line13=}"
set "line14=document.getElementById("left").innerHTML=finalcontent;"
set "line15=}"
set "line16=function abc(idname) {"
set "line17=var div = document.getElementById(idname);"
set "line18=div.style.display='block';"
set "line19=div.style.visibility= 'visible';"
set "line20=}"
set "line21=function showHtml(idname) {"
set "line22=alert(idname);"
set "line23=var div = document.getElementById(idname.concat("_html"));"
set "line24=div.style.display='block';"
set "line25=div.style.visibility= 'visible';"
set "line26=div.style.resize ='both';"
set "line27=div.style.overflow ='auto';"
set "line28=}"
set "line29=function setdiv() {"
set "line30=var div = document.getElementById("names");"
set "line31=for(var i = 0; i < commName.length;i++){"
set "line32=div.innerHTML +="^<button id='"+commName[i]+"' value='"+commName[i]+"' onclick='myFunction(this.id)'^>"+commName[i]+"^</button^>^<br /^>";"
set "line33=} }"
set "line34=</script></head>"
set "line35=<body style="overflow: auto" onload="setdiv() ">"
set "line36=<div id ="top">"
set "line37=<div id="names" ></div></div>"
set "line38=<div id ="left"></div>"
set "line39=<div id ="bottom"></div>"
set "line40=</body></html>"
goto :main



:anotherreadfilesfromdate
set inppar=%~1
set "location=!inppar!"
(for /f "delims=" %%i in ('dir /b "!location!"') do (
    set "htmlname=%%i"
    for /F "tokens=1,2 delims=." %%a in ("!htmlname!") do (
                  set ext=%%b
                  set html=html
                  if "!ext!"=="!html!" (
                      set htmlfilename=!htmlname!
                    )
               )
))
goto :eof

:readfilefromdates
set inppar=%~1
set "location=!inppar!"
SET N=0
(for /R "%location%" %%i in (*) do (
     SET DIR=%%i
	set url=!DIR!
     ::put anything here, for instance the following code add dir numbers.
	 echo !url!
))
goto :eof

:getidfromname
set par=%~1
rem echo !par!
for /F "tokens=1,2 delims= " %%a in ("!par!") do (
              rem echo %%a_%%b
              set outiv=%%a_%%b
           )
goto :eof

:getdates
set name=%~1
set datepath=%~2
(for /f "delims=" %%i in ('dir /b /ad "!datepath!"') do (
    set "string=%%i"
    rem <nul set /p = !string!,
    set datelist[!itrdate!]=!string!
        SET /A itrdate=!itrdate!+1
    rem call :readfilefromdates "!datepath!\!string!"
    call :anotherreadfilesfromdate "!datepath!\!string!"
))
goto :eof

:getnamefromstring
set par=%~1
rem echo !par!
rem call :getdates "!par!" "!stringpath!"
for /F "tokens=2 delims==," %%j in ("!par!") do (
        rem set outiv=%%j
        rem echo !out!
       call :getidfromname "%%j"
    )

rem echo !out!
goto :eof

:readepeoplename

set nq=0
set usedpath=.\SametimeTranscripts\
(for /f "delims=" %%i in ('dir /b /ad "!usedpath!"') do (
    set "string=%%i"
    set folderlist[!nameindex!]=!string!
    SET /A nameindex=!nameindex!+1
    call :getnamefromstring "!string!"
    call :getdates "!string!" "!usedpath!\!string!"
))
goto :eof

:printarray
set nameofarray=%~1
rem echo !nameofarray!
set sizeofarray=%~2
set "arrnam=var commName=[ "
<nul set /p ="!arrnam!"
for /l %%n in (0,1,!sizeofarray!) do (
    set outiv=
    call :getnamefromstring "!%nameofarray%[%%n]!"
   rem <nul set /p = %call :getnamefromstring !%nameofarray%[%%n]!%
   <nul set /p = '
   <nul set /p = !outiv!
   <nul set /p = ',
)
SET /A sizeofarray=!sizeofarray!+1
call :getnamefromstring "!%nameofarray%[%sizeofarray%]!"
rem echo !%nameofarray%[%sizeofarray%]! ]
echo "!outiv!" ];

for /l %%n in (0,1,!sizeofarray!) do (
    set outiv=
    call :getnamefromstring "!%nameofarray%[%%n]!"
   rem <nul set /p = %call :getnamefromstring !%nameofarray%[%%n]!%
   set itrdate=0
   <nul set /p = var !outiv!=[
   call :getdates "!%nameofarray%[%%n]!" "!usedpath!\!%nameofarray%[%%n]!"
   SET /A itrdate=!itrdate!-1
   for /l %%p in (0,1,!itrdate!) do (
       set outputdate="!datelist[%%p]!"
      rem <nul set /p = %call :getnamefromstring !%nameofarray%[%%n]!%
      <nul set /p = !outputdate!
      <nul set /p = ,
   )
   echo ];
)
set "objectHtml='<object width="800" height="800" type="text/html" data="./SametimeTranscripts/"

for /l %%n in (0,1,!sizeofarray!) do (
    set outiv=
    call :getnamefromstring "!%nameofarray%[%%n]!"
   rem <nul set /p = %call :getnamefromstring !%nameofarray%[%%n]!%
   set itrdate=0
   rem <nul set /p = !outiv!=[
   set htmlfilename=
   call :getdates "!%nameofarray%[%%n]!" "!usedpath!\!%nameofarray%[%%n]!"
   SET /A itrdate=!itrdate!-1
   for /l %%p in (0,1,!itrdate!) do (
       set outputdate=!datelist[%%p]!
      rem <nul set /p = %call :getnamefromstring !%nameofarray%[%%n]!%
      rem <nul set /p = !outputdate!

      rem <nul set /p = !outiv!_!outputdate!=!objectHtml!
      echo var !outiv!_!outputdate!=!objectHtml!!%nameofarray%[%%n]!/!outputdate!/!htmlfilename!" ></object>';

   )

)


goto :eof

:calllines
set /A total=40
echo !total!
for /l %%n in (1,1,!total!) do (
    echo !line%%n!
)

goto :eof

:main
call :readepeoplename
SET /A nameindex=!nameindex!-2
echo !chathtml! >chathistory.html
call :printarray folderlist !nameindex! >>chathistory.html
call :calllines >>chathistory.html
start "" "chathistory.html"
rem start chrome.exe "" "newsample.html"
goto :eof