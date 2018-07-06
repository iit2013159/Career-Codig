::Author --> Abhishek Kumar
::email --> abhishek.bh.kumat@sunlife.com
::Date Created -->5 July 2018
::Version --> 0.9
::Description --> This Programm substitutes the IBM lotus Notes ChatHistory Feautures.Prerequiste is that there must be
::SametimeTranscripts named Folder which consist the chat. This programm will create a html page from the existing directory
::and then we can acces all the chat happened.The html page will be automatically opened by default opening application.
::PLease ensure that your default application for .html file is a browser. This excludes the multiple chat history.
@echo off
SETLOCAL EnableDelayedExpansion
set nameindex=0
set "line0=^<!DOCTYPE html^>^<html class="no-js"^>^<head^>^<meta charset="utf-8"^>^<title^>CHAT History^</title^>"
set "line1=    <style>"
set "line2=        html,body {    width:100%%;    height:100%%;    position:absolute;}"
set "line3=        .Container {    display: flex;    overflow: hidden;    height: 100%%;    width: 100%%;    position: absolute;}"
set "line4=        .Left,.Middle,.Right {    overflow: auto;    height: auto;    padding: .5rem;    -webkit-overflow-scrolling: touch;    -ms-overflow-style: none;}"
set "line5=        .Left::-webkit-scrollbar,.Middle::-webkit-scrollbar{    display: none;}"
set "line6=        .Left {    width: 30%%;    background-color: #3D3837;}"
set "line7=        .Middle {    flex: 1;}"
set "line8=        #date{    width: 100%%;     height:165px;     overflow: auto;}"
set "line9=        #log{    height:10px;     overflow: auto;}"
set "line10=    </style>"
set "line11=    <script>"
set "line12=         function convertintodate(dateasnumber){"
set "line13=            dateasnumber = dateasnumber.toString();"
set "line14=            var year = '';"
set "line15=            var month='';"
set "line16=            var dateto='';"
set "line17=            for(var i = 0; i <dateasnumber.length;i++){"
set "line18=                if(i < 4){year =year.concat(dateasnumber[i]);  }"
set "line19=                else if(i>=4 && i < 6){  month =month.concat(dateasnumber[i]); }"
set "line20=                else if(i >= 6 && i < 8){ dateto =dateto.concat(dateasnumber[i]); }"
set "line21=            }return month.concat("/").concat(dateto).concat("/").concat(year);"
set "line22=        }"
set "line23=        function myFunction(idname) {"
set "line24=            document.getElementById("log").innerHTML='';document.getElementById("date").innerHTML='';var nameArray =this[idname];"
set "line25=            var finalcontent='';"
set "line26=            for (var ab = 0; ab < nameArray.length ; ab++){"
set "line27=                var date1=nameArray[ab];"
set "line28=                var content ="^<div id='"+date1+"_dates"+"' style=''^>";"
set "line29=                var datename = idname.concat("_").concat(date1);"
set "line30=                content +="^<button style='  background-color: #4CAF50;text-align: center;color: white;border: solid;' id='"+datename+"' value='"+datename+"' onclick='doother(this.id)'^>"+convertintodate(date1)+"^</button^>^<br /^>\n" ;"
set "line31=                finalcontent+=content;"
set "line32=            }"
set "line33=            document.getElementById("date").innerHTML=finalcontent;"
set "line34=            var datename1st=idname.concat("_").concat(nameArray[0]);"
set "line35=            document.getElementById("log").innerHTML="^<div id=' "+datename1st.concat("_html")+ "'^>"+this[datename1st]+"^</div^>";"
set "line36=        }"
set "line37=        function doother(datename){"
set "line38=            var outputof ="^<div id='"+datename.concat("_html") + "' style='visibility: hidden'^>";"
set "line39=            outputof += this[datename];outputof +="^</div^>";"
set "line40=            document.getElementById("log").innerHTML=outputof;"
set "line41=            showHtml(datename);"
set "line42=        }"
set "line43=        function abc(idname) {"
set "line44=            var div = document.getElementById(idname);"
set "line45=            div.style.display='block';div.style.visibility= 'visible';"
set "line46=        }"
set "line47=        function showHtml(idname) {"
set "line48=            var div = document.getElementById(idname.concat("_html"));"
set "line49=            div.style.display='block';"
set "line50=            div.style.visibility= 'visible';"
set "line51=            div.style.resize ='both';"
set "line52=            div.style.overflow ='auto';"
set "line53=        }"
set "line54=        function setdiv() {"
set "line55=            var div = document.getElementById("left");"
set "line56=            for(var i = 0; i < commName.length;i++){"
set "line57=                div.innerHTML +="^<button style=' background-color: dodgerblue;text-align: center;color: white; width:100%%;height: 30px' id='"+commName[i]+"' value='"+commName[i]+"' onclick='myFunction(this.id)'^>"+commName[i]+"^</button^>^<br /^>";"
set "line58=            }"
set "line59=        }"
set "line60=    </script>"
set "line61=</head>"
set "line62=<body " onload="setdiv()"^>^<div class="Container"^>"
set "line63=    <div class="Left" id ="left"style="height:100%%; overflow: scroll;"></div>"
set "line64=    <div class="Middle" >"
set "line65=        <div id ="date" style="height:20%%; width:100%%;border : solid;overflow: scroll;">Date</div>"
set "line66=        <div id ="log" style="height:80%%; width:100%%;border : solid;overflow: scroll;">Logs</div>"
set "line67=    </div></div>"
set "line68=</body></html>"


