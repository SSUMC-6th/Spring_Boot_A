# :leaves: Spring_Boot A
SSUMC 6기 Spring Boot 스터디 A조

## 💻 Member
| 김강연 | 강승민 | 최수빈 | 김혜령 |
| :---------:|:----------:|:----------:|:----------:|
| 이단 | 우아 | 바니 | 베이 |
| [bflykky](https://github.com/bflykky) | [SoulTree-Lovers](https://github.com/SoulTree-Lovers) | [suuu0719](https://github.com/suuu0719) | [h-ye-ryoung](https://github.com/h-ye-ryoung) |

## 📁 디렉토리 구조
```bash
├─.github
│  └─PULL_REQUEST_TEMPLATE
├─.idea
├─docs
│  └─chapter1
            Ch01Keyword.md
            Ch01Keyword.txt
└─src
    ├─mission
    │  └─chapter1
    └─practice
        └─chapter1
``` 

## 🌳 branch 규칙
```bash
├─main
    ├─wendy/main
    │  └─wendy/#1
``` 

1. `닉네임/main 브랜치`가 기본 브랜치로 pr 보낼 때 root 브랜치(main 브랜치)가 아닌 닉네임/main 브랜치로 올립니다.
2. 매주 워크북, 실습, 그리고 미션은 각자의 닉네임/main 브랜치를 base 브랜치로 삼아 `닉네임/이슈번호 브랜치`를 생성하여 관련 파일을 업로드합니다.
3. 모든 팀원들의 approve를 받으면, pr을 머지하고 해당 pr을 생성한 브랜치(닉네임/이슈번호 브랜치)는 삭제합니다.

## 🔖 커밋 컨벤션
| Message  | 설명                                              |
| :------: | :------------------------------------------------ |
|   feat   | 새로운 기능 추가                                  |
|   init   | 프로젝트 시작, 초기화                             |
|   fix    | 버그 수정                                         |
|   docs   | 문서 수정                                         |
|  style   | 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우 |
| refactor | 코드 리팩토링                                     |
|   test   | 테스트 코드                                       |
|  chore   | 빌드 업무 수정, 패키지 매니저 수정                |
