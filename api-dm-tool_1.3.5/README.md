[English Ver.](https://code.sdsdev.co.kr/siis/api-dm-tool/blob/master/README.md#api-dm-tool-1)

# APi D&M Tool

## APi D&M Tool 소개

시스템의 데이터를 수집하여 전송하거나 수신된 데이터를 시스템에 저장해주는 단독 실행형 어플리케이션으로 다음과 같은 기능을 제공합니다.

1. Java 8 기반의 JVM(Java Virtual Machine) 환경이 제공되는 OS(운영체제)
2. 시스템의 데이터베이스에서 데이터를 발췌하여 전송 또는 수신 데이터 저장
3. CronJob을 지원하는 배치 스케쥴링 기능 (Quartz 라이브러리 사용), 원격 설정 관리 지원
4. configuration (yaml) 정보 원격 설정 관리 지원

## ※필독※ API DM Tool 사전준비사항
- [사전준비사항.md](https://code.sdsdev.co.kr/siis/api-dm-tool/blob/master/%EC%82%AC%EC%A0%84%EC%A4%80%EB%B9%84%EC%82%AC%ED%95%AD.md)

## 배포 파일 다운로드  
### 다운로드 API
- URL
  - 개발(외부망): GET https://scadev.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/{tag}/0.0.0  
  - 개발(내부망): GET https://ipaas-scadev.sec.samsung.net/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/{tag}/0.0.0
  - 운영(외부망): GET https://sca.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/{tag}/0.0.0
  - 운영(내부망): GET https://ipaas-sca.sec.samsung.net/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/{tag}/0.0.0   
  > ZIP 파일 형태 tag: nsrm-zip   
  > GET https://scadev.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/nsrm-zip/0.0.0
  > TAR 파일 형태 tag: nsrm-tar
  > GET https://scadev.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/nsrm-tar/0.0.0
  
- 인증
배포 파일 요청 시 만료기간이 있는 Bearer Token 제공
- 다운로드 요청 시 최신 파일만 받거나 버전을 특정해서 받을 수 있음: URL에 "0.0.0"을 입력하면 최신 버전을 받거나 "1.2.1.nsrm"과 같이 버전을 특정 할 수 있음

### Postman 이용 시
- POSTMAN 상단 File > Settings > General "Max response size in MB" 크기를 바꿔줌: 50 → 100
- GET 방식으로 다운로드 API URL을 입력하고 Authorization탭에서 Bearer Token Type을 선택 후 발급받은 Token 입력
- "Send" 버튼 옆의 화살표를 클릭해서 "Send and Download" 클릭
- 다운로드가 완료되면 파일 저장 다이얼 로그 화면에서 "api-dm-tool.zip" 이름 입력하고 저장 및 압축 해제

### CURL 이용 시
- 아래 CURL 명령어에 발급 받은 토큰을 입력 후 실행
curl --header "Authorization:Bearer [발급받은 토큰 입력]" -o api-dm-tool.zip -k -v --location "https://scadev.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/0.0.0"
- CURL이 실행되는 디렉토리에 "api-dm-tool.zip" 파일이 다운로드 되고 해당 파일을 압축 해제

## 배포 파일 구성

### 배포 파일
> /bin, /config 하위 디렉토리 및 파일, start_xxx.sh, stop_xxx.sh, start_xxx.bat, stop_xxx.bat 파일 배포  

```
root
   ├── bin
   │   ├── lynxlib-api-dm-tool-application-1.0.0.jar: 에이전트 어플리케이션 실행 파일
   │   ├── start_development/production.sh, stop_development/production.sh: 리눅스 환경 어플리케이션 시작/종료 스크립트
   │   └── start_development/production.bat, stop_development/production.bat: 리눅스 환경 어플리케이션 시작/종료 스크립트
   ├── config
   │   ├── api-dm-tool.yml: 운영 system id(필수) 및 database 연결 정보 설정 
   │   ├── api-dm-tool-development.yml: 개발 database 연결 정보 설정 
   │   └── logback-spring.xml: 개발/운영 어플리케이션 로그 설정 
   │
   └── logs
       ├── api-application_api_[development/production].log: 개발/운영 어플리케이션 실행 시 생성되는 REST API 호출 정보 로그 파일  
       └── api-application_[development/production].log: 개발/운영 어플리케이션 실행 시 생성되는 스케쥴 실행 정보 로그 파일  
   
```

- bin   
`lynxlib-api-dm-tool-application.jar` Spring Boot로 구성된 에이전트 어플리케이션 실행 jar

- config    
`api-dm-tool.yml` system id는 필수로 설정하고, 데이터 베이스 연결 정보는 api-dm-tool.yml 파일에 설정하거나 설정관리포털(SIIS포털)에서 설정 가능    
개발/운영 실행 환경별로 적용 설정 값이 다르다면 아래와 같이 프로파일별 설정파일 추가하여 적용
    - api-dm-tool-development.yml(개발 환경), api-dm-tool-production.yml(운영 환경)  
    
```yml
lynxlib:
    application:
        # 설정관리포털(SIIS포털)에 등록된 연계 시스템ID(System ID)로 D&M Tool 어플리케이션을 실행하기 위한 필수 설정값
        system-id: SYS202311080002
# 시스템 Database 연결 정보 설정
# 설정관리포털(SIIS포털)에 데이터베이스 인증정보를 제공하여 설정한 경우 yaml 파일에서는 주석처리 하고 설정이 안되어 있면다면 직접 설정
#   datasource:
#       - datasource-name: system-datasource #수정불가 Uncorrectable
#         database-type: sqlserver #oracle sqlserver db2 postgresql mysql mariadb tibero 
#         database-name: database-name
#         server: 127.0.0.1
#         port: 1234
#         username: username
#         password: password   
```

- logs   
`api-application.log` 스케쥴링 실행 로그     
`api-application_api.log` Rest API 실행 로그     

- start_development/production.sh,  
  stop_development/production.sh    
  실행 환경 프로파일별(개발/운영) 리눅스 어플리케이션 실행/종료 스크립트  

- start_development/production.bat,   
  stop_development/production.bat    
  실행 환경 프로파일별(개발/운영) 윈도우 어플리케이션 실행/종료 스크립트

## 배포 파일 설치 

주의) 배포파일 설치후 실행은 설정관리포털(SIIS포털)에서 시스템의 정보 세팅 이후 정상 실행이 가능하므로 사전에 기술지원 담당자에게 문의 바랍니다.  

### 윈도우(Window) 

1. 설치 디렉토리에 API-DM-TOOL.zip 파일을 복사한다.
2. API-DM-TOOL.zip 압축을 해제한다.
3. config 폴더로 이동 후 `api-dm-tool.yml` 파일에 `system-id` 의 값을 제공 받은 시스템의 ID로 변경.  
   (인증정보 전달 시 제공한 `systemId` 의 값)
4. 데이터베이스 정보를 제공 안했다면 dabasebase 연결 정보 설정
5. bin 폴더로 이동후 `start_development/production.bat`을 열어서 JAVA_HOME 지정
6. `start_development.bat`(개발환경) 또는 `start_production.bat`(운영환경) 파일 실행


### 리눅스(Linux) 

1. 설치 디렉토리에 API-DM-TOOL.zip 파일을 복사한다.
2. API-DM-TOOL.zip 압축을 해제한다.  
   `unzip API-DM-TOOL.zip`  
3.config 폴더로 이동 후 `api-dm-tool.yml` 파일에 `system-id` 의 값을 제공 받은 시스템의 ID로 변경.  
   (인증정보 전달 시 제공한 `systemId` 의 값)
4. 데이터베이스 정보를 제공 안했다면 dabasebase 연결 정보 설정
5. `start_development.bat`(개발환경) 또는 `start_production.bat`(운영환경) 파일 실행

### Database Connection Information
```sql  
  driver-class name (전체 동일) : net.sf.log4jdbc.sql.jdbcapi.DriverSpy
  
  jdbcUrl Format
  
  /* Oracle */  
  jdbc:log4jdbc:oracle:thin:@//[host][:port]/[servicename]
  EX) jdbc:log4jdbc:oracle:thin:@//10.10.10.10:1521/ORACLE
  
  /* MySQL */
  jdbc:log4jdbc:mysql://[host][:port]/[database]
  EX) jdbc:log4jdbc:mysql://10.10.10.10:1521/MYSQL
  
  /* SQL Server */
  jdbc:log4jdbc:sqlserver://[host][:port];databaseName=[database_name]
  EX) jdbc:log4jdbc:sqlserver://10.10.10.10:1521;databaseName=SQLSERVER

  /* MariaDB */
  jdbc:log4jdbc:mariadb://[host][:port]/[database]
  EX) jdbc:log4jdbc:mariadb://10.10.10.10:1521/MARIA

  /* Postgresql */
  jdbc:log4jdbc:postgresql://[host][:port]/[database]
  EX) jdbc:log4jdbc:postgresql://10.10.10.10:1521/POSTGRE
  
  /* Tibero */
  jdbc:log4jdbc:tibero:thin:@[host][:port]:[database]
  EX) jdbc:log4jdbc:tibero:thin:@10.10.10.10:1521:TIBERRO
  
```

## 어플리케이션 실행 정보  

어플리케이션이 정상 로딩되었는지 확인하기 위한 자체API 정보 입니다.

- 실행 확인: http://<실행 서버 IP>:7091/monitoring/alive URL을 GET 방식으로 호출하여 ok 응답 확인
- 설정 정보 확인: http://<실행 서버 IP>:7091/monitoring/configurations URL을 GET 방식으로 호출하여 인증정보, 스케쥴링 설정 정보 확인
- 설정 정보 갱신: http://<실행 서버 IP>:7091/monitoring/refresh-configurations URL을 GET 방식으로 호출하여 인증정보, 스케쥴링 설정 갱신 및 확인
- API 호출 스케쥴 실행: http://<실행 서버 IP>:7091/monitoring/job-schedules URL을 GET 방식으로 호출하여 API 호출 스케쥴 목록 확인 및 즉시 실행
- 문자열 암호화: http://<실행 서버 IP>:7091/monitoring/encryptions/{value} URL을 GET 방식으로 호출하여 전달한 value를 어플리케이션에서 복호화할 수 있는 암호화된 문자열로 변환 
- 데이터베이스 정보 암호화: http://<실행 서버 IP>:7091/monitoring/encryptions/database
- 어플리케이션 실행 포트: 개발 7091 또는 7092, 운영 7093 또는 7094 포트가 번갈아 가면서 실행 됨

```bash
curl -k -X GET http://localhost:7091/monitoring/alive    
curl -k -X GET http://localhost:7091/monitoring/configurations  
curl -k -X GET http://localhost:7091/monitoring/refresh-configurations 
curl -k -X GET http://localhost:7091/monitoring/job-schedules
curl -k -X GET http://localhost:7091/monitoring/encryptions/{value}
curl -k -X GET http://localhost:7091/monitoring/encryptions/database
```

# API D&M Tool

## API D&M Tool Introduction

A standalone application that send stored data from systems or save recieved data to systems, providing the the following functionalities: 

1. Requires an OS(Operating System) environment that supports Java-8 based JVM(Java Virtual Machine)
2. Requires database of systems for sending and saving data.
3. Supports batch scheduling functionality using CronJob(utilizing the Quartz library) and remote configuration management. 
4. Supports remote configuration management of information via configuration (yaml) files. 

## Download deployment file   
### Download API
- URL
  - Development(External): GET https://scadev.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/{tag}/0.0.0  
  - Development(Internal): GET https://ipaas-scadev.sec.samsung.net/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/{tag}/0.0.0
  - Production(External): GET https://sca.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/{tag}/0.0.0
  - Production(Internal): GET https://ipaas-sca.sec.samsung.net/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/{tag}/0.0.0
  > ZIP file format tag: nsrm-zip   
  > GET https://scadev.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/nsrm-zip/0.0.0
  > TAR file format tag: nsrm-tar
  > GET https://scadev.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/nsrm-tar/0.0.0
  
- Authentication
Providing Bearer Token that has expiration when requested. 
- When you request a download, you can only receive the latest file or receive a specific version: If you enter "0.0.0" in the URL, you can receive the latest version or "1.2.1.nsrm" versions can be specified

### Using Postman
- Change General "Max response size in MB" value at Menu File > Settings > General "Max response size in MB" : 50 → 100
- Enter the download API URL using the GET method, select the Bearer Token Type in the Authorization tab, and enter the issued Token.
- Click the arrow button next to "Send" and click "Send and Download"
- Once the download is complete, enter the name "api-dm-tool.zip" on the file save dial log screen and save and decompress.

### Using CURL
- Execute below CURL command using issued token.
curl --header "Authorization:Bearer [issued token]" -o api-dm-tool.zip -k -v --location "https://scadev.ipaas.samsung.com/sec/kr/siis_ui_configuration_provider/1.0/rest-api/deployments/download/ApiDMTool/0.0.0"
- The "api-dm-tool.zip" file is downloaded to the directory where the CURL is executed and the file is decompressed.



## Deployment File Configuration

### Deployment Files
> Deploy the following directories and files, start_xxx.sh, stop_xxx.sh, start_xxx.bat, stop_xxx.bat files, under /bin and /config. 

```
root
   ├── bin
   │   ├── lynxlib-api-dm-tool-application-1.0.0.jar: Agent application execution file
   │   ├── start_development/production.sh, stop_development/production.sh: Application start/stop scripts for Linux environment
   │   └── start_development/production.bat, stop_development/production.bat: Application start/stop scripts for Linux environment
   ├── config
   │   ├── api-dm-tool.yml: Configure system id(mandatory) and database connection production information settings  
   │   ├── api-dm-tool-development.yml: Configure database connection development information settings  
   │   └── logback-spring.xml: Configuration of development/production application log
   │
   └── logs
       ├── api-application_api_[development/production].log: Log files for REST API calls generated on development/production application launch   
       └── api-application_[development/production].log: Log files for Schedule executions generated on development/production application launch  
   
```

- bin   
`lynxlib-api-dm-tool-application.jar` Agent application execution jar configured with Spring Boot 
 
- config    
`api-dm-tool.yml` system id setting is mandatory and databse connection information can be set in the api-dm-tool.yml file or through SIIS portal.      
If different configuration values are required for development/production execution environments, add specific configuration files per profile as follows: 
    - api-dm-tool-development.yml(dev environment), api-dm-tool-production.yml(prod environment)  
    
    
  ```yml
lynxlib:
    application:
        # Interface system's System ID info registered in configuration management portal (SIIS portal), required to execute the D&M Tool application 
        system-id: SYS202307170XXX 
# Interface(legacy) system's database connection information setting
# If you configure to the configuration management portal (SIIS Portal), annotate the yaml file and set it yourself if it is not set.
#   datasource:
#       - datasource-name: system-datasource # Uncorrectable
#         database-type: sqlserver #oracle sqlserver db2 postgresql mysql mariadb tibero 
#         database-name: database-name
#         server: 127.0.0.1
#         port: 1234
#         username: username
#         password: password     

  ```        

- logs   
`api-application.log` Scehduling Execution Log
`api-application_api.log` Rest API Execution Log

- start_development/production.sh,  
  stop_development/production.sh    
  Linux application start/stop scripts for each execution environment profile


- start_development/production.bat,   
  stop_development/production.bat    
  Window application start/stop scripts for each execution environment profile

## Deployment File Installation

Caution) After installing the deployment files, normal execution is possible only after setting up the information of the legacy system in the SIIS Portal. Please contact technical support PIC in advance.

