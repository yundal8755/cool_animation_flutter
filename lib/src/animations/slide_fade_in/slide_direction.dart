import 'package:flutter/material.dart';

/// 자주 사용하는 슬라이드 방향 프리셋.
///
/// SlideFadeIn(
///   direction: SlideDirection.fromBottom,
///   child: Text('Hello'),
/// )
enum SlideDirection {
  /// 아래에서 위로 (기본값)
  fromBottom(Offset(0, 1)),

  /// 위에서 아래로
  fromTop(Offset(0, -1)),

  /// 왼쪽에서 오른쪽으로
  fromLeft(Offset(-1, 0)),

  /// 오른쪽에서 왼쪽으로
  fromRight(Offset(1, 0)),

  /// 왼쪽 아래에서
  fromBottomLeft(Offset(-1, 1)),

  /// 오른쪽 아래에서
  fromBottomRight(Offset(1, 1)),

  /// 왼쪽 위에서
  fromTopLeft(Offset(-1, -1)),

  /// 오른쪽 위에서
  fromTopRight(Offset(1, -1)),

  /// 움직임 없이 페이드만
  none(Offset.zero);

  const SlideDirection(this.unitVector);

  /// 방향의 단위 벡터 (정규화된 방향)
  final Offset unitVector;

  /// 주어진 거리(픽셀)만큼의 오프셋 계산
  Offset toOffset(double distance) {
    return Offset(
      unitVector.dx * distance,
      unitVector.dy * distance,
    );
  }

  /// 위젯 크기 대비 비율로 오프셋 계산
  ///
  /// [fraction]: 0.0 ~ 1.0 (위젯 크기의 비율)
  /// [size]: 위젯의 크기
  Offset toFractionalOffset(double fraction, Size size) {
    final distance =
        unitVector.dx != 0 ? size.width * fraction : size.height * fraction;
    return toOffset(distance.abs());
  }
}

/// 오프셋 계산 헬퍼 확장
extension SlideOffsetExtension on Offset {
  static Offset pixels(double dx, double dy) => Offset(dx, dy);

  static Offset fromDirection(SlideDirection direction, double distance) {
    return direction.toOffset(distance);
  }
}
