import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class MainWindow extends StatelessWidget {
  const MainWindow({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Image.network(
          url,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const CircularProgressIndicator();
          },
          errorBuilder:
              (context, error, stackTrace) => const Text('Ошибка загрузки GIF'),
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
