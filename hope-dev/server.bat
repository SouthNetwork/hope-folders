echo Excluindo a pasta de cache...
rmdir /s /q "C:\Users\Klaus\Documents\GitHub\hope-folders\hope-dev\cache"
echo Pasta de cache excluída com sucesso!
artifacts\FXServer.exe +set onesync on +set onesync_population true +exec server.cfg