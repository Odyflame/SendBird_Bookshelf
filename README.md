# SendBird_Bookshelf
> Develop SendBird Bookshelf app

## 해당 과제를 구현하면서 주의해야 할 것들 (Sendbird에 Feedback을 요청하여 받아온 리스트들)
* 요구 사항을 얼마나 충실히 구현하였는가?
* 전체적인 구조, 모델링이 얼마나 적절한가?
* 개발하고자 하는 플랫폼에 대해서 얼마나 이해하고 있는가?
* UI는 의도한 대로 잘 동작하는가?
* 에러 상황을 얼마나 세세하게 다루는가?

------

### Architecture

MVC

------

## 코드 스타일

- Directory Configure

  - 화면 하나당 큰 폴더를 갖는다.
  - 큰 폴더 내에는 cell 폴더, ViewController 파일,  ViewModel 파일을 갖는다.

- MARK 주석

```markdown
// MARK: - describe
```

1. Properties
2. Lifecycle
3. Methods
4. Protocols

## 🕹 Func List
#### 새로운 책 가져오기
- 앱을 실행하면 [book api](https://api.itbook.store)에서 새로운 책 리스트를 불러온다.

#### 첵 검색하기
- 검색창에 키워드를 입력하면 그에 맞는 책 리스트를 뽑아서 보여준다.
- 스크롤로 끝까지 갈 때 더 많은 책 리스트를 불러온다.

#### 다크모드
- 낮과 밤의 시간대에 맞게 다크모드 지원

#### 사파리 연결
- Detail로 넘어가서, 책의 사진을 누르면 책의 정보가 담긴 사파리 창을 열어준다.

------
### 기능 시연

|![Main](https://user-images.githubusercontent.com/44191131/112639894-22774080-8e84-11eb-81b5-c52aef1c4a1a.PNG) | ![IMG_1244](https://user-images.githubusercontent.com/44191131/112639950-34f17a00-8e84-11eb-93f3-c8f1732681b4.PNG)
|----|-----|
