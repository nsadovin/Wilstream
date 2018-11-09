echo %1>>  %4config.ftp
echo %2>>  %4config.ftp
echo put %4%5>>  %4config.ftp
echo bye  >>  %4config.ftp
echo close  >> %4config.ftp 

ftp.exe -s:%4config.ftp %3
 
del %4%5
del %4config.ftp
