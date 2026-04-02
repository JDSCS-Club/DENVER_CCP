# Denver CCP 문서 폴더별 상세 정리

> 최종 업데이트: 2026-04-02  
> ✅ 표시: 하위 폴더 정리 완료

---

## 00_MD_File (2파일)

| 파일 | 설명 |
|------|------|
| DOC_폴더_구조_안내.md | 전체 문서 구조 안내 (원본) |
| DOC_폴더별_정리.md | 본 문서 (폴더별 상세 정리) |

---

## ✅ 01_인터페이스_설계 (187파일, 340M)

### ✅ MDS_ICD/ (67파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_ICD_문서 | 23 | SFD, Car Monitoring ICD (R01~R04), Comm/Propulsion/CCTV/Wayside ICD |
| 02_DDD_데이터사전 | 7 | Diagnostic Data Dictionary R01/R03, DDD 버전별 |
| 03_LON_Works_ICD | 3 | DENVER LONWORKS ICD Ver0(한/영), Ver1 |
| 04_MDS_회로도 | 10 | Fault Trainline Schematics, Car Network/InOutput Signal Module |
| 05_Phase_Shift | 7 | Phase Shift Control PPT(한/영), EMC, CI Phase Shift 제안 |
| 06_MDS_고장전송 | 4 | 고장 데이터 실시간 전송 방식(한/영), 알고리즘 수정 |
| 07_시험_검증 | 4 | Interoperability Test, TP Section 20, 검증 매트릭스 |
| 08_FDR_패키지 | 3 | FDR Package ZIP, 작성 필수 포함 사항 이메일 |
| 09_기타_참고 | 6 | HCN 인터페이스, PHA, 회의록 |

### ✅ LON_Works/ (52파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_LonWorks_기술문서 | 20 | 교육자료, 입문서, 가이드, NodeUtil, SNVT |
| 02_Neuron_C_프로그래밍 | 3 | Neuron C 프로그래밍/레퍼런스/에러 가이드 |
| 03_LonMark_표준규격 | 5 | Interoperability Guidelines, Enumeration, Self-Doc |
| 04_DENVER_프로젝트 | 8 | ICD Ver2, DPRAM 구조, Protocol, Pre-Test |
| 05_하드웨어_회로도 | 5 | PL31XX 데이터북, SCHEMATIC (PL3120/AVR/DISPLAY/SENSOR) |
| 06_메모리_IC_데이터시트 | 7 | AT24C512C, AT25F512, AT25010A, SPI/Serial EEPROM/Flash |
| 07_행정_계약 | 4 | 사업자등록증, 훈련위탁계약서 |

### ✅ WiMAX_Wayside/ (34파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_WiMAX_ICD | 7 | WiMAX ICD 원본/Rev.2/RFCOMM |
| 02_Wayside_시험 | 8 | Wayside 전송 시험(한/영), Interface Test Plan v0.5~0.6 |
| 03_Penta_PA | 4 | Penta PA System Overview, RFI-01, Barix Annuncicom |
| 04_VoIP_통신 | 3 | VoIP 시험 결과 보고서, IP Office SIP phones |
| 05_Track_Charts | 4 | EC/GL/NWES Track Charts, comm chart |
| 06_PTC_LAB | 3 | PTC LAB 문서 (130521/130523/최종) |
| 07_기타_참고 | 5 | Rolling Stock ICFs, CCTV Test, IPC Ch.10 |

### PIN_커넥터/ (17파일)
SOURIAU MSG 커넥터, ITH 조립 표준서, Denver PIN 정리, CRA PIN

### 프로토콜/ (10파일)
프로토콜 문서 R04~R15, CCP User Interfaces, Operational Scenario

### VoIP/ (7파일)
VoIP 시험 자료, 모듈 다운로드 매뉴얼, IP7 Modules

---

## 02_설계_도면 (351파일, 1.2G)

| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 승인도/ | 136 | ROTEM 승인 도면, 설변 도면 |
| 시스템구성도/ | 82 | DENVER 시스템 구성 그림 |
| 회로도/ | 74 | APEM_Switch(34), LIC-C3(24), LIC-C2(6), LIC_파트리스트(5), LIC-C1(3), LIC-C3A(2) |
| 결선도_배선도/ | 39 | 결선 작업 표준서, 케이블 문서 |
| BOM/ | 20 | 장치별 BOM, 부자재 리스트 |

---

## 03_시험_인증 (48파일, 170M)

| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| EMI_EMC/ | 36 | EMI/EMC 시험 성적서 원본 스캔 |
| Test_Procedure/ | 10 | 설계 검증 시험 절차서, 중련 시험 |
| 시험결과/ | 2 | SDI 온도 시험, 시험 성적서 |

---

## 04_SW_문서 (239파일, 510M)

| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| CMMI/ | 143 | CMMI SW 공학 문서 (SQAP, SDD, SITP, RAMS) |
| 시험절차_체크시트/ | 30 | 장치별 Check Sheet, Test Procedure |
| SW_버전_릴리즈/ | 26 | ECP, FMI 문서, Release Certificate |
| FDR/ | 14 | FDR 설계 검토 패키지 |
| SFD/ | 12 | System Functional Description, SDB |
| DDD_MDS/ | 8 | MDS DDD 분석 문서 |
| 펌웨어_구매/ | 6 | LIC/CCP 펌웨어 구매 계약서 |

---

## 05_정비_매뉴얼 (749파일, 1.8G)

| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| IPC/ | 709 | IPC_부품도_PDF(445), IPC_도면_DWG(195), IPC_문서(41), IPC_기타(28) |
| RMM_HMM/ | 35 | Repair & Maintenance Manual, Heavy Maintenance Manual |
| 운영매뉴얼/ | 5 | Operator's Manual, 장치 업데이트 방법 |

---

## ✅ 06_이슈_대응 (884파일, 2.4G)

### FMI/ (323파일)
FMI #7~#21, ANSM, Cab Latch, PTT

### ✅ 기타_문서/ (295파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_이메일 | 67 | .eml/.msg (CCP 송부, DTS 시험, SEPTA, 프로토콜) |
| 02_VoIP_관련 | 19 | VoIP 동작 플로우, 모듈 매뉴얼, PBX 연결 |
| 03_CCP_관련 | 6 | CCP 업무회의, 펌웨어 개발 견적, 계약서 |
| 04_PAC_MCU | 36 | STR710/ATMEGA8 다운로드, PAC 소스, DPAC/PAC ZIP |
| 05_ICD_기술문서 | 38 | ICD R05, CAB Latch, 검토서, 수리 보고서, GPIO |
| 06_사진_동영상 | 52 | 현장 사진 JPG, 동영상 m4v, MDS Scanner PNG |
| 07_LIC_Neuron_프로젝트 | 36 | Denver_LIC.* Neuron C 프로젝트 파일 |
| 08_STR710_IDE | 5 | IAR Embedded Workbench 프로젝트 |
| 09_Git_빌드_임시 | 33 | UUID, git objects, pack, .bak |
| 10_기타 | 2 | 로그, RTF |

### ✅ CNCS_발열/ (99파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_보고서_분석 | 8 | failure list, Temp Log, 배기팬/온도센서 검토, FAN 선정 |
| 02_FAN_설계도면 | 15 | EXHAUST FAN ASSY/FRAME/BRACKET/WIRING (CATDrawing/DWG/PDF) |
| 03_FAN_3D_CAD | 20 | CATIA 3D 파트/어셈블리 |
| 04_데이터시트 | 9 | DELTA FAN, ebm papst, San Ace, 온도센서 |
| 05_사진_동영상 | 47 | 현장 사진 JPG 40장, 동영상 MOV 7개 |