### Window

1. Copy the apim-dm-tool.zip file to the installation directory. 
2. Unzip the API-DM-TOOL.zip file.
3. Move to the `api-dm-tool-development.yml` file in the config folder, then change the value of `system-id` to the ID of the system.
   (the value under `systemId` in the credentials info that was previously provided)
4. If you don't provide database connection information, you should configure it.   
5. Move bin directory and configure JAVA_HOME in `start_development/production.bat` files
4. Move to the bin folder, then execute the `start_development.bat`(development) or `start_development.bat`(production) file

### Linux

1. Copy the API-DM-TOOL.zip to the installation directory.
2. Unzip the API-DM-TOOL.zip file.
   `unzip API-DM-TOOL.zip`  
3. Move to the `api-dm-tool-development.yml` file in the config folder, then change the value of `system-id` to the ID of the legacy system.
   (the value under `systemId` in the credentials info that was previously provided)
4. If you don't provide database connection information, you should configure it.   
5. Move to the bin folder, grant execution permission `chmod 755 *.sh` `chmod 755 logs`, and execute the `start_development.sh` file


## Requests

Please inform the technical support team for the following requests:   

1. Request for firewall access of the installed server (Access Direction: Client Agent -> iPaas GateWay)   
   => SiiS(iPaaS)_Firewall_Guide_Client&Provider_20230925.xlsx