goto :main

::This method read files. It is designed to pick only html in the folder. It presumes that in
::a folder only one html file will exist which will have extension of html
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


::This method will handle space seprated name and convert into single non spaced id
::We have a issue that people names contained ',. in their names so to handle those internal for loop has been written
::This method has limitation it will convert upto 2 space into an id  and two special character name into a non
::hindering idname to be displayed
::In future to handle special character issue we can use encodeURI smartly in the code
:getidfromname
    set par=%~1
    for /F "tokens=1,2,* delims= " %%a in ("!par!") do (
        rem echo %%a_%%b
        if "%%c"=="" (
            set outiv=%%a_%%b
        )else (
          set outiv=%%a_%%b_%%c
        )
        set tempoutiv=
        for /F "tokens=1,2,* delims='."  %%k in ("!outiv!") do (
            if not "%%m"=="" (
               set tempoutiv=%%k_%%l_%%m
            )
            if not "%%l"=="" (
                set tempoutiv=%%k_%%l
            ) else (
                set tempoutiv=%%k
            )
        )
        set outiv=!tempoutiv!
    )
goto :eof

::This method will extract dates folder from the file and will call to read the filename method
:getdates
    set name=%~1
    set datepath=%~2
    (for /f "delims=" %%i in ('dir /b /ad "!datepath!"') do (
        set "string=%%i"
        set datelist[!itrdate!]=!string!
        SET /A itrdate=!itrdate!+1
        call :anotherreadfilesfromdate "!datepath!\!string!"
    ))
goto :eof

::This method extracts name from project folder like CN=Khujema Katleri,OU=Service then it will get name  khujema katleri.
:: After that it calls to
::Make id from this name.
:getnamefromstring
    set par=%~1
    for /F "tokens=2 delims==," %%j in ("!par!") do (
        set outifnjv=%%j
        call :getidfromname "%%j"
    )
goto :eof

::This method takes the parent folder where all the chats have been putten, Here its compulsory that you have
::named that folder with SametimeTranscripts . This bat file must be present just outside the folder.
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


::This method has one of the most important work to write to retrieve the results so that we can use it as js array.
::We have setted multiple variable in different function. We are now going to call them and write in a useful way.
::Here we have to echo in the same line so we cant use echo so now we use <nul set /p but here we can't use doublequotes
::so it have to handled useing encodeURI or escape function.
::Here we use multiple for loops and nested for loops The first forloop will write all the id's into a javascript array
::The second for loop will write dates corresponding into their respective id's array.
:printarray
    set nameofarray=%~1
    set sizeofarray=%~2
    set "arrnam=var commName=[ "
    <nul set /p ="!arrnam!"
    for /l %%n in (0,1,!sizeofarray!) do (
        set outiv=
        call :getnamefromstring "!%nameofarray%[%%n]!"
        <nul set /p = '
        <nul set /p = !outiv!
        <nul set /p = ',
    )
    SET /A sizeofarray=!sizeofarray!+1
    call :getnamefromstring "!%nameofarray%[%sizeofarray%]!"
    echo "!outiv!" ];
    ::Write id array and put date into it
    for /l %%n in (0,1,!sizeofarray!) do (
        set outiv=
        call :getnamefromstring "!%nameofarray%[%%n]!"
        set itrdate=0
        <nul set /p = var !outiv!=[
        call :getdates "!%nameofarray%[%%n]!" "!usedpath!\!%nameofarray%[%%n]!"
        SET /A itrdate=!itrdate!-1
        for /l %%p in (0,1,!itrdate!) do (
           set outputdate="!datelist[%%p]!"
           <nul set /p = !outputdate!
           <nul set /p = ,
       )
       echo ];
    )
    ::Writing the refernce of HTML file into corresponding id_date variable. This will extract the whole path from SametimeTranscripts.
    set "objectHtml='<object width="800" height="800" type="text/html" data='+encodeURI("./SametimeTranscripts/"
    for /l %%n in (0,1,!sizeofarray!) do (
       set outiv=
       call :getnamefromstring "!%nameofarray%[%%n]!"
       set itrdate=0
       set htmlfilename=
       call :getdates "!%nameofarray%[%%n]!" "!usedpath!\!%nameofarray%[%%n]!"
       SET /A itrdate=!itrdate!-1
       for /l %%p in (0,1,!itrdate!) do (
          set outputdate=!datelist[%%p]!
          echo var !outiv!_!outputdate!=!objectHtml!!%nameofarray%[%%n]!/!outputdate!/!htmlfilename!") +'></object>';
       )
    )
goto :eof

::We have to write the html code into the file till the variable have to be written. Here lineno. taking till<script> tage starts from the <HTML> tage
:callprevline
set /A lineno=11
for /l %%n in (0,1,!lineno!) do (
    echo !line%%n!
)
goto :eof

::This will be called when the variables have been written and the remaining html has to be written . This will start from </script> till </html> tag
:calllines
set /A total=68
for /l %%n in (12,1,!total!) do (
    echo !line%%n!
)
goto :eof

::This is the main driver class of the programme. This ensure the order of execution and chain of events.
:main
    call :readepeoplename
    SET /A nameindex=!nameindex!-2
    call :callprevline >chathistory.html
    call :printarray folderlist !nameindex! >>chathistory.html
    call :calllines >>chathistory.html
    start "" "chathistory.html"
rem start chrome.exe "" "newsample.html"
goto :eof