import 'package:flutter/material.dart';
import 'package:cool_animation_flutter/cool_animation_flutter.dart';

class SlideFadeInDemo extends StatelessWidget {
  const SlideFadeInDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SlideFadeIn Demo'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 단독 위젯 - 방향 설정 (아래에서 위로)
            SlideFadeIn(
              direction: SlideDirection.fromBottom,
              beginOffset: Offset(0, 40),
              duration: Duration(milliseconds: 1000),
              child: _HeroCard(
                emoji: '🚀',
                text: '안녕하세요',
              ),
            ),

            SizedBox(height: 60),

            // 순차적 애니메이션 섹션
            Text(
              '순차 슬라이드 애니메이션',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideFadeIn(
                  direction: SlideDirection.fromLeft,
                  delay: Duration(milliseconds: 1200),
                  child: _ActionBox(
                      color: Color(0xFFFFCC80), icon: Icons.notifications),
                ),
                SizedBox(width: 12),
                SlideFadeIn(
                  direction: SlideDirection.fromBottom,
                  delay: Duration(milliseconds: 1400),
                  child: _ActionBox(
                      color: Color(0xFFA5D6A7), icon: Icons.check_circle),
                ),
                SizedBox(width: 12),
                SlideFadeIn(
                  direction: SlideDirection.fromRight,
                  delay: Duration(milliseconds: 1600),
                  child: _ActionBox(color: Color(0xFF9FA8DA), icon: Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Hero 카드
class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.emoji, required this.text});
  final String emoji;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 40)),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3F51B5),
          ),
        ),
      ],
    );
  }
}

/// 액션 박스
class _ActionBox extends StatelessWidget {
  const _ActionBox({required this.color, required this.icon});
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
