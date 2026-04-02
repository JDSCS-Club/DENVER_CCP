# Denver 전동차 통신시스템 문서 정리 구조

> 정리일: 2026-04-02  
> 원본: `/Volumes/SSD_T9/Dropbox/Woojin/JDS_PRO/해외 프로젝트/denver`  
> 총 6,311 파일 / 7.2 GB (100MB 초과 파일 18개 제외)

---

## 전체 구조 요약

| # | 폴더 | 파일 수 | 용량 | 내용 |
|---|------|------:|-----:|------|
| 00 | MD_File | 2 | 16K | MD 분석 문서, 본 안내 문서 |
| 01 | 인터페이스_설계 | 187 | 340M | MDS ICD, WiMAX, LON, VoIP, 프로토콜, PIN/커넥터 |
| 02 | 설계_도면 | 351 | 1.2G | 회로도(장치별), 결선도, 승인도, 시스템구성도, BOM |
| 03 | 시험_인증 | 48 | 170M | Test Procedure, EMI/EMC, 시험결과 |
| 04 | SW_문서 | 239 | 510M | SFD, DDD/MDS, FDR, CMMI, SW릴리즈, 체크시트 |
| 05 | 정비_매뉴얼 | 749 | 1.8G | IPC(문서/도면/PDF), RMM/HMM, 운영매뉴얼 |
| 06 | 이슈_대응 | 884 | 2.4G | FMI, CNCS발열, 자동방송, PID, CCP통신, RS485 등 |
| 07 | 계약_견적 | 77 | 26M | PTS 계약서, 견적, 일정 |
| 08 | 데이터시트 | 65 | 82M | CPU/IC, 전원, 통신, 스피커, 스위치, 커넥터 |
| 09 | 발표_보고 | 120 | 172M | PPT 발표자료, 출장보고, 기타 문서 |
| 10 | 프로그램문서 | 36 | 28M | 장치별 개발 관련 문서 (LIC/CCP/PAC/LON/FPGA/VoIP) |
| 11 | SW코드 | 3,553 | 469M | 장치별 소스코드 및 바이너리 |

---

## 상세 구조

### 01_인터페이스_설계 (187파일, 340M)
- `MDS_ICD/` (67) - MDS Car Monitoring Network ICD, DDD, LON Works ICD
- `WiMAX_Wayside/` (34) - WiMAX ICD, Wayside 전송 시험, Penta PA
- `LON_Works/` (52) - LON Works 교육/참고 문서, Neuron C 가이드
- `프로토콜/` (10) - 프로토콜 문서 R04~R15, CCP UI, Operational Scenario
- `PIN_커넥터/` (17) - PIN 정리, 커넥터 조립 표준서, SOURIAU MSG
- `VoIP/` (7) - VoIP 시험 자료, 모듈 매뉴얼

### 02_설계_도면 (351파일, 1.2G)
- `승인도/` (136) - ROTEM 승인 도면, 설변 도면
- `시스템구성도/` (82) - DENVER 시스템 구성 그림
- `회로도/` (74) - 장치별 분류:
  - `APEM_Switch/` (34) - APEM 스위치 도면 (BMP/DXF)
  - `LIC-C3/` (24) - LIC-C3 회로도/PCB/GERBER
  - `LIC-C2/` (6) - LIC-C2 회로도 (DSN/PCB)
  - `LIC_파트리스트/` (5) - 파트리스트 (xlsx/xps)
  - `LIC-C1/` (3) - LIC-C1 (ZIP/BOM)
  - `LIC-C3A/` (2) - LIC-C3A GERBER/PCB
- `결선도_배선도/` (39) - 결선 작업 표준서, 케이블 문서
- `BOM/` (20) - 장치별 BOM, 부자재 리스트

### 03_시험_인증 (48파일, 170M)
- `EMI_EMC/` (36) - EMI/EMC 시험 성적서 원본 스캔
- `Test_Procedure/` (10) - 설계 검증 시험 절차서, 중련 시험
- `시험결과/` (2) - SDI 온도 시험, 시험 성적서

### 04_SW_문서 (239파일, 510M)
- `CMMI/` (143) - CMMI SW 공학 문서 (SQAP, SDD, SITP, RAMS)
- `SW_버전_릴리즈/` (26) - ECP, FMI 문서, Release Certificate
- `FDR/` (14) - FDR 설계 검토 패키지
- `SFD/` (12) - System Functional Description, SDB
- `DDD_MDS/` (8) - MDS DDD 분석 문서
- `시험절차_체크시트/` (30) - 장치별 Check Sheet, Test Procedure
- `펌웨어_구매/` (6) - LIC/CCP 펌웨어 구매 계약서

