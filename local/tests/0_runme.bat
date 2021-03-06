@echo off

set wget=bin\wget.exe
if exist %wget% goto :WGET_OK
echo *** %wget% is required!
goto :END
:WGET_OK

rem Set your test site (local) info:
set site=http://www.ff.com:8000
set mobile=http://m.ff.com:8000
set ext=aspx
set index_page=index.%ext%
set action_page=action.%ext%

rem Set security code exactly the same as in Config!
set code=1234

set input=input
set output=output
set origin=origin

if not exist %output% mkdir %output%
if not exist %origin% mkdir %origin%

set log=%output%\log.txt
echo > %log%

rem Just for debugging -- remove on production!!!
rem goto :STYLES

:CREATE
echo *** Starting 1_create.bat >> %log%
call 1_create.bat

:FETCH
echo *** Starting 2_fetch.bat >> %log%
call 2_fetch.bat

:STYLES
echo *** Starting 3_styles.bat >> %log%
call 3_styles.bat

:PAGES
echo *** Starting 4_pages.bat >> %log%
call 4_pages.bat

:ACTIONS
echo *** Starting 5_actions.bat >> %log%
call 5_actions.bat

:VIEW
echo *** Starting 6_view.bat >> %log%
call 6_view.bat

:RSS
echo *** Starting 7_rss.bat >> %log%
call 7_rss.bat

:METHODS
echo *** Starting 8_methods.bat >> %log%
call 8_methods.bat

:MOBILE
if "%mobile%"=="" goto :FINAL
set site=%mobile%
set output=output\mobile
set origin=origin\mobile
if not exist %output% mkdir %output%
if not exist %origin% mkdir %origin%

echo *** Starting 4_pages.bat for mobile >> %log%
call 4_pages.bat

echo *** Starting 6_view.bat for mobile >> %log%
call 6_view.bat

rem Set folders back...
set output=output
set origin=origin

:FINAL
rem ... and finally check the whole log
call 99_compare.bat log.txt

:END

rem Clean variables
set log=
set origin=
set output=
set input=
set wget=
set code=
set mobile=
set site=

:EOF
pause
