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
set "line0=^<^!DOCTYPE html^>^<html class="no-js"^>^<head^>^<meta charset="utf-8"^>^<meta http-equiv="x-ua-compatible" content="ie=edge">^<title^>Chat History^</title^>"
set "line1=      <style>"
set "line2=          .body {margin: 0px;width: 100vw;height: 100vh;font-family: Arial;overflow-y: scroll;}"
set "line3=          .titleBox {height: 4%%;background-color: #350884;border-bottom: 3px solid #3973ac;color: white;width: 100%%;}"
set "line4=          .app-title {position: relative;height: 3%%;width: 10%%;font-size: 12px;padding: 3px 1px 3px 20px;}.content {height: 100%%;width: 100%%;position: relative;}"
set "line5=          .contactDiv {position: relative;float: left;background-color: #3B3A3A;border-bottom: 1px solid #3973ac;height: 100%%;width: 25%%;overflow-y:scroll;}"
set "line6=          .allChats {padding-top: 10px;padding-bottom: 10px;font-style: normal;padding-left: 20px;font-family: Arial;font-style: italic;color: white;font-size: 14px;background-color: #3B3A3A;margin:0px;}"
set "line7=          .contactName {padding-left: 30px;padding-bottom: 3px;padding-top: 2px;font-family: Arial;font-style: italic;color: white;font-size: 12px;}"
set "line8=          .contactName a {padding: 6px 8px 6px 16px;text-decoration: none;font-size: 12px;color: white;display: block;}"
set "line9=          .contactDiv p {margin: 0px;}.rulerSetting {margin: 0px;border-style: inherit;color: #5b5858;}"
set "line10=         .dateDiv {position: relative;float: left;font-size: 12px; /* Increased text to enable scrolling */width: 75%%;height: 22%%;background-color: #F0F0F0;border-bottom: 1px solid grey;overflow-y: scroll;}"
set "line11=         .date-title {position:relative;width: 10%%;height: auto;font-style: italic;padding-left: 10px;}"
set "line12=         .date{position:relative;padding-left: 10px;}"
set "line13=         .profileDiv {position: relative;float: left;font-size: 14px; /* Increased text to enable scrolling */width: 75%%;height: 8%%;background-color: #f4f4f4;border-bottom: 1px solid grey;}"
set "line14=         .profile-image{position:relative;height: 8%%;}.profileName {position: relative;color: #3973ac;font-weight: bolder;padding-left: 80px;}"
set "line15=         .chat {position: relative;float: left;overflow-y:scroll;height: 70%%;width: 75%%;}"
set "line16=     </style>"
set "line17=     <script>"
set "line18=         function convertintodate(dateasnumber){"
set "line19=             dateasnumber = dateasnumber.toString();"
set "line20=             var year = '';"
set "line21=             var month='';"
set "line22=             var dateto='';"
set "line23=             for(var i = 0; i <dateasnumber.length;i++){"
set "line24=                 if(i < 4){year =year.concat(dateasnumber[i]);  }"
set "line25=                 else if(i>=4 && i < 6){  month =month.concat(dateasnumber[i]); }"
set "line26=                 else if(i >= 6 && i < 8){ dateto =dateto.concat(dateasnumber[i]); }"
set "line27=             }var time ='';if(dateasnumber.length > 8){time = time.concat(dateasnumber.slice(9,11)).concat(":").concat(dateasnumber.slice(11,13)).concat(":").concat(dateasnumber.slice(13,15)); }"
set "line28=            if(time.length> 4){return month.concat("/").concat(dateto).concat("/").concat(year).concat(" ").concat(time).concat(" ").concat(convertidtoname(dateasnumber.slice(15,dateasnumber.length)));}return month.concat("/").concat(dateto).concat("/").concat(year);"
set "line29=         }        function updateNameforMulti(idname) { if (^!idname.includes("GroupChat")) {return;} var dateasnumber = idname.slice(10, idname.length);document.getElementById("profileName").innerHTML = convertidtoname(dateasnumber.slice(15, dateasnumber.length)); }"
set "line30=         function myFunction(idname) {"
set "line31=             document.getElementById("log").innerHTML='';"
set "line32=             document.getElementById("date").innerHTML='';"
set "line33=             document.getElementById("profileName").innerHTML=convertidtoname(idname);"
set "line34=             var nameArray =this[idname];"
set "line35=             var finalcontent='';"
set "line36=             for (var ab = 0; ab < nameArray.length ; ab++){"
set "line37=                 var date1=nameArray[ab];"
set "line38=                 var content ="^<div id='"+date1+"_dates"+"' style=''^>";"
set "line39=                 var datename = idname.concat("_").concat(date1);"
set "line40=                 content +="^<p  style='border-bottom: 1px dotted grey' id='"+datename+"'^>^<button style='background:none^^!important;color:inherit;border:none; padding:0^^!important; font: inherit; cursor: pointer; text-decoration:none; font-size:12px; width: 100%%; text-align:  -webkit-left;' id='"+datename+"' value='"+datename+"' onclick='style2(this.id),  doother(this.id),updateNameforMulti(this.id)'^>"+convertintodate(date1)+"^</button^>^</p^>\n" ;"
set "line41=                 finalcontent+=content;"
set "line42=             }"
set "line43=             document.getElementById("date").innerHTML=finalcontent;"
set "line44=             document.getElementById("date").innerHTML=finalcontent;"
set "line45=             var datename1st=idname.concat("_").concat(nameArray[0]);updateNameforMulti(datename1st);"
set "line46=             document.getElementById("log").innerHTML="^<div id=' "+datename1st.concat("_html")+ "'^>"+this[datename1st]+"^</div^>";"
set "line47=         }"
set "line48=         function doother(datename){"
set "line49=             var outputof ="^<div id='"+datename.concat("_html") + "' style='visibility: hidden'^>";"
set "line50=             outputof += this[datename];"
set "line51=             outputof +="^</div^>";"
set "line52=             document.getElementById("log").innerHTML=outputof;"
set "line53=             showHtml(datename);"
set "line54=         }"
set "line55=         function showHtml(idname) {"
set "line56=             var div = document.getElementById(idname.concat("_html"));"
set "line57=             div.style.display='block';"
set "line58=             div.style.visibility= 'visible';"
set "line59=             div.style.resize ='both';"
set "line60=             div.style.overflow ='auto';"
set "line61=         }"
set "line62=         function style1(idname){"
set "line63=             var color = document.getElementById(idname).style.backgroundColor = "#3973ac";"
set "line64=             for(var i = 0; i < commName.length;i++){"
set "line65=                 if (commName[i] ^!= idname)"
set "line66=                     document.getElementById(commName[i]).style.backgroundColor = "#3B3A3A";"
set "line67=             }"
set "line68=         }"
set "line69=         function style2(idname){"
set "line70=             var res = idname.toString().split("_");"
set "line71=             var out=res[0];"
set "line72=             for(var it= 1; it < res.length-1; it++){"
set "line73=                 if(out == "GroupChat"){break;}out +="_";"
set "line74=                 out += res[it];"
set "line75=             }"
set "line76=             var nameArray =this[out];"
set "line77=             var color = document.getElementById(idname).style.backgroundColor = "#3973ac";"
set "line78=             for (var ab = 0; ab < nameArray.length ; ab++){                if (out === "GroupChat" ){if("GroupChat_".concat(nameArray[ab]) ^!== idname) {document.getElementById("GroupChat_".concat(nameArray[ab])).style.backgroundColor = "#F0F0F0"; }}"
set "line79=                 else if (nameArray[ab] ^!= res[res.length-1]) {"
set "line80=                     document.getElementById(out.toString().concat("_").concat(nameArray[ab])).style.backgroundColor = "#F0F0F0";"
set "line81=                 }"
set "line82=             }"
set "line83=         }"
set "line84=         function setdiv() {"
set "line85=             var div = document.getElementById("contactDiv");commName.splice(commName.indexOf("GroupChat"),1); commName.unshift("GroupChat");"
set "line86=             for(var i = 0; i < commName.length;i++){"
set "line87=                 div.innerHTML += "^<p class='contactName'   id='"+commName[i]+"' value='"+commName[i]+"' onclick='style1(this.id), myFunction(this.id)'^>"+convertidtoname(commName[i])+"^<hr class='rulerSetting'/^>^</p^>";"
set "line88=                 this[commName[i]].sort(function(a, b){return b-a});"
set "line89=             }"
set "line90=         }"
set "line91=         function convertidtoname(idname){"
set "line92=             idname = idname.toString();"
set "line93=             var name='';"
set "line94=             for(var i = 0; i < idname.length;i++){"
set "line95=                 if(idname[i]=="_"){"
set "line96=                     name = name.concat(" ");"
set "line97=                 }else{"
set "line98=                     name = name.concat(idname[i]);"
set "line99=                 }"
set "line100=            }"
set "line101=            return name;"
set "line102=        }"
set "line103=    </script>"
set "line104=</head>"
set "line105=<body onload="setdiv()" class="body"><div class="titleBox"><div class="app-title"><span>Chat History</span></div></div><div class="content">"
set "line106=<div class="contactDiv" id="contactDiv"><p class="allChats">All Chats<br/><div class="contactName"></div></div>"
set "line107=<div class="dateDiv"><div class="date-title"><span>Date</span></div><div id="date" class="date"></div></div>"
set "line108=<div class="profileDiv"><div class="profile-image"><img src="https://www.kfk.ch/wp-content/uploads/team-platzhalter.jpg" width="80px" height="55px" /></div><span class="profileName" id="profileName"></span>"
set "line109=</div><div id ="log" class="chat"></div></div>"
set "line110=</body></html>"