### 05_정비_매뉴얼 (749파일, 1.8G)
- `IPC/` (709) - Illustrated Parts Catalog
  - `IPC_부품도_PDF/` (445) - 부품 도면 PDF
  - `IPC_도면_DWG/` (195) - AutoCAD DWG 도면
  - `IPC_문서/` (41) - IPC Ch.10 Communication System 문서
  - `IPC_기타/` (28) - ZIP, 이미지 등
- `RMM_HMM/` (35) - Repair & Maintenance Manual, Heavy Maintenance Manual
- `운영매뉴얼/` (5) - Operator's Manual, 장치 업데이트 방법

### 06_이슈_대응 (884파일, 2.4G)
- `FMI/` (323) - FMI #7~#21, ANSM, Cab Latch, PTT
- `자동방송_불량/` (58) - 자동 방송 불량 대책서, 온도 챔버 시험
- `CNCS_발열/` (99) - CNCS 발열 FAN 대응, 정비 지침서
- `CCP_통신/` (31) - CCP RTS 제어 통신 고장, CI Shift
- `RS485_통신/` (26) - CNCS RS-485 통신 불량
- `PID_불량/` (36) - PID 파워/영상 출력 불량
- `FTP_부하/` (8) - FTP 파일 전송 시 시스템 부하
- `LIC_수리/` (3) - LIC 수리품 테스트
- `MDS_TimeStamp/` (1) - MDS 시간 동기화
- `PEI_OCC/` (1) - PEI-OCC 연동
- `SEPTA_참고/` (3) - SEPTA 프로젝트 참고 자료
- `기타_문서/` (295) - 이메일, 사진, 기타 이슈 문서

### 07_계약_견적 (77파일, 26M)
- `PTS_계약서/` (23) - ROTEM PTS, RAMS, 공급범위
- `견적/` (47) - 원가, 견적서, 장납기 정리
- `일정/` (7) - Master Schedule, FAI 일정

### 08_데이터시트 (65파일, 82M)
- `CPU_IC/` (11) - TMS320VC33, XC95288XL, XR16L784, MAX3535E
- `스위치/` (9) - APEM, EAO, PV 시리즈
- `커넥터_케이블/` (16) - Souriau, Huber+Suhner, RF 케이블
- `스피커_마이크/` (10) - AKG, Gooseneck MIC, 스피커
- `전원/` (10) - MZH30xx, V300B/C, VI_BRICK
- `차량배치도/` (3) - A Car/B Car General Arrangement
- `통신_VoIP/` (6) - AudioCodes, MOXA TN-5508/5516

### 09_발표_보고 (120파일, 172M)
- PPT 발표자료, 출장보고서, 시스템 구성도, 기타 문서

### 10_프로그램문서 (36파일, 28M)
- `LON_Works/` (15) - ICD 문서, MDS 인터페이스
- `PAC_MCU/` (3) - MCU 다운로드 매뉴얼, ULINK 매뉴얼
- `LIC/` (7) - LIC SW 정리, DDD, 데이터시트
- `VoIP/` (2) - VoIP 모듈 다운로드 매뉴얼
- `CCP/` (1) - CCP HW 회로도 PDF
- `CPLD_FPGA/` (1) - FPGA 다운로드 설명서
- `공통/` (7) - 출장 기록, 기타

### 11_SW코드 (3,553파일, 469M)
- `CPLD_FPGA/` (1,242) - FPGA/CPLD 프로젝트
  - `LIC_FPGA/` - LIC-C3 Xilinx ISE VHDL (최신/ver1/ver2/이전/PCB)
  - `RF_COM/` - DPO CPLD (Xilinx ISE), JED 바이너리
  - `FPGA_POF/` - VTX/VRX FPGA 이미지 (.pof)
  - `장치_펌웨어_HEX/` - FDI/PII/SDI hex
- `LON_Works/` (606) - Neuron C 소스 (Ver1.1.01~1.1.03), 참고자료
- `CCP_소프트웨어/` (587) - MFC C++ 소스 (V1.0.0.0~V1.0.0.4), 배포 바이너리, CRA 실행파일
- `LIC_펌웨어/` (367) - TMS320VC33 DSP ASM/C++ (Ver1.0.35~Ver1.1.05)
- `기타이슈_소스/` (311) - 이슈 대응 중 생성된 소스/바이너리
- `PAC_MCU/` (201) - STR710 ARM C 펌웨어 (PAC_160623/170405)
- `VoIP_tftpd64/` (188) - tftpd64 소스/도구
- `아이텍_GPIO/` (51) - GPIO 테스트 프로그램

---

## 제외된 파일 (100MB 초과 - GitHub 업로드 불가)

- `Woojin.zip` (1.1GB)
- 동영상 6개: IMG_5086.MOV(746M), IMG_5067.MOV(242M) 등
- ZIP 5개: DENVER_20120329.zip(195M), 전시회사진.zip(168M) 등
- 대용량 PPT/RTF/PDF 3개 (100~112MB)
- `V9.7_B55_CSA (1).exe` (269MB)
