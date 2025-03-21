import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:pgf/system/events.dart';
import 'package:pgf/system/storage.dart';
import 'package:pgf/widgets/pick_gif.dart';
import 'package:window_manager/window_manager.dart';

import 'widgets/main_window.dart';

class PGFApp extends StatefulWidget {
  const PGFApp({super.key});

  @override
  State<PGFApp> createState() => _PGFAppState();
}

class _PGFAppState extends State<PGFApp> with WindowListener {
  String _url = '';
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);

    loadParameter('gif').then((value) {
      setState(() {
        if (value == null) {
          _url = DefaultGif;
          saveParameter('gif', DefaultGif);
        } else {
          _url = value;
        }
      });
    });

    eventBus.on<OnNewGifEvent>().listen((event) => onNewGif(event.url));
    eventBus.on<OnOpenGifPickerEvent>().listen((event) => onOpenGifPicker());
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: WindowBorder(
          color: Colors.black12,
          width: 1,
          child: MoveWindow(
            onDoubleTap: () {},
            child: Stack(
              children: [
                MainWindow(url: _url),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: _showOverlay ? 0 : -450,
                  left: 0,
                  right: 0,
                  child: PickGif(onPickGif: onNewGif),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onWindowMove() {
    windowManager.getPosition().then((value) {
      saveParameter('positionX', value.dx.toString());
      saveParameter('positionY', value.dy.toString());
    });
  }

  void onNewGif(String url) {
    saveParameter('gif', url);
    setState(() {
      if (url.trim().isNotEmpty) {
        _url = url;
      }
      _showOverlay = false;
    });
  }

  void onOpenGifPicker() {
    windowManager.focus();
    setState(() {
      _showOverlay = true;
    });
  }
}
