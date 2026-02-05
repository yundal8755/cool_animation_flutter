import 'package:flutter/material.dart';
import 'package:cool_animation_flutter/cool_animation_flutter.dart';

class ScaleBounceDemo extends StatelessWidget {
  const ScaleBounceDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ScaleBounce Demo'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 메인 원숭이 카드
            ScaleBounce(
              initialScale: 0,
              peakScale: 1.2,
              duration: const Duration(milliseconds: 600),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4E0),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Text('🐵', style: TextStyle(fontSize: 40)),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Text('💤',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blue.shade300)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '안녕하세요',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // 순차적 애니메이션 섹션
            const Text(
              '순차 애니메이션',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleBounce(
                  delay: Duration(milliseconds: 800),
                  child: _AnimatedBox(
                      color: Color(0xFFE57373), icon: Icons.favorite),
                ),
                SizedBox(width: 12),
                ScaleBounce(
                  delay: Duration(milliseconds: 1000),
                  child:
                      _AnimatedBox(color: Color(0xFF81C784), icon: Icons.star),
                ),
                SizedBox(width: 12),
                ScaleBounce(
                  delay: Duration(milliseconds: 1200),
                  child: _AnimatedBox(
                      color: Color(0xFF64B5F6), icon: Icons.thumb_up),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedBox extends StatelessWidget {
  const _AnimatedBox({required this.color, required this.icon});
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