### ✅ 자동방송_불량/ (57파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_대책서_보고서 | 11 | 자동방송 불량 대책서(한/영/ROTEM), 재현시험 rev1~3 |
| 02_고장분석 | 10 | 고장 내역 분석, 장애 발생 현황, GPS 수신 비교 |
| 03_Onboard_시험 | 6 | Onboard Test Plan (0710~0918) |
| 04_온도챔버_시험 | 3 | 온도 챔버 시험 기록, Temp Log |
| 05_로그_분석 | 6 | DTS-Log 분석 방법(한/영), DPViewer, KML |
| 06_사진_동영상 | 17 | 현장 사진 JPG 10장, 동영상 MOV 6개 |
| 07_기타 | 4 | 이메일, Visio, 기타 PPT |

### ✅ CCP_통신/ (31파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_불량분석_보고서 | 3 | CCP 필드불량 원인분석/재발방지 대책, 프로토콜 |
| 02_회로도_데이터시트 | 5 | 74LS123 데이터시트/캡처, CCP 회로도 |
| 03_사진_동영상 | 23 | 현장 사진 JPG 20장, 동영상 MOV/mp4 3개 |

### ✅ PID_불량/ (36파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_보고서_ECN | 8 | FMI#21 HW Modification, PID Power Board, ECN(한/영) |
| 02_영상신호_측정 | 16 | PID R2 / CRA X6 영상신호 캡처 (차량별) |
| 03_오실로스코프_캡처 | 10 | DS0001~DS0010 파형 캡처 |
| 04_이메일 | 2 | ECN 요청, PID 파워불량 진행현황 |

### ✅ RS485_통신/ (26파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_불량분석_보고서 | 1 | CNCS보드 RS485통신 불량 분석 |
| 02_회로도 | 4 | CNCS/VBPB/VTX/WLR 회로도 PDF |
| 03_테스트_프로그램 | 15 | CDTData/Main/PrinterPort EXE, 소스, ZIP |
| 04_스크린샷 | 6 | 통신 테스트 스크린샷 |

### 미정리 폴더
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| FTP_부하/ | 8 | FTP 파일 전송 시 시스템 부하 |
| LIC_수리/ | 3 | LIC 수리품 테스트 |
| MDS_TimeStamp/ | 1 | MDS 시간 동기화 |
| PEI_OCC/ | 1 | PEI-OCC 연동 |
| SEPTA_참고/ | 3 | SEPTA 프로젝트 참고 자료 |

---

## ✅ 07_계약_견적 (77파일, 26M)

### ✅ PTS_계약서/ (23파일)
| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_PTS_본문 | 4 | PTS 원문, 통신 공급범위(한영문), Ethernet Switch PTS |
| 02_SOW_계약조건 | 9 | Scope of Work, General Terms, Attachment, SEMS, 일정 |
| 03_기술사양_TP | 6 | TP Section 20/23, 환경 등급, 재료/가연성 규격 |
| 04_RAMS_품질 | 1 | RAMS approach |
| 05_참고자료 | 3 | SEPTA vs DENVER 비교, 시스템 구성도 |

### 견적/ (47파일)
원가, 견적서, 장납기 정리

### 일정/ (7파일)
Master Schedule, FAI 일정

---

## 08_데이터시트 (65파일, 82M)

| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 커넥터_케이블/ | 16 | Souriau, Huber+Suhner, RF 케이블 |
| CPU_IC/ | 11 | TMS320VC33, XC95288XL, XR16L784, MAX3535E |
| 스피커_마이크/ | 10 | AKG, Gooseneck MIC, 스피커 |
| 전원/ | 10 | MZH30xx, V300B/C, VI_BRICK |
| 스위치/ | 9 | APEM, EAO, PV 시리즈 |
| 통신_VoIP/ | 6 | AudioCodes, MOXA TN-5508/5516 |
| 차량배치도/ | 3 | A Car/B Car General Arrangement |

