APIClient 설치용 파일입니다.

1. NSRM_EDI.zip :
   APIClient 설치 파일 및 Guide 문서입니다.  압축해제 하면, APIClient 와 GUide 폴더가 생성됩니다.
   
   APIClient
     +- bin       : APIClient Service jar 파일 및 실행파일이 포함되어 있습니다.
                    설치서버의 OS가 Windows의 경우, java_env.bat 파일의 JAVA_HOME에 java가 설치된 폴더를 설정해야 합니다.
                    실행은, NSRM_EDI_Dev.exe (개발 profile) / NSRM_EDI.exe (운영 profile)을 실행하면 됩니다.
                    unix/linux OS의 경우, start_development.sh / start_production.sh 입니다.
     +- Config    : api-dm-tool.yml 파일에 system-id 및 database-source 부분에 대해 설정하여야 합니다. 
     +- Logs      : APIClient에서 생성되는 log 파일입니다.

   Guide
     +- 한글문서도 된 APIClient 설치 문서 및 절차 등에 대한 문서가 있습니다.
        회사별로 APIClient의 Config 폴더 하부의 api-dm-tool.yml 파일에 설정할 system-id를 찾는 excel-macro 파일이 포함되어 있습니다.   
    
3. jvm.zip      : 
   java virtual machine 입니다.  APIClient 설치하는 서버(PC)에 java install 없이, jvm 다운로드 하여 압축해제하여 java를 실행할 수 있습니다.
   openJava 1.8 버전입니다.
