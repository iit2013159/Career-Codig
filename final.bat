@echo off
SETLOCAL EnableDelayedExpansion
set nameindex=0
set "chathtml=<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>chat History</title><script>"
set "line1=function myFunction(idname) {"
set "line2=document.getElementById("bottom").innerHTML='';document.getElementById("left").innerHTML='';var nameArray =this[idname];"
set "line3=var finalcontent='';"
set "line4=for (var ab = 0; ab < nameArray.length ; ab++){"
set "line5=var date1=nameArray[ab];"
set "line6=var content ="^<div id='"+date1+"_dates"+"' style=''^>";"
set "line7=    var datename = idname.concat("_").concat(date1);"
set "line8=content +="^<button id='"+datename+"' value='"+datename+"' onclick='doother(this.id)'^>"+date1+"^</button^>^<br /^>\n" ;"
set "line9=    finalcontent+=content;"
set "line10=}"
set "line11=document.getElementById("left").innerHTML=finalcontent;"
set "line12=}"
set "line13=function doother(datename){"
set "line14=var outputof ="^<div id='"+datename.concat("_html") + "' style='visibility: hidden'^>";"
set "line15=outputof += this[datename];"
set "line16=outputof +="^</div^>";"
set "line17=document.getElementById("bottom").innerHTML=outputof;"
set "line18=showHtml(datename);"
set "line19=}"
set "line20=function abc(idname) {"
set "line21=var div = document.getElementById(idname);"
set "line22=div.style.display='block';"
set "line23=div.style.visibility= 'visible';"
set "line24=}"
set "line25=function showHtml(idname) {"
set "line26=//alert(idname);"
set "line27=var div = document.getElementById(idname.concat("_html"));"
set "line28=div.style.display='block';"
set "line29=div.style.visibility= 'visible';"
set "line30=div.style.resize ='both';"
set "line31=div.style.overflow ='auto';"
set "line32=}"
set "line33=function setdiv() {"
set "line34=var div = document.getElementById("names");"
set "line35=for(var i = 0; i < commName.length;i++){"
set "line36=div.innerHTML +="^<button id='"+commName[i]+"' value='"+commName[i]+"' onclick='myFunction(this.id)'^>"+commName[i]+"^</button^>^<br /^>";"
set "line37=} }"
set "line38=</script></head>"
set "line39=<body style="overflow: auto" onload="setdiv() ">"
set "line40=<div id ="top">"
set "line41=<div id="names" ></div></div>"
set "line42=<div id ="left"></div>"
set "line43=<div id ="bottom"></div>"
set "line44=</body></html>"

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
set /A total=44
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