---

## ✅ 09_발표_보고 (120파일, 172M)

| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| 01_PDR_FDR_발표 | 9 | PDR/FDR 발표자료, SFD, SRS, CDRL |
| 02_시스템_설계 | 22 | 시스템 구성도, ICD, PTS, 배선도, Operating Manual |
| 03_DPO_통화절차 | 13 | DPO 동작 설명, PEI-OCC 통화 흐름도, InterCom |
| 04_장치별_기술 | 44 | SDI/LIC/BPB/DPH/MDS/CRA/CCP/PA/VoIP/Wayside/EMI, 커넥터, 구조해석 |
| 05_출장_회의 | 8 | 출장 협의, Action Item, Comment 답변 |
| 06_FAI_시험 | 3 | FAI 시험 SET, 조치사항, 시험지그 |
| 07_SEPTA_비교 | 4 | DENVER-SEPTA 차이점, 기능 비교 |
| 08_제안서_현황 | 15 | 제품 개발 제안서, 우진 발표자료, 조직도, 진행현황 |
| 09_기타 | 2 | 기타 이미지/PPT |

---

## 10_프로그램문서 (36파일, 28M)

| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| LON_Works/ | 15 | ICD 문서, MDS 인터페이스 |
| LIC/ | 7 | LIC SW 정리, DDD, 데이터시트 |
| 공통/ | 7 | 출장 기록, 기타 |
| PAC_MCU/ | 3 | MCU 다운로드 매뉴얼, ULINK 매뉴얼 |
| VoIP/ | 2 | VoIP 모듈 다운로드 매뉴얼 |
| CCP/ | 1 | CCP HW 회로도 PDF |
| CPLD_FPGA/ | 1 | FPGA 다운로드 설명서 |

---

## 11_SW코드 (3,553파일, 469M)

| 하위 폴더 | 파일 수 | 주요 내용 |
|-----------|------:|----------|
| CPLD_FPGA/ | 1,242 | LIC_FPGA(VHDL), RF_COM(CPLD), FPGA_POF, 장치_펌웨어_HEX |
| LON_Works/ | 606 | Neuron C 소스 (Ver1.1.01~1.1.03) |
| CCP_소프트웨어/ | 587 | MFC C++ 소스 (V1.0.0.0~V1.0.0.4), CRA 실행파일 |
| LIC_펌웨어/ | 367 | TMS320VC33 DSP ASM/C++ (Ver1.0.35~Ver1.1.05) |
| 기타이슈_소스/ | 311 | 이슈 대응 중 생성된 소스/바이너리 |
| PAC_MCU/ | 201 | STR710 ARM C 펌웨어 (PAC_160623/170405) |
| VoIP_tftpd64/ | 188 | tftpd64 소스/도구 |
| 아이텍_GPIO/ | 51 | GPIO 테스트 프로그램 |

---

## 정리 현황 요약

| 폴더 | 상태 | 정리된 하위 폴더 수 |
|------|:----:|---:|
| 01_인터페이스_설계/MDS_ICD | ✅ | 9 |
| 01_인터페이스_설계/LON_Works | ✅ | 7 |
| 01_인터페이스_설계/WiMAX_Wayside | ✅ | 7 |
| 06_이슈_대응/기타_문서 | ✅ | 10 |
| 06_이슈_대응/CNCS_발열 | ✅ | 5 |
| 06_이슈_대응/자동방송_불량 | ✅ | 7 |
| 06_이슈_대응/CCP_통신 | ✅ | 3 |
| 06_이슈_대응/PID_불량 | ✅ | 4 |
| 06_이슈_대응/RS485_통신 | ✅ | 4 |
| 07_계약_견적/PTS_계약서 | ✅ | 5 |
| 09_발표_보고 | ✅ | 9 |
| **합계** | **11개 폴더** | **70개 하위 폴더** |
