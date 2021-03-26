# SendBird_Bookshelf
Develop SendBird Bookshelf app

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

------
### 기능 시연

|![Main](https://user-images.githubusercontent.com/44191131/112639894-22774080-8e84-11eb-81b5-c52aef1c4a1a.PNG) | ![IMG_1244](https://user-images.githubusercontent.com/44191131/112639950-34f17a00-8e84-11eb-93f3-c8f1732681b4.PNG)
|----|-----|
