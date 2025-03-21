import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:pgf/system/events.dart';
import 'package:pgf/system/storage.dart';
import 'package:window_manager/window_manager.dart';

import 'widgets/main_window.dart';


class PGFApp extends StatefulWidget {
  const PGFApp({super.key});

  @override
  State<PGFApp> createState() => _PGFAppState();
}

class _PGFAppState extends State<PGFApp> with WindowListener {

  String _url = '';

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    Window.makeWindowFullyTransparent();
    Window.enableFullSizeContentView();
    Window.hideTitle();
    Window.hideWindowControls();

    loadParameter('gif').then((value) {
      setState(() {
        _url = value ?? DefaultGif;
      });
    });

    eventBus.on<OnNewGifEvent>().listen((event) {
      saveParameter('gif', event.url);
      setState(() {
        _url = event.url;
      });
    });
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
        body: MainWindow(
            url: _url,
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
}
