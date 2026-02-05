import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:visibility_detector/visibility_detector.dart';

///
/// 크기가 커지면서 투명도가 증가하고 정점에서 바운스되는 애니메이션 위젯.
///
class ScaleBounce extends StatefulWidget {
  const ScaleBounce({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay,
    this.initialScale = 0.3,
    this.peakScale = 1.15,
    this.triggerOnVisible = false,
    this.visibilityThreshold = 0.1,
    this.enabled = true,
    this.onCompleted,
  })  : assert(initialScale >= 0.0 && initialScale <= 1.0),
        assert(peakScale >= 1.0);

  final Widget child;

  /// 애니메이션 지속 시간 (기본 600ms)
  final Duration duration;

  /// 애니메이션 시작 전 지연 시간
  final Duration? delay;

  /// 시작 시 스케일 (0.0 ~ 1.0)
  final double initialScale;

  /// 정점에서의 최대 스케일 (최종 크기는 1.0으로 수렴)
  final double peakScale;

  /// 화면에 보일 때 애니메이션을 트리거할지 여부
  final bool triggerOnVisible;

  /// 애니메이션을 트리거할 가시성 비율 (0.0 ~ 1.0)
  final double visibilityThreshold;

  /// 애니메이션 활성화 여부 (Reduce Motion 설정 시 자동 비활성화)
  final bool enabled;

  final VoidCallback? onCompleted;

  @override
  State<ScaleBounce> createState() => _ScaleBounceState();
}

class _ScaleBounceState extends State<ScaleBounce>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  bool _didAnimateOnce = false;
  bool _isVisible = false;
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _setupAnimations();
    _controller.addStatusListener(_handleAnimationStatus);
    _initializeAnimation();
  }

  /// 애니메이션 설정ㅣ
  void _setupAnimations() {
    // 스케일 애니메이션
    // 60% 시간은 커지고, 40% 시간은 다시 줄어들며 바운스 효과 구현
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: widget.initialScale, end: widget.peakScale)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.peakScale, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 40,
      ),
    ]).animate(_controller);

    // 투명도 애니메이션
    // 70% 시간 동안 투명도 증가
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
  }

  /// 애니메이션 초기화
  void _initializeAnimation() {
    final shouldDisable = !widget.enabled || _isReduceMotionEnabled;

    if (shouldDisable) {
      _controller.value = 1.0;
      _didAnimateOnce = true;
    } else if (!widget.triggerOnVisible) {
      _scheduleAutoPlay();
    }
  }

  bool get _isReduceMotionEnabled => SchedulerBinding
      .instance.platformDispatcher.accessibilityFeatures.reduceMotion;

  @override
  void didUpdateWidget(covariant ScaleBounce oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.initialScale != widget.initialScale ||
        oldWidget.peakScale != widget.peakScale) {
      _setupAnimations();
    }
  }

  /// 애니메이션 상태 변경 처리
  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onCompleted?.call();
      _didAnimateOnce = true;
    }
  }

  /// 자동 재생 스케줄링
  Future<void> _scheduleAutoPlay() async {
    if (_didAnimateOnce) return;
    if (widget.delay != null && widget.delay! > Duration.zero) {
      await Future<void>.delayed(widget.delay!);
    }
    if (!mounted) return;
    _controller.forward();
  }

  /// 가시성 변경 처리
  void _onVisibilityChanged(VisibilityInfo info) {
    if (_didAnimateOnce || !widget.enabled || _isReduceMotionEnabled) return;

    final isNowVisible = info.visibleFraction >= widget.visibilityThreshold;
    if (isNowVisible && !_isVisible) {
      _isVisible = true;
      _scheduleAutoPlay();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animatedChild = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value.clamp(0.0, 1.0),
            child: child,
          ),
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
