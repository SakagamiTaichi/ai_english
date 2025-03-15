import 'package:flutter/material.dart';

Widget TestCard({
  Key? key,
  required BuildContext context,
  required bool isQuize,
  required String text,
}) {
  return Card(
    color: isQuize
        ? Theme.of(context).cardTheme.color
        : Theme.of(context).colorScheme.primaryContainer,
    elevation: 2,
    child: Container(
      height: isQuize ? 130 : 103, // カードの高さを固定
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8), // 上部にも余白を追加
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white, // 中央部分は完全不透明
                      Colors.white, // 中央部分は完全不透明
                      Colors.white.withAlpha(120) // 下部半透明
                    ],
                    stops: [0.0, 0.8, 1.0], // 上部20%と下部20%でフェード
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text,
                          style: isQuize
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8), // 下部にも余白を追加
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
