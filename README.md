
<h1 align="center">cool_animation ✨</h1>
![](https://velog.velcdn.com/images/yun_dal/post/f24c0c78-2e4b-40bc-99db-e88316a8210b/image.gif)

[![pub package](https://img.shields.io/pub/v/cool_animation.svg)](https://pub.dev/packages/cool_animation)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/yundal8755/cool_animation/blob/main/LICENSE)

Flutter에서 멋진 애니메이션을 아주 쉽고 간결하게 적용할 수 있도록 도와주는 패키지입니다. 

<br>

## Feature
- `delay`와 `buildSequentialAnimations`를 사용하여 리스트나 그룹 요소에 순차적인 애니메이션을 쉽게 적용할 수 있습니다.
- 화면 밖에 있는 위젯이 스크롤되어 화면에 보일 때 애니메이션이 시작되도록 설정할 수 있습니다 (`triggerOnVisible`).
- 방향, 지속 시간, 곡선, 애니메이션 시작 오프셋 등을 자유롭게 조절 가능합니다.
- 활용 예시는 [예제](https://github.com/yundal8755/cool_animations/blob/main/example/example_demo.dart)를 확인해주세요
- SlideFadeIn에 대한 자세한 내용은 [기술블로그 포스팅](https://velog.io/@yun_dal/Flutter-%ED%86%A0%EC%8A%A4-%EC%8A%A4%ED%83%80%EC%9D%BC%EC%9D%98-Slide-Up-%EC%9D%B8%ED%84%B0%EB%A0%89%EC%85%98-%EB%A7%8C%EB%93%A4%EA%B8%B0)을 참고해주세요

<br>

## Install
`pubspec.yaml` 파일에 다음을 추가하세요:

```yaml
dependencies:
  cool_animation: ^0.0.1
```

<br>

## Usage
### 1️⃣ SlideFadeIn
가장 기본적인 형태로, 하단에서 위로 페이드 인되며 나타납니다.
```dart
import 'package:cool_animation/cool_animation.dart';

SlideFadeIn(
  child: Text('안녕하세요!'),
)
```

<br>

### 2️⃣ 방향 및 오프셋 커스텀
`SlideDirection`을 사용하여 8가지 방향에서 등장하게 하거나, `beginOffset`으로 정밀한 제어가 가능합니다.
```dart
SlideFadeIn(
  direction: SlideDirection.fromLeft, // 왼쪽에서 오른쪽으로 등장
  duration: Duration(milliseconds: 800),
  curve: Curves.elasticOut,
  child: MyWidget(),
)
```

<br>

### 3️⃣ 순차 애니메이션
여러 요소를 시간 차를 두고 나타나게 하고 싶을 때 `buildSequentialAnimations`를 사용하면 편리합니다.
```dart
Column(
  children: buildSequentialAnimations(
    children: [
      Text('첫 번째 항목'),
      Text('두 번째 항목'),
      Text('세 번째 항목'),
    ],
    builder: (child, delay) => SlideFadeIn(
      delay: delay,
      child: child,
    ),
  ),
)
```

<br>

## Reference
### SlideDirection
- `fromBottom`, `fromTop`, `fromLeft`, `fromRight`
- `fromBottomLeft`, `fromBottomRight`, `fromTopLeft`, `fromTopRight`
- `none` (페이드 효과만 적용)

<br>

### SlideFadeIn Properties
| 속성 | 타입 | 설명 |
| --- | --- | --- |
| `child` | `Widget` | 애니메이션을 적용할 대상 (필수) |
| `direction` | `SlideDirection` | 슬라이드 시작 방향 프리셋 |
| `beginOffset` | `Offset` | 커스텀 시작 위치 (direction보다 우선함) |
| `duration` | `Duration` | 애니메이션 재생 시간 (기본 400ms) |
| `delay` | `Duration` | 애니메이션 시작 전 지연 시간 |
| `triggerOnVisible` | `bool` | 화면에 보일 때 시작 여부 (기본 false) |

<br>

## License
This project is licensed under the MIT License - see the [LICENSE](https://www.notion.so/LICENSE) file for details.
