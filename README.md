
<div id="top"></div>

<h1 align="center">cool_animation_flutter ✨</h1>
<p align="center">
  <img src="https://github.com/user-attachments/assets/562364d8-5256-43a8-8552-a4962dd8ccb8" width="60%" />
</p>

<div align="center">

[🇺🇸 English](#english) | [🇰🇷 한국어](#korean)

</div>

<br>

<div id="english"></div>

## 🇺🇸 English

A package that helps you apply cool animations in Flutter very easily and concisely.
You don't need to create complex `AnimationController` and `StatefulWidget` every time; just wrap your widget to implement smooth and natural interactions.
From simple appearance effects to advanced sequential list animations, create **the coolest UX with the least code**.

<br>

### Feature
- Easily apply sequential animations to lists or group elements using `delay` and `buildSequentialAnimations`.
- Configure animations to start when the widget scrolled into view (`triggerOnVisible`).
- Freely adjust direction, duration, curve, animation start offset, etc.
- Check the [example](https://github.com/yundal8755/cool_animation_flutter/blob/main/example/lib/main.dart) for usage.
- For more details on SlideFadeIn, refer to the [tech blog post](https://velog.io/@yun_dal/Flutter-%ED%86%A0%EC%8A%A4-%EC%8A%A4%ED%83%80%EC%9D%BC%EC%9D%98-Slide-Up-%EC%9D%B8%ED%84%B0%EB%A0%89%EC%85%98-%EB%A7%8C%EB%93%A4%EA%B8%B0).

<br>

### Install
Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  cool_animation_flutter: ^0.0.2
```

<br>

### Usage
#### 1️⃣ Use SlideFadeIn
The most basic form, appearing from bottom to top with a fade-in.
```dart
import 'package:cool_animation_flutter/cool_animation_flutter.dart';

SlideFadeIn(
  child: Text('Hello!'),
)
```

<br>

#### 2️⃣ Custom Direction & Offset
Use `SlideDirection` to appear from 8 different directions, or use `beginOffset` for precise control.
```dart
SlideFadeIn(
  direction: SlideDirection.fromLeft, // Appears from left to right
  duration: Duration(milliseconds: 800),
  curve: Curves.elasticOut,
  child: MyWidget(),
)
```

<br>

#### 3️⃣ Sequential Animation
Use `buildSequentialAnimations` when you want multiple elements to appear with a time difference.
```dart
Column(
  children: buildSequentialAnimations(
    children: [
      Text('First Item'),
      Text('Second Item'),
      Text('Third Item'),
    ],
    builder: (child, delay) => SlideFadeIn(
      delay: delay,
      child: child,
    ),
  ),
)
```

<br>

### Reference
#### SlideDirection
- `fromBottom`, `fromTop`, `fromLeft`, `fromRight`
- `fromBottomLeft`, `fromBottomRight`, `fromTopLeft`, `fromTopRight`
- `none` (Fade effect only)

<br>

#### SlideFadeIn Properties
| Property | Type | Description |
| --- | --- | --- |
| `child` | `Widget` | Target widget for animation (Required) |
| `direction` | `SlideDirection` | Slide start direction preset |
| `beginOffset` | `Offset` | Custom start position (Prioritized over direction) |
| `duration` | `Duration` | Animation duration (Default: 400ms) |
| `delay` | `Duration` | Delay before animation starts |
| `triggerOnVisible` | `bool` | Whether to start when visible on screen (Default: false) |

<br>

---
<br>

<div id="korean"></div>

## 🇰🇷 한국어

Flutter에서 멋진 애니메이션을 아주 쉽고 간결하게 적용할 수 있도록 도와주는 패키지입니다. 
복잡한 `AnimationController`와 `StatefulWidget`을 매번 만들 필요 없이, 위젯을 감싸는 것만으로 부드럽고 자연스러운 인터랙션을 구현할 수 있습니다.
단순한 등장 효과부터 리스트가 순차적으로 올라오는 고급 연출까지, **가장 적은 코드로 가장 멋진 UX**를 만들어보세요.

<br>

### Feature
- `delay`와 `buildSequentialAnimations`를 사용하여 리스트나 그룹 요소에 순차적인 애니메이션을 쉽게 적용할 수 있습니다.
- 화면 밖에 있는 위젯이 스크롤되어 화면에 보일 때 애니메이션이 시작되도록 설정할 수 있습니다 (`triggerOnVisible`).
- 방향, 지속 시간, 곡선, 애니메이션 시작 오프셋 등을 자유롭게 조절 가능합니다.
- 활용 예시는 [예제](https://github.com/yundal8755/cool_animation_flutter/blob/main/example/lib/main.dart)를 확인해주세요
- SlideFadeIn에 대한 자세한 내용은 [기술블로그 포스팅](https://velog.io/@yun_dal/Flutter-%ED%86%A0%EC%8A%A4-%EC%8A%A4%ED%83%80%EC%9D%BC%EC%9D%98-Slide-Up-%EC%9D%B8%ED%84%B0%EB%A0%89%EC%85%98-%EB%A7%8C%EB%93%A4%EA%B8%B0)을 참고해주세요

<br>

### Install
`pubspec.yaml` 파일에 다음을 추가하세요:

```yaml
dependencies:
  cool_animation_flutter: ^0.0.2
```

<br>

### Usage
#### 1️⃣ SlideFadeIn
가장 기본적인 형태로, 하단에서 위로 페이드 인되며 나타납니다.
```dart
import 'package:cool_animation_flutter/cool_animation_flutter.dart';

SlideFadeIn(
  child: Text('안녕하세요!'),
)
```

<br>

#### 2️⃣ 방향 및 오프셋 커스텀
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

#### 3️⃣ 순차 애니메이션
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

### Reference
#### SlideDirection
- `fromBottom`, `fromTop`, `fromLeft`, `fromRight`
- `fromBottomLeft`, `fromBottomRight`, `fromTopLeft`, `fromTopRight`
- `none` (페이드 효과만 적용)

<br>

#### SlideFadeIn Properties
| 속성 | 타입 | 설명 |
| --- | --- | --- |
| `child` | `Widget` | 애니메이션을 적용할 대상 (필수) |
| `direction` | `SlideDirection` | 슬라이드 시작 방향 프리셋 |
| `beginOffset` | `Offset` | 커스텀 시작 위치 (direction보다 우선함) |
| `duration` | `Duration` | 애니메이션 재생 시간 (기본 400ms) |
| `delay` | `Duration` | 애니메이션 시작 전 지연 시간 |
| `triggerOnVisible` | `bool` | 화면에 보일 때 시작 여부 (기본 false) |

<br>

<div align="right">

[⬆️ 위로 이동](#top)

</div>
