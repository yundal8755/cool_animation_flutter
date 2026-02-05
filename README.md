<div id="top"></div>

<h1 align="center">cool_animation_flutter ✨</h1>

<table align="center">
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8a14ccaf-de25-4781-b35e-c6c26ba53a51" width="240" alt="SlideFadeIn Animation" />
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/150fdb96-62c0-4434-a472-b5ad76983a8d" width="240" alt="ScaleBounce Animation" />
    </td>
  </tr>
</table>


<div align="center">

[🇺🇸 English](#english) | [🇰🇷 한국어](#korean)

</div>

<br>

<div id="english"></div>

## 🇺🇸 English

A Flutter package that helps you apply cool animations very easily and concisely.
No more complex `AnimationController` and `StatefulWidget` setups; just wrap your widgets to implement smooth and natural interactions.
From simple appearance effects to advanced sequential list animations, create **the coolest UX with the least code**.

<br>

### ✨ Key Features
- **Effortless Implementation**: Smooth animations with just a few lines of code.
- **Scroll-Triggered**: Automatically start animations when widgets enter the viewport (`triggerOnVisible`).
- **Sequential Animations**: Easily create staggered entry effects for lists or groups.
- **Highly Customizable**: Fine-tune duration, delay, curves, and offsets.
- **🚀 Expanding Library**: **More than 10+ cool interactions will be added soon.**

<br>

### 📦 Installation
Add this to your `pubspec.yaml`:
```yaml
dependencies:
  cool_animation_flutter: ^0.0.3
```

<br>

### 🎬 Animation

#### 1️⃣ SlideFadeIn
Smoothly slides and fades in from any direction. Perfect for page transitions or list items.
```dart
SlideFadeIn(
  direction: SlideDirection.fromBottom,
  duration: Duration(milliseconds: 600),
  child: MyCard(),
)
```

#### 2️⃣ ScaleBounce
Scale up animation with an elastic bounce effect. Great for highlighting buttons or success icons.
```dart
ScaleBounce(
  initialScale: 0.5,
  peakScale: 1.2,
  duration: Duration(milliseconds: 800),
  child: SuccessIcon(),
)
```

<br>

### 🔗 Utilities
#### Sequential Animations (Staggered Animation)
Create staggered entries without manual calculations.
```dart
Column(
  children: buildSequentialAnimations(
    children: [Item1, Item2, Item3],
    builder: (child, delay) => SlideFadeIn(delay: delay, child: child),
  ),
)
```

<br>

### 🛠 Reference
#### SlideDirection (for SlideFadeIn)
- `fromBottom`, `fromTop`, `fromLeft`, `fromRight` (+ Diagonals)
- `none` (Fade only)

<br>

---
<br>

<div id="korean"></div>

## 🇰🇷 한국어

Flutter에서 멋진 애니메이션을 아주 쉽고 간결하게 적용할 수 있도록 도와주는 패키지입니다. 
복잡한 `AnimationController`와 `StatefulWidget`을 매번 만들 필요 없이, 위젯을 감싸는 것만으로 부드럽고 자연스러운 인터랙션을 구현할 수 있습니다.
단순한 등장 효과부터 리스트가 순차적으로 올라오는 고급 연출까지, **가장 적은 코드로 가장 멋진 UX**를 만들어보세요.

<br>

### ✨ 주요 기능
- **간편한 구현**: 단 몇 줄의 코드로 구현되는 부드러운 애니메이션.
- **스크롤 트리거**: 위젯이 화면에 들어올 때 자동으로 재생 (`triggerOnVisible`).
- **순차 애니메이션**: 리스트나 그룹 요소들이 시간 차를 두고 나타나는 효과를 쉽게 구현.
- **높은 커스텀성**: 지속 시간, 지연 시간, 곡선(Curve), 오프셋 등을 자유롭게 조절.
- **🚀 라이브러리 확장**: **곧 10개 이상의 멋진 인터랙션이 추가될 예정입니다.**

<br>

### 📦 설치 방법
`pubspec.yaml` 파일에 다음을 추가하세요:
```yaml
dependencies:
  cool_animation_flutter: ^0.0.3
```

<br>

### 🎬 애니메이션

#### 1️⃣ SlideFadeIn
어떤 방향에서든 부드럽게 미끄러지며 등장합니다. 페이지 전환이나 리스트 항목 등장에 적합합니다.
```dart
SlideFadeIn(
  direction: SlideDirection.fromBottom,
  duration: Duration(milliseconds: 600),
  child: MyCard(),
)
```

#### 2️⃣ ScaleBounce
바운스 효과와 함께 크기가 커지며 등장합니다. 버튼이나 성공 아이콘 등을 강조할 때 좋습니다.
```dart
ScaleBounce(
  initialScale: 0.5,
  peakScale: 1.2,
  duration: Duration(milliseconds: 800),
  child: SuccessIcon(),
)
```

<br>

### 🔗 유틸리티
#### 순차 애니메이션 (Staggered Animation)
수동 계산 없이 요소들을 순차적으로 등장시킬 수 있습니다.
```dart
Column(
  children: buildSequentialAnimations(
    children: [항목1, 항목2, 항목3],
    builder: (child, delay) => SlideFadeIn(delay: delay, child: child),
  ),
)
```

<br>

### 🛠 레퍼런스
#### SlideDirection (SlideFadeIn 전용)
- `fromBottom`, `fromTop`, `fromLeft`, `fromRight` (+ 대각선 방향)
- `none` (페이드 효과만 적용)

<br>

<div align="right">

[⬆️ 위로 이동](#top)

</div>