2. Create usage-status-data tables in the legacy system's DB.
   => [Usage Status Compilation Table Schema](#Usage-Status-Compilation-Table-Schema)
3. Provide legacy system's database connection information.
   => [Database Connection Information](#Database-Connection-Information)  
   => ID/PWD for database connection (password info managed by DES encyption)
4. Provide information of the system's located region OS time corresponding to 01:00 for scheduling the 1AM daily batch.  
   EX) If Korea is GMT+9 and the legacy system's OS is GMT0,  
       crontab configuration : 0 0 16 * * * (0 sec 0 min 16 hrs) (* * * : all values available for day/month/day of the week)

### Database Connection Information
```sql  
  driver-class name (All Same) : net.sf.log4jdbc.sql.jdbcapi.DriverSpy
  
  jdbcUrl Format
  
  /* Oracle */  
  jdbc:log4jdbc:oracle:thin:@//[host][:port]/[servicename]
  EX) jdbc:log4jdbc:oracle:thin:@//10.10.10.10:1521/ORACLE
  
  /* MySQL */
  jdbc:log4jdbc:mysql://[host][:port]/[database]
  EX) jdbc:log4jdbc:mysql://10.10.10.10:1521/MYSQL
  
  /* SQL Server */
  jdbc:log4jdbc:sqlserver://[host][:port];databaseName=[database_name]
  EX) jdbc:log4jdbc:sqlserver://10.10.10.10:1521;databaseName=SQLSERVER

  /* MariaDB */
  jdbc:log4jdbc:mariadb://[host][:port]/[database]
  EX) jdbc:log4jdbc:mariadb://10.10.10.10:1521/MARIA

  /* Postgresql */
  jdbc:log4jdbc:postgresql://[host][:port]/[database]
  EX) jdbc:log4jdbc:postgresql://10.10.10.10:1521/POSTGRE
  
  /* Tibero */
  jdbc:log4jdbc:tibero:thin:@[host][:port]:[database]
  EX) jdbc:log4jdbc:tibero:thin:@10.10.10.10:1521:TIBERRO
  
```

## Application Execution Information

Please note that this is an information of a separate individual API to confirm if the application is loaded normally. 

- To check execution: Call the URL http://<Execution server IP>:7091/monitoring/alive using the GET method to confirm the"OK" response. 
- To check configuration information: Call the URL http://<Execution server IP>:7091/monitoring/configurations using the GET method to confirm authentication information and scheduling configuration information.
- To refresh configuration information: Call the URL http://<Execution server IP>:7091/monitoring/refresh-configurations using the GET method to refresh authentication information and scheduling configuration information.
- To execute API Call Schedule: Call the URL http://<Execution server IP>:7091/monitoring/job-schedules using the GET method to check schedule list and execute schedule.
- Encryption of string: http://<Execution server IP>:7091/monitoring/encryptions/{value} Convert the value transmitted by calling the URL in the GET method to an encrypted string that can be decrypted in the application
- Encryption of database connection information: http://<Execution server IP>:7091/monitoring/encryptions/database
- Application port: Development 7091 or 7092, Production 7093 or 7094 ports run alternately 

  ```bash
curl -k -X GET http://localhost:7091/monitoring/alive    
curl -k -X GET http://localhost:7091/monitoring/configurations  
curl -k -X GET http://localhost:7091/monitoring/refresh-configurations 
curl -k -X GET http://localhost:7091/monitoring/job-schedules
curl -k -X GET http://<Execution server IP>:7091/monitoring/encryptions/{value}
curl -k -X GET http://localhost:7091/monitoring/encryptions/database
```
