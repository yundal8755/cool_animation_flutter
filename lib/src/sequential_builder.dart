import 'package:flutter/material.dart';

/// 순차 애니메이션을 위한 헬퍼 함수.
///
/// 여러 위젯에 자동으로 지연 시간을 적용하여 순차적인 애니메이션 효과를 만듭니다.
///
/// 기본 사용법
/// Column(
///   children: buildSequentialAnimations(
///     children: [
///       Text('첫 번째'),
///       SizedBox(height: 12),  // 자동으로 스킵됨
///       Text('두 번째'),
///       Text('세 번째'),
///     ],
///     builder: (child, delay) => SlideFadeIn(
///       delay: delay,
///       child: child,
///     ),
///   ),
/// )
List<Widget> buildSequentialAnimations({
  required List<Widget> children,
  required Widget Function(Widget child, Duration delay) builder,
  Duration interval = const Duration(milliseconds: 80),
  Duration initialDelay = Duration.zero,
  bool skipSpacers = true,
}) {
  final result = <Widget>[];
  int animationIndex = 0;

  for (final child in children) {
    if (skipSpacers && _isSpacerWidget(child)) {
      result.add(child);
    } else {
      final delay = Duration(
        microseconds: initialDelay.inMicroseconds +
            (interval.inMicroseconds * animationIndex),
      );
      result.add(builder(child, delay));
      animationIndex++;
    }
  }

  return result;
}

/// 위젯이 공백 위젯인지 판별합니다.
bool _isSpacerWidget(Widget widget) {
  return widget is SizedBox ||
      widget is Spacer ||
      widget is Divider ||
      widget is VerticalDivider;
}
