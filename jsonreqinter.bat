mongoimport --uri "mongodb+srv://<user>:<password>@cluster0.gqjxv.mongodb.net/test?retryWrites=true&w=majority" --collection tenders --type json --mode merge --file reqinter.json --upsertFields licitacion

echo off
set X=
for /f "skip=1 delims=" %%x in ('wmic os get localdatetime') do if not defined X set X=%%x
rem echo.%X%
set DATE.YEAR=%X:~0,4%
set DATE.MONTH=%X:~4,2%
set DATE.DAY=%X:~6,2%
set DATE.HOUR=%X:~8,2%
set DATE.MINUTE=%X:~10,2%
set DATE.SECOND=%X:~12,2%
rem echo %DATE.YEAR%-%DATE.MONTH%-%DATE.DAY% %DATE.HOUR%:%DATE.MINUTE%:%DATE.SECOND%
echo on

copy reqinter.json .\JSONBACK\reqinter_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%DATE.HOUR%%DATE.MINUTE%%DATE.SECOND%.json
