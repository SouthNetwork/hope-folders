@echo off
color 0c
echo -
echo [DUMP DB BOT] Deletando cache ...
echo -
rd /s /q "./cache"
timeout 2
test&cls
color 02  

echo .
echo .
echo .

echo [DUMP DB BOT] Bot Startando...

echo .
echo .
echo .
echo .

npx nodemon