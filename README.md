# ios-keynote
3-4주차 프로젝트

# 주간 계획

### 07월 17일 (월)

- [x] 주간 계획 세우기
- [x] Concrete type의 모델 구현하기 - (30m -> 30m)
- [x] OOP 원칙을 적용하여 모델 리펙토링하기 - (1hr -> 2hr)
    - [x] random값과 생성자를 분리하고, 주입받기

- [x] system log 함수에 대해 공부하기 - (20m -> 10m)
- [x] 모델의 디버그 출력을 system log로 리펙토링하기. - (20m -> 10m)


<details>
    <summary>스크린샷</summary>
    <img width="800" alt="image" src="https://github.com/softeerbootcamp-2nd/ios-keynote/assets/46219689/888491e8-4afa-4e29-a97e-f7e00364746b">
    
</details>

### 07월 17일 (화)

- [x] 9자리 고유값 만들기 - (?? -> 3hr)
- [x] SMDataModel과 UIKit의 연동
- [x] Slide 객체를 기반으로 View 그려보기

<details>
    <summary>스크린샷</summary>
    <img width="500" alt="image" src="https://user-images.githubusercontent.com/46219689/254361875-6c05f37c-6079-4a0a-a0e3-9c50510962bf.png">
</details>

### 07월 18일 (수)

- [x] 왼쪽 네비게이터, 중앙 작업화면, 오른쪽 정보화면을 나눠서 구현.
  - [x] 정보 화면에 배경색 버튼, 투명도 Stepper 구현.
- [ ] View를 Tap했을 때 해당 Model의 정보가 보여지는 것
    - [ ] Model의 정보가 InspectorView에 전달되는 클로저/델리게이트 설계
    - [x] View의 Tap Gesture와 Model 정보 전달 기능과 연결
    
### 07월 23일 (일)
- [x] 배경 색을 지정하면, View의 색상이 바뀜
    - [x] 배경 색 버튼을 누를 때 마다, Model의 color값이 바뀜
    - [x] Model의 color값이 바뀔 때 마다, View의 backgroundColor가 바뀜
    - [x] 배경 색 버튼을 누르면, ColorPicker로 색 선택.
    <details>
    <summary>스크린샷</summary>
    <img width=500; src="https://github.com/sseungmn/ios-keynote/assets/46219689/1308ef3f-2295-4de6-830f-90e93c53d055">
    </details>

### 07월 24일 (월)
- [x] SlideManager 구현
    <details>
    <summary>설계</summary>
    <img width="500" src="https://github.com/sseungmn/ios-keynote/assets/46219689/26e19da9-2637-4e8f-a68f-065ee69ecc23">
    <img width="500" src="https://github.com/sseungmn/ios-keynote/assets/46219689/4c84fd7f-5816-4997-8381-a9788dd639f9">
    </details>
    - [x] 선택된 Content의 종류에 따라서, Inspector 구성목록을 변경(활성/비활성)
    <details>
    <summary>스크린샷</summary>

    * Color, Alpha 변경이 가능할 때
    <img width=500; src="https://github.com/sseungmn/ios-keynote/assets/46219689/b8a2fd7f-a2fd-4d01-946b-36bd7ba364b7">
    
    * Alpha만 변경이 가능할 때
    <img width=500; src="https://github.com/sseungmn/ios-keynote/assets/46219689/bead70dd-fd14-46fa-8572-100b08b680db">
    </details>

