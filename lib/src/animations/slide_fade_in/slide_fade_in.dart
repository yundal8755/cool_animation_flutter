import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'slide_direction.dart';
import 'slide_fade_animatable.dart';
import 'slide_fade_controller.dart';

/// 슬라이드와 페이드 효과를 결합한 애니메이션 위젯.
/// 기본적으로 아래에서 위로 살짝 올라오며 페이드 인하는 효과를 제공합니다.
///
/// 기본 사용법
/// SlideFadeIn(
///   child: Text('Hello World'),
/// )
///
/// 방향 지정
/// SlideFadeIn(
///   direction: SlideDirection.fromLeft,
///   child: Text('왼쪽에서 등장'),
/// )
///
/// 스크롤 뷰나 화면 하단에 위치한 위젯에 유용합니다.
/// SlideFadeIn(
///   triggerOnVisible: true,
///   child: Text('스크롤하면 나타남'),
/// )
///
/// 여러 위젯을 순차적으로 애니메이션하려면 [delay]를 사용하세요.
/// Column(
///   children: [
///     SlideFadeIn(delay: Duration(milliseconds: 0), child: Text('첫 번째')),
///     SlideFadeIn(delay: Duration(milliseconds: 100), child: Text('두 번째')),
///     SlideFadeIn(delay: Duration(milliseconds: 200), child: Text('세 번째')),
///   ],
/// )
class SlideFadeIn extends StatefulWidget {
  const SlideFadeIn({
    super.key,
    required this.child,
    this.direction = SlideDirection.fromBottom,
    this.beginOffset,
    this.duration = const Duration(milliseconds: 400),
    this.delay,
    this.curve = Curves.easeOutCubic,
    this.triggerOnVisible = false,
    this.visibilityThreshold = 0.1,
    this.controller,
    this.enabled = true,
    this.onCompleted,
  }) : assert(
          direction != null || beginOffset != null,
          'Either direction or beginOffset must be provided',
        );

  /// 애니메이션을 적용할 자식 위젯.
  final Widget child;

  /// 슬라이드 방향 프리셋.
  ///
  /// [beginOffset]과 함께 사용할 수 없습니다.
  /// 기본값은 [SlideDirection.fromBottom] (아래에서 위로).
  final SlideDirection? direction;

  /// 커스텀 시작 위치 오프셋 (픽셀 단위).
  ///
  /// [direction]과 함께 사용할 수 없습니다.
  /// 더 세밀한 제어가 필요할 때 사용하세요.
  final Offset? beginOffset;

  /// 애니메이션 재생 시간.
  final Duration duration;

  /// 애니메이션 시작 전 지연 시간.
  ///
  /// 순차 애니메이션을 만들 때 유용합니다.
  final Duration? delay;

  /// 애니메이션 곡선.
  final Curve curve;

  /// `true`면 위젯이 화면에 보일 때 애니메이션을 시작합니다.
  ///
  /// 스크롤 뷰나 화면 하단 위젯에 유용합니다.
  /// 기본값은 `false` (즉시 시작).
  final bool triggerOnVisible;

  /// 애니메이션을 트리거할 가시성 임계값 (0.0 ~ 1.0).
  ///
  /// [triggerOnVisible]이 `true`일 때만 사용됩니다.
  /// 기본값 0.1은 위젯의 10%가 보일 때 시작합니다.
  final double visibilityThreshold;

  /// 외부 제어용 컨트롤러.
  ///
  /// 설정하면 자동 재생이 비활성화되고 수동으로 제어해야 합니다.
  final SlideFadeController? controller;

  /// `false`면 애니메이션을 비활성화하고 즉시 최종 상태로 표시합니다.
  ///
  /// 접근성 설정(Reduce Motion)이 활성화되어 있으면 자동으로 비활성화됩니다.
  final bool enabled;

  /// 애니메이션 완료 시 호출되는 콜백.
  final VoidCallback? onCompleted;

  @override
  State<SlideFadeIn> createState() => SlideFadeInState();
}

class SlideFadeInState extends State<SlideFadeIn>
    with SingleTickerProviderStateMixin
    implements SlideFadeAnimatable {
  late final AnimationController _controller;
  late Animation<double> _curvedAnimation;

  bool _didAnimateOnce = false;
  bool _isVisible = false;
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    widget.controller?.attach(this);
    _controller.addStatusListener(_handleAnimationStatus);

    _initializeAnimation();
  }

  void _initializeAnimation() {
    final shouldDisable = !widget.enabled || _isReduceMotionEnabled;

    if (shouldDisable) {
      _controller.value = 1.0;
      _didAnimateOnce = true;
    } else if (widget.controller == null && !widget.triggerOnVisible) {
      _scheduleAutoPlay();
    }
  }

  bool get _isReduceMotionEnabled {
    return SchedulerBinding
        .instance.platformDispatcher.accessibilityFeatures.reduceMotion;
  }

  @override
  void didUpdateWidget(covariant SlideFadeIn oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.detach();
      widget.controller?.attach(this);
    }

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    if (oldWidget.curve != widget.curve) {
      _curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      );
    }
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onCompleted?.call();
      _didAnimateOnce = true;
    }
  }

  Future<void> _scheduleAutoPlay() async {
    if (_didAnimateOnce) return;

    final delay = widget.delay;
    if (delay != null && delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }

    if (!mounted) return;
    play();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_didAnimateOnce || !widget.enabled || _isReduceMotionEnabled) return;

    final isNowVisible = info.visibleFraction >= widget.visibilityThreshold;

    if (isNowVisible && !_isVisible) {
      _isVisible = true;
      _scheduleAutoPlay();
    }
  }

  Offset get _effectiveBeginOffset {
    if (widget.beginOffset != null) return widget.beginOffset!;
    if (widget.direction != null) {
      return widget.direction!.toOffset(20.0); // 고정 거리
    }
    return const Offset(0, 20); // 기본값
  }

  // SlideFadeAnimatable 구현
  @override
  double get animationValue => _controller.value;

  @override
  bool get isAnimating => _controller.isAnimating;

  @override
  bool get isCompleted => _controller.isCompleted;

  @override
  bool get isDismissed => _controller.isDismissed;

  @override
  void play({bool reset = false}) {
    if (_didAnimateOnce && !reset) return;
    if (reset) _controller.value = 0.0;
    _controller.forward();
  }

  @override
  void reverse() {
    _controller.reverse();
  }

  @override
  void complete() {
    _controller.value = 1.0;
  }

  @override
  void resetAnimation() {
    _controller.value = 0.0;
    _didAnimateOnce = false;
    _isVisible = false;
  }

  @override
  void dispose() {
    widget.controller?.detach();
    _controller.removeStatusListener(_handleAnimationStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animatedChild = AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        final t = _curvedAnimation.value;
        final beginOffset = _effectiveBeginOffset;

        final dx = lerpDouble(beginOffset.dx, 0, t)!;
        final dy = lerpDouble(beginOffset.dy, 0, t)!;
        final opacity = lerpDouble(0.0, 1.0, t)!.clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(dx, dy),
          child: Opacity(opacity: opacity, child: child),
        );
      },
      child: widget.child,
    );

    if (widget.triggerOnVisible) {
      return VisibilityDetector(
        key: _visibilityKey,
        onVisibilityChanged: _onVisibilityChanged,
        child: animatedChild,
      );
    }

    return animatedChild;
  }
}
