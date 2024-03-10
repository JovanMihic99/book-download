@echo off
setlocal EnableDelayedExpansion

REM Prompt the user to enter the URL
set /p "baseURL=Unesi URL knjige, bez razmaka (ctrl+V): "

REM Check if the URL is provided
if "%baseURL%"=="" (
    echo URL nije unet.
    echo Unesi URL.
    goto :end
)

set "counter=1"

:download_images
REM Format pageIndex to keep leading zeros
set "pageIndex=00000!counter!"
set "pageIndex=!pageIndex:~-5!"

REM Download the image using the current page index
set "url=!baseURL!!pageIndex!"
echo Downloading image from: !url!
powershell -command "(New-Object Net.WebClient).DownloadFile('!url!', 'stranica!counter!.jpg')"

REM Increment the counter
set /a "counter+=1"

REM Check if the next page exists (you can modify the limit as needed)
if %counter% leq 1000 (
    goto download_images
)

:end
echo All images downloaded.
pause
