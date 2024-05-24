# 수화 인식을 위한 CNN 하드웨어 가속기

- 기간: 2020.03 ~ 2021.12
- 사용언어: Python, Verilog
- 사용 툴: Colab, ModelSim, VSCode
- 담당역할: 팀장, 데이터 전처리, CNN 모델 설계,  CNN 모델 Verilog 언어로 기술
- 프로젝트 개요: Python CNN 모델을 Verilog 언어로 기술하여 연산속도를 높이는 프로젝트입니다.
![73c075ad-a8da-442e-bf6f-65005ad27aa1](https://github.com/rkdtks0816/jbnu-cnn-hw-accelerator/assets/72867019/b2fe6629-d6fd-4109-bc44-6d7effd7f30e)

---

✔️ **구현 사항**

- 파이 카메라를 통한 수화 촬영
- 이미지 데이터 전처리
    - 640 x 480 x 3 → 28 x 28 x 1
- Python Keras 모델 설계
    ![6e820f34-6402-4084-b281-6b4aa25b0cad](https://github.com/rkdtks0816/jbnu-cnn-hw-accelerator/assets/72867019/28d2f90d-58bc-425a-8888-5cb0077ec0b4)
- 결과 값을 GPIO 포트로 전송
- Python 언어로 설계한 알고리즘을 Verilog 언어로 재작성
    ![e519dd8d-9aea-404c-a1e6-2fb88ab1fff1](https://github.com/rkdtks0816/jbnu-cnn-hw-accelerator/assets/72867019/1d625594-e916-4c28-b1b6-b87cb9c891f6)
- Quartus 합성을 통해 HDL 코드를 논리 게이트 수준의 표현으로 변환
- 생성된 비트스트림 파일을 DE2-115 보드의 FPGA 칩에 프로그래밍
    ![c17e5452-fe2b-434b-96c4-e2ac2c47cb35](https://github.com/rkdtks0816/jbnu-cnn-hw-accelerator/assets/72867019/c3d4f2bc-bcb1-40ba-82ee-94b4d7400600)
- 결과 값을 보드의 Text_LCD에 출력

---

✔️ **담당 역할**

- 팀장: 일정 관리, 역할 분담, 발표
- TensorFlow 1에서 TensorFlow 2로 마이그레이션(Migration)
- OpenCV를 이용한 이미지 전처리
- ModelSim 툴을 통해 Verilog 언어로 기술 후 테스트
- Quartus로 합성 및 DE2-115 보드로 업로드
- GPIO 통신: 보드 버튼을 통한 사진 촬영, 보드 입력 값 수신

---

✔️ **기술 스택**

- **Verilog**
    - **툴**: ModelSim, Quartus Prime (Family : Cyclone IV E, Device : EP4CE115F29C7)
    - **플랫폼**: FPGA - DE2-115
- **Python**
    - **툴**: Visual Studio Code, Google Colab
    - **라이브러리**: OpenCV, TensorFlow 2
    - **플랫폼**: 라즈베리 파이 4

---

✔️ **기술 선정 이유**

- **TensorFlow 2**:
    - 사용하기 쉽고 직관적인 API를 제공하여, 딥러닝 모델을 빠르고 효율적으로 개발
- **Verilog**:
    - 하드웨어의 병렬성을 활용하여 여러 신호와 연산을 동시에 처리할 수 있어 시간적으로 효율적

---

✔️ **프로젝트 성과**

- 기존 Python 대비 100배의 시간적 성능 향상
- 캡스톤 디자인 경진대회 은상 수상
- 우수 교육생 선정

---

✔️ **프로젝트 회고**

- **Keep**
    - 예제 코드를 이해하고 응용
    - 매주 팀원, 교수님, 조교님과의 미팅
    - CNN 알고리즘의 이해 (Convolution, MaxPool, ReLU, Softmax)
- **Problem**
    - 인공지능에 초점을 맞춰 하드웨어 가속의 이점을 잘 어필하지 못함
    - 기획 및 설계보다 구현을 성급하게 진행하여 설계 오류 발생
        - 데이터셋 수정 필요
        - 모델 최적화 문제
        - 범용 코드 수정 필요
    - 문서화 부족으로 인해 이전에 이해했던 내용을 다시 이해하는 데 시간이 걸림
- **Try**
    - 프로젝트에 대해 사전 이해를 높이고, 기획 및 설계를 철저히 준비
    - 시도한 내용을 문서화
    - GPIO 포트를 통한 데이터 저장 시도
        - 전처리된 이미지 데이터를 GPIO로 보내고, 보드에서 받은 데이터를 LED로 확인하는 데 성공
        - 수신된 데이터를 저장하고 로직에 전달하는 시도와 실시간으로 로직에 보내는 시도는 실패

---

✔️**용어**

- `GPIO(General Purpose Input/Output)`
    - 특정한 목적이 미리 정의되어 있지 않고 일반적인 용도로 사용
    - MCU(Micro Controller Unit)가 외부 세계와 통신하는 방식
    - 외부 주변 장치를 구동
    - 여러 유형의 통신 주변 장치(UART, USB, SPI 등)를 통해 데이터를 교환
- `Verilog HDL(Hardware Description Language)`
    - 전자 회로 및 시스템에 사용되는 하드웨어 기술 언어
    - 회로 설계, 검증, 구현 등 여러 용도로 사용
- `Intel Quartus Prime (구 Altera Quartus) 소프트웨어`
    - FPGA 설계 전체 과정을 지원하는 통합 설계 환경
        1. **합성 (Synthesis)**:
            - Verilog, VHDL 등의 하드웨어 설명 언어로 작성된 코드를 논리 회로로 변환
        2. **설계 입력 및 편집 (Design Entry and Editing)**:
            - HDL 코드를 작성하고 편집할 수 있는 텍스트 편집기와 GUI 기반의 설계 입력 도구를 제공
            - 블록 다이어그램, 상태 머신, 스키매틱 캡처 등 다양한 설계 입력 방법을 지원
        3. **논리 시뮬레이션 (Logic Simulation)**:
            - 합성 전에 설계의 기능적 정확성을 검증하기 위한 시뮬레이션 도구를 제공
            - ModelSim과 같은 외부 시뮬레이션 도구와의 통합도 가능
        4. **타이밍 분석 (Timing Analysis)**:
            - 합성된 설계의 타이밍 특성을 분석하여, 목표 성능을 충족하는지 확인
            - Static Timing Analysis(STA)를 통해 클럭 주기와 경로 지연을 검토
        5. **배치 및 배선 (Place and Route)**:
            - 논리 게이트를 실제 FPGA의 물리적 리소스에 배치하고, 이들 사이의 연결을 최적화
            - 최적의 성능과 리소스 사용을 위해 자동 배치 및 배선 알고리즘을 사용
        6. **디버깅 및 검증 (Debugging and Verification)**:
            - SignalTap Logic Analyzer와 같은 내장 디버깅 도구를 제공하여, FPGA 내부 신호를 실시간으로 모니터링하고 분석
        7. **비트스트림 생성 (Bitstream Generation)**:
            - 최종적으로 FPGA에 프로그래밍할 수 있는 비트스트림 파일을 생성
            - 이 파일은 FPGA의 각 구성 요소와 연결을 정의
        8. **디바이스 프로그래밍 (Device Programming)**:
            - 생성된 비트스트림 파일을 JTAG 또는 USB Blaster를 통해 FPGA에 업로드
            - 프로그래밍 후 실제 하드웨어 동작을 테스트
- `플랫폼(Platform)`
    - 소프트웨어나 하드웨어를 실행할 수 있는 기본적인 구조나 환경
- `툴(Tool)`
    - 특정 작업을 수행하는 데 사용되는 소프트웨어나 하드웨어
