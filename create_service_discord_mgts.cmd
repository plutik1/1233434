@echo off
::All files saved in 866

:: �஢�ઠ ���
set scriptPath=%~dp0
set "path_no_spaces=%scriptPath: =%"
if not "%scriptPath%"=="%path_no_spaces%" (
    echo ���� ᮤ�ন� �஡���. 
    echo ��������, ��६���� �ਯ� � ����� ��� �஡����.
    >nul pause
    exit /b
)

:: ����稥 �ࠢ �����������
echo.
echo ����� 䠩� ������ ���� ����饭 � �ࠢ��� ����������� (��� -^> �������� �� ����� �����������).
echo �᫨ �� 㢥७�, ������ ���� �������, �⮡� �த������ ᮧ����� �㦡�
echo.
pause

set BIN=%~dp0zapret\zapret-winws\
set ARGS=--wf-tcp=80,443,50000-65535 --wf-udp=443,50000-65535 ^
--filter-udp=443 --hostlist="%BIN%list-discord.txt" --dpi-desync=fake --dpi-desync-udplen-increment=10 --dpi-desync-repeats=6 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-65535 --dpi-desync=fake,tamper --dpi-desync-any-protocol --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80 --dpi-desync=split --dpi-desync-ttl=4 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist="%BIN%list-discord.txt" --dpi-desync=fake,split2 --dpi-desync-ttl=2 --dpi-desync-split-pos=1 --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig


set SRVCNAME=zapret-discord-mgts

net stop "%SRVCNAME%"
sc delete "%SRVCNAME%"
sc create "%SRVCNAME%" BINPath="\"%BIN%winws.exe\" %ARGS%" DisplayName="zapret DPI bypass: Discord (MGTS)" start=auto
sc description "%SRVCNAME%" "zapret DPI bypass software"
sc start "%SRVCNAME%"

echo.
echo ������ ���� ������ �⮡� ������� ���� . . . & >nul pause & exit
