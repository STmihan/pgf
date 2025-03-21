import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';

class PickGif extends StatefulWidget {
  static const String pickGifMethod = "pick_gif";

  const PickGif({
    super.key,
    required this.windowController,
    required this.args,
  });

  final WindowController windowController;
  final Map? args;

  @override
  State<PickGif> createState() => _PickGifState();
}

class _PickGifState extends State<PickGif> {
  String _url = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Выбор GIF')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Выберите GIF'),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _url = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final result =
                      await DesktopMultiWindow.invokeMethod(0, PickGif.pickGifMethod, _url);
                  widget.windowController.close();
                },
                child: const Text('Choose GIF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
