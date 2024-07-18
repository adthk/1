@echo off
setlocal
set "u=http://49.248.172.162:8555"
set "c=PHPSESSID=2k5cffctfrg1cjvq750rn32c5u"
curl -s -X POST "%u%/index.php" -H "Content-Type: application/x-www-form-urlencoded" -H "Cookie: %c%" --data "emp_id=5908&pass=5908&submit=+Login+&empno=" > nul
curl -s "%u%/view_timesheet.php" -H "Cookie: %c%" -o rs.html
for /f "tokens=2 delims=<td>" %%a in ('findstr /r "<td>[0-9]*</td>" rs.html') do (
    for /f "tokens=1 delims=</td>" %%b in ("%%a") do set "i=%%b" & goto found
)
:found
if "%i%"=="" (
    echo Timesheet Already Closed...!
    exit /b 1
)
curl -s -X POST "%u%/update_timesheet1.php" -H "Content-Type: application/x-www-form-urlencoded" -H "Cookie: %c%" --data "id=%i%&workdone=Detailing&selfcheck=1&submit=Submit" > nul
endlocal
