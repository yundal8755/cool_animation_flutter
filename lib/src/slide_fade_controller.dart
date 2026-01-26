import 'slide_fade_animatable.dart';

/// [SlideFadeIn] 위젯을 외부에서 수동으로 제어하기 위한 컨트롤러.
///
/// [SlideFadeIn.manualTrigger]를 `true`로 설정한 뒤,
/// 원하는 시점에 [play], [reverse] 등을 호출하여 애니메이션을 제어합니다.
///
/// final controller = SlideFadeController();
///
/// SlideFadeIn(
///   controller: controller,
///   manualTrigger: true,
///   child: Text('Hello'),
/// )
///
/// 원하는 시점에 재생
/// controller.play();
class SlideFadeController {
  SlideFadeAnimatable? _state;

  /// 컨트롤러가 [SlideFadeIn] 위젯에 연결되어 있는지 여부.
  bool get isAttached => _state != null;

  /// 현재 애니메이션 진행 상태 (0.0 ~ 1.0).
  /// 연결되지 않은 경우 0.0 반환.
  double get value => _state?.animationValue ?? 0.0;

  /// 애니메이션이 현재 재생 중인지 여부.
  bool get isAnimating => _state?.isAnimating ?? false;

  /// 애니메이션이 완료(forward 끝)된 상태인지 여부.
  bool get isCompleted => _state?.isCompleted ?? false;

  /// 애니메이션이 dismissed(reverse 끝 또는 초기) 상태인지 여부.
  bool get isDismissed => _state?.isDismissed ?? true;

  /// 애니메이션을 정방향으로 재생합니다.
  ///
  /// [reset]이 `true`면 처음부터 다시 재생합니다.
  /// 연결되지 않은 상태에서 호출하면 [StateError]가 발생합니다.
  void play({bool reset = false}) {
    _assertAttached();
    _state!.play(reset: reset);
  }

  /// 애니메이션을 역방향으로 재생합니다.
  ///
  /// 연결되지 않은 상태에서 호출하면 [StateError]가 발생합니다.
  void reverse() {
    _assertAttached();
    _state!.reverse();
  }

  /// 애니메이션을 즉시 완료 상태로 설정합니다.
  void complete() {
    _assertAttached();
    _state!.complete();
  }

  /// 애니메이션을 즉시 초기 상태로 리셋합니다.
  void reset() {
    _assertAttached();
    _state!.resetAnimation();
  }

  // 연결 상태 확인 및 예외 처리
  void _assertAttached() {
    assert(
      isAttached,
      'SlideFadeController는 SlideFadeIn 위젯에 연결되지 않았습니다. '
      'SlideFadeIn 위젯에 컨트롤러를 전달하는지 확인하세요.',
    );
    if (!isAttached) {
      throw StateError(
        'SlideFadeController는 SlideFadeIn 위젯에 연결되지 않았습니다. '
        'SlideFadeIn 위젯에 컨트롤러를 전달하는지 확인하세요.',
      );
    }
  }

  /// @internal - State와 연결 (내부 사용 전용)
  void attach(SlideFadeAnimatable state) => _state = state;

  /// @internal - State와 연결 해제 (내부 사용 전용)
  void detach() => _state = null;
}
