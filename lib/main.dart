import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:pgf/pgf_app.dart';
import 'package:pgf/system/storage.dart';
import 'package:pgf/system/system_tray.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSystemTray();
  runApp(const PGFApp());

  doWhenWindowReady(() async {
    windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(alwaysOnTop: true);
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      appWindow
        ..size = Size(400, 300)
        ..position = Offset(
          double.parse(await loadParameter('positionX') ?? '0'),
          double.parse(await loadParameter('positionY') ?? '0'),
        )
        ..show();
    });
  });
}
