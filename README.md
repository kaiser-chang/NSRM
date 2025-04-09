APIClient 설치용 파일입니다.

1. api-dm-tool.zip :
   APIClient 설치 파일 입니다.  압축해제 하면,
   
   api-dm-tool
     - bin       : APIClient Service jar 파일 및 실행파일이 포함되어 있습니다.
                    설치서버의 OS가 Windows의 경우, java_env.bat 파일의 JAVA_HOME에 java가 설치된 폴더를 설정해야 합니다.
                    실행은, NSRM_EDI_Dev.exe (개발 profile) / NSRM_EDI.exe (운영 profile)을 실행하면 됩니다.
                    unix/linux OS의 경우, start_development.sh / start_production.sh 입니다.
     - Config    : api-dm-tool.yml 파일에 system-id 및 database-source 부분에 대해 설정하여야 합니다. 
     - Logs      : APIClient에서 생성되는 log 파일입니다.

2. config.zip : DB연결 문제로 정상적으로 작동이 불가능한 경우, 압축해제하여 api-dm-tool 하부의 config 폴더에 압축해제된 파일을 복사한 후에,
   api-dm-tool.yml 파일을 메모장(notepad) 등으로 편집하시면 됩니다.
   
3. lynxlib-api-dm-tool-application.jar : 최종 APIClient의 패키지 파일입니다.(api-dm-tool.zip을 압축해제한 경우 불필요)
   api-dm-tool 밑의 bin 폴더에 복사하면 됩니다.(1.2.9 이전버전을 사용하는 경우에 한하여, 복사하면 됩니다.)
   
4. jvm.zip      : 64 bit Windows를 사용하는 서버/PC에서 사용합니다. 
   java virtual machine 입니다.  APIClient 설치하는 서버(PC)에 java install 없이, jvm 다운로드 하여 압축해제하여 java를 실행할 수 있습니다.
   openJava 1.8 버전입니다.

4. jvm32.zip    : 윈도우 XP와 같이 32 bit Windows를 사용하는 서버/PC에서 사용합니다.
   java virtual machine 입니다.  APIClient 설치하는 서버(PC)에 java install 없이, jvm 다운로드 하여 압축해제하여 java를 실행할 수 있습니다.
   openJava 1.8 버전입니다.
