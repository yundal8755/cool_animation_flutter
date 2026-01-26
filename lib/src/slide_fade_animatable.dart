/// SlideFade 애니메이션을 제어하기 위한 인터페이스.
///
/// [SlideFadeController]가 위젯의 상태에 접근할 때 사용합니다.
abstract interface class SlideFadeAnimatable {
  /// 현재 애니메이션 값 (0.0 ~ 1.0)
  double get animationValue;

  /// 애니메이션 진행 중 여부
  bool get isAnimating;

  /// 애니메이션 완료 상태 여부
  bool get isCompleted;

  /// 애니메이션 dismissed 상태 여부
  bool get isDismissed;

  /// 정방향 재생
  void play({bool reset = false});

  /// 역방향 재생
  void reverse();

  /// 즉시 완료 상태로
  void complete();

  /// 즉시 초기 상태로
  void resetAnimation();
}