goto :main

::This method read files. It is designed to pick only html in the folder. It presumes that in
::a folder only one html file will exist which will have extension of html
::It also presumes that in sameperson name folder every html will have the same filename
:anotherreadfilesfromdate
    set inppar=%~1
    set "location=!inppar!"
    (for /f "delims=" %%i in ('dir /b "!location!"') do (
        set "htmlname=%%i"
        rem echo !htmlname!
        for /F "tokens=1,2 delims=." %%a in ("!htmlname!") do (
             set ext=%%b
             set html=html
             if "!ext!"=="!html!" (
                   set htmlfilename=!htmlname!
             )
         )
         rem echo !htmlfilename!
     ))
goto :eof


::This method will handle space seprated name and convert into single non spaced id
::We have a issue that people names contained ',. in their names so to handle those internal for loop has been written
::This method has limitation it will convert upto 2 space into an id  and two special character name into a non
::hindering idname to be displayed
::In future to handle special character issue we can use encodeURI smartly in the code

:getidfromname
    set par=%~1
   rem  echo !par!
    for /F "tokens=1-17,* delims=.'{}[]`~-/\*| " %%a in ("!par!") do (
        if not "%%q"=="" (
           set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m_%%n_%%o_%%p_%%q
        )  else (
            if not "%%p"=="" (
                set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m_%%n_%%o_%%p
            ) else (
                if not "%%o"=="" (
                   set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m_%%n_%%o
                ) else (
                    if not "%%n"=="" (
                        set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m_%%n
                    ) else (
                        if not "%%m"=="" (
                           set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m
                        ) else (
                            if not "%%l"=="" (
                                set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l
                            ) else (
                                if not "%%k"=="" (
                                   set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k
                                ) else (
                                    if not "%%j"=="" (
                                        set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j
                                    ) else (
                                        if not "%%i"=="" (
                                           set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i
                                        ) else (
                                            if not "%%h"=="" (
                                                set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h
                                            ) else (
                                                if not "%%g"=="" (
                                                   set outiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g
                                                ) else (
                                                    if not "%%f"=="" (
                                                        set outiv=%%a_%%b_%%c_%%d_%%e_%%f
                                                    ) else (
                                                        if not "%%e"=="" (
                                                           set outiv=%%a_%%b_%%c_%%d_%%e
                                                        ) else (
                                                            if not "%%d"=="" (
                                                                set outiv=%%a_%%b_%%c_%%d
                                                            ) else (
                                                                if not "%%c"=="" (
                                                                   set outiv=%%a_%%b_%%c
                                                                ) else (
                                                                    if not "%%b"=="" (
                                                                        set outiv=%%a_%%b
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
    rem echo !outiv!
goto :eof

:getanotheridfromname
    set par=%~1
    set oprf=
    for  %%a in ("!par!") do (
        rem echo %%a_%%b
        if "%%a"==" " (
            set oprf=!oprf!_
         ) else (
            set oprf=!oprf!%%a
         )
    )
    echo !oprf!
    set outiv=!oprf!
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
        rem call :getanotheridfromname "%%j"
    )
goto :eof

:convertNameMultiToId <resultVar> <stringVar>
(
    setlocal EnableDelayedExpansion
    set "s=!%~2!"
    rem echo !s!
    set "len=0"
    set "val=/"
    for /F "tokens=1-17,* delims=.'{}[]`~-/\*| " %%a in ("!s!") do (
            if not "%%q"=="" (
               set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m_%%n_%%o_%%p_%%q
            )  else (
                if not "%%p"=="" (
                    set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m_%%n_%%o_%%p
                ) else (
                    if not "%%o"=="" (
                       set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m_%%n_%%o
                    ) else (
                        if not "%%n"=="" (
                            set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m_%%n
                        ) else (
                            if not "%%m"=="" (
                               set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l_%%m
                            ) else (
                                if not "%%l"=="" (
                                    set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k_%%l
                                ) else (
                                    if not "%%k"=="" (
                                       set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j_%%k
                                    ) else (
                                        if not "%%j"=="" (
                                            set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i_%%j
                                        ) else (
                                            if not "%%i"=="" (
                                               set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h_%%i
                                            ) else (
                                                if not "%%h"=="" (
                                                    set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g_%%h
                                                ) else (
                                                    if not "%%g"=="" (
                                                       set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f_%%g
                                                    ) else (
                                                        if not "%%f"=="" (
                                                            set convertOutiv=%%a_%%b_%%c_%%d_%%e_%%f
                                                        ) else (
                                                            if not "%%e"=="" (
                                                               set convertOutiv=%%a_%%b_%%c_%%d_%%e
                                                            ) else (
                                                                if not "%%d"=="" (
                                                                    set convertOutiv=%%a_%%b_%%c_%%d
                                                                ) else (
                                                                    if not "%%c"=="" (
                                                                       set convertOutiv=%%a_%%b_%%c
                                                                    ) else (
                                                                        if not "%%b"=="" (
                                                                            set convertOutiv=%%a_%%b
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
        rem echo !convertOutiv!
)
(
    endlocal
    set "%~1=%convertOutiv%"
)
goto :eof

::This method takes the parent folder where all the chats have been putten, Here its compulsory that you have
::named that folder with SametimeTranscripts . This bat file must be present just outside the folder.
:readepeoplename
    set nq=0
    set usedpath=%CD%\SametimeTranscripts\
    echo reading from folder  !usedpath! starting
    (for /f "delims=" %%i in ('dir /b /ad "!usedpath!"') do (
        set "string=%%i"
        ::This is used since we are not showing the multi chat history
        if "!string!" NEQ "[multi-way]" (
            set folderlist[!nameindex!]=!string!
                    SET /A nameindex=!nameindex!+1
                    call :getnamefromstring "!string!"
                    call :getdates "!string!" "!usedpath!\!string!"
        ) else (
            if "!string!" EQU "[multi-way]" (
                set folderlist[!nameindex!]=!string!
                SET /A nameindex=!nameindex!+1
                call :getMultiChat "!string!" "!usedpath!\!string!"
            ) else (
            echo !string! this needs to be skipped
            )
        )
    ))
    echo reading from folder  !usedpath! Completed
goto :eof

::This method will extract dates folder from the file and will call to read the filename method
:getMultiChat
    set name=%~1
    set multipath=%~2
    (for /f "delims=" %%i in ('dir /b /ad "!multipath!"') do (
        set "string=%%i"
        call :readNamefromMultiChat convertedname string
        call :readDatefromMultiChat date string
        rem echo !convertedname!
        call :convertNameMultiToId id convertedname
        rem echo !id!
        set multilist[!itrMulti!]=!string!
        SET /A itrMulti=!itrMulti!+1
        call :readMultiFile "!multipath!\!string!"
    ))
goto :eof

:readDatefromMultiChat <outputVar> <inputVat>
(
    setlocal EnableDelayedExpansion
    set "par=!%~2!"
    rem echo !s!
    set "len=0"
    set "val=/"
    for /F "tokens=1 delims=={}" %%j in ("!par!") do (
            set dateTime=%%j
    )
)
(
    endlocal
    rem echo !outifnjv!
    set "%~1=%dateTime%"
)
goto :eof

:readNamefromMultiChat <outputVar> <inputVat>
(
    setlocal EnableDelayedExpansion
    set "par=!%~2!"
    rem echo !s!
    set "len=0"
    set "val=/"
    for /F "tokens=2 delims=={}" %%j in ("!par!") do (
            set outifnjv=%%j
             rem call :getidfromname "%%j"
            rem call :getanotheridfromname "%%j"
        )
)
(
    endlocal
    rem echo !outifnjv!
    set "%~1=%outifnjv%"
)
goto :eof

::This method read files. It is designed to pick only html in the folder. It presumes that in
::a folder only one html file will exist which will have extension of html
::It also presumes that in sameperson name folder every html will have the same filename
:readMultiFile
    set inppar=%~1
    set "location=!inppar!"
    (for /f "delims=" %%i in ('dir /b "!location!"') do (
        set "htmlname=%%i"
        rem echo !htmlname!
        for /F "tokens=1,2 delims=." %%a in ("!htmlname!") do (
             set ext=%%b
             set html=html
             if "!ext!"=="!html!" (
                   set htmlfilename=!htmlname!
             )
         )
         rem echo !htmlfilename!
     ))
goto :eof

:convert <resultVar> <stringVar>
(
    setlocal EnableDelayedExpansion
    set "s=!%~2!"
    rem echo !s!
    set "len=0"
    set "val=/"
    for /F "tokens=1-17,* delims=\" %%a in ("!s!") do (
            if not "%%q"=="" (
               set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i!val!%%j!val!%%k!val!%%l!val!%%m!val!%%n!val!%%o!val!%%p!val!%%q
            )  else (
                if not "%%p"=="" (
                    set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i!val!%%j!val!%%k!val!%%l!val!%%m!val!%%n!val!%%o!val!%%p
                ) else (
                    if not "%%o"=="" (
                       set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i!val!%%j!val!%%k!val!%%l!val!%%m!val!%%n!val!%%o
                    ) else (
                        if not "%%n"=="" (
                            set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i!val!%%j!val!%%k!val!%%l!val!%%m!val!%%n
                        ) else (
                            if not "%%m"=="" (
                               set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i!val!%%j!val!%%k!val!%%l!val!%%m
                            ) else (
                                if not "%%l"=="" (
                                    set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i!val!%%j!val!%%k!val!%%l
                                ) else (
                                    if not "%%k"=="" (
                                       set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i!val!%%j!val!%%k
                                    ) else (
                                        if not "%%j"=="" (
                                            set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i!val!%%j
                                        ) else (
                                            if not "%%i"=="" (
                                               set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h!val!%%i
                                            ) else (
                                                if not "%%h"=="" (
                                                    set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g!val!%%h
                                                ) else (
                                                    if not "%%g"=="" (
                                                       set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f!val!%%g
                                                    ) else (
                                                        if not "%%f"=="" (
                                                            set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e!val!%%f
                                                        ) else (
                                                            if not "%%e"=="" (
                                                               set convertOutiv=%%a!val!%%b!val!%%c!val!%%d!val!%%e
                                                            ) else (
                                                                if not "%%d"=="" (
                                                                    set convertOutiv=%%a!val!%%b!val!%%c!val!%%d
                                                                ) else (
                                                                    if not "%%c"=="" (
                                                                       set convertOutiv=%%a!val!%%b!val!%%c
                                                                    ) else (
                                                                        if not "%%b"=="" (
                                                                            set convertOutiv=%%a!val!%%b
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
        rem echo !convertOutiv!
)
(
    endlocal
    set "%~1=%convertOutiv%"
)
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
        if "!%nameofarray%[%%n]!" EQU "[multi-way]" (
            <nul set /p = '
            <nul set /p = GroupChat
            <nul set /p = ',
        ) else (
            call :getnamefromstring "!%nameofarray%[%%n]!"
            <nul set /p = '
            <nul set /p = !outiv!
            <nul set /p = ',
        )
    )
    SET /A sizeofarray=!sizeofarray!+1
    if "!%nameofarray%[%sizeofarray%]!" EQU "[multi-way]" (
        echo "GroupChat" ];
    ) else (
        call :getnamefromstring "!%nameofarray%[%sizeofarray%]!"
        echo "!outiv!" ];
    )
    ::Write id array and put date into it
    for /l %%n in (0,1,!sizeofarray!) do (
        if "!%nameofarray%[%%n]!" EQU "[multi-way]" (
            set itrMulti=0
            <nul set /p = var GroupChat=[
            call :getMultiChat "!%nameofarray%[%%n]!" "!usedpath!\!%nameofarray%[%%n]!"
            SET /A itrMulti=!itrMulti!-1
            for /l %%p in (0,1,!itrMulti!) do (
               set groupChatName="!multilist[%%p]!"
               rem echo !groupChatName!
               call :readNamefromMultiChat convertedname groupChatName
               call :readDatefromMultiChat date groupChatName
               call :convertNameMultiToId dateid date
               call :convertNameMultiToId id convertedname
               <nul set /p = '
               <nul set /p = !dateid!_!id!
               <nul set /p = ',
            )

        ) else (
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
       )
       echo ];
    )
    ::Writing the refernce of HTML file into corresponding id_date variable. This will extract the whole path from SametimeTranscripts.
    call :convert convertedPath usedpath
    set "objectHtml='<object width="1135" height="600" type="text/html" data='+encodeURI("%convertedPath%"
    for /l %%n in (0,1,!sizeofarray!) do (
       if "!%nameofarray%[%%n]!" EQU "[multi-way]" (
           set itrMulti=0
           set htmlfilename=
           call :getMultiChat "!%nameofarray%[%%n]!" "!usedpath!\!%nameofarray%[%%n]!"
           SET /A itrMulti=!itrMulti!-1
           for /l %%p in (0,1,!itrMulti!) do (
              set groupChatName=!multilist[%%p]!
              call :readNamefromMultiChat convertedname groupChatName
              call :readDatefromMultiChat date groupChatName
              call :convertNameMultiToId idDate date
              call :convertNameMultiToId idName convertedname
              set idName=!idDate!_!idName!
              echo var GroupChat_!idName!=!objectHtml!/!%nameofarray%[%%n]!/!groupChatName!/[multi-way]log.html") +'></object>';
           )
       ) else (
           set outiv=
           call :getnamefromstring "!%nameofarray%[%%n]!"
           set itrdate=0
           set htmlfilename=
           call :getdates "!%nameofarray%[%%n]!" "!usedpath!\!%nameofarray%[%%n]!"
           SET /A itrdate=!itrdate!-1
           for /l %%p in (0,1,!itrdate!) do (
              set outputdate=!datelist[%%p]!
              echo var !outiv!_!outputdate!=!objectHtml!/!%nameofarray%[%%n]!/!outputdate!/!htmlfilename!") +'></object>';
           )
       )
    )
goto :eof

::We have to write the html code into the file till the variable have to be written. Here lineno. taking till<script> tage starts from the <HTML> tage
:callprevline
set /A lineno=17
for /l %%n in (0,1,!lineno!) do (
    echo !line%%n!
)
goto :eof

::This will be called when the variables have been written and the remaining html has to be written . This will start from </script> till </html> tag
:calllines
set /A total=110
for /l %%n in (18,1,!total!) do (
    echo !line%%n!
)
goto :eof

::This is the main driver class of the programme. This ensure the order of execution and chain of events.
:main
    echo Program Started . Starting People name reading
    call :readepeoplename
    SET /A nameindex=!nameindex!-2
    echo Starting to write %USERPROFILE%\Desktop\chathistory.html file
     call :callprevline >%USERPROFILE%\Desktop\chathistory.html
     echo Styles written successfully
     echo Starting to write variable of name as per per folder
     call :printarray folderlist !nameindex! >>%USERPROFILE%\Desktop\chathistory.html
     echo Folder names and dates writting completed
     echo Writting the javascript function
     call :calllines >>%USERPROFILE%\Desktop\chathistory.html
     echo Javascript function and body has been written
     echo Starting the HTML in the default application
     start "" "%USERPROFILE%\Desktop\chathistory.html"
     echo Html application opened in the default application
     echo Program Completed
     pause
rem start chrome.exe "" "newsample.html"
goto :eof
