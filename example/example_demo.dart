import 'package:flutter/material.dart';
import 'package:cool_animation_flutter/cool_animation_flutter.dart';

class ExampleDemo extends StatelessWidget {
  const ExampleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 설명 텍스트
              SlideFadeIn(
                delay: const Duration(microseconds: 1000),
                duration: const Duration(milliseconds: 1000),
                beginOffset: const Offset(0, 50),
                child: Text(
                  '오늘 이루고 싶은 것을 생각하며',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 18,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // 강조 텍스트
              const SlideFadeIn(
                delay: Duration(milliseconds: 1000),
                duration: Duration(milliseconds: 1000),
                beginOffset: Offset(0, 50),
                child: Text(
                  '궁금한 운세를 눌러주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 개별 운세 카드 표시
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SlideFadeIn(
                    delay: Duration(milliseconds: 2000),
                    duration: Duration(milliseconds: 1000),
                    beginOffset: Offset(0, 50),
                    child: _FortuneCard(
                      icon: Icons.diamond,
                      label: '재물운',
                      color: Color(0xFF5B7FE8),
                    ),
                  ),
                  SlideFadeIn(
                    delay: Duration(milliseconds: 2000),
                    duration: Duration(milliseconds: 1000),
                    beginOffset: Offset(0, 50),
                    child: _FortuneCard(
                      icon: Icons.local_florist,
                      label: '생명운',
                      color: Color(0xFF4ECDC4),
                    ),
                  ),
                  SlideFadeIn(
                    delay: Duration(milliseconds: 2000),
                    duration: Duration(milliseconds: 1000),
                    beginOffset: Offset(0, 50),
                    child: _FortuneCard(
                      icon: Icons.favorite,
                      label: '애정운',
                      color: Color(0xFFFF6B9D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// 개별 운세 카드 위젯
///
class _FortuneCard extends StatelessWidget {
  const _FortuneCard({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF3A3A3A),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 아이콘
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),

          // 라벨
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
