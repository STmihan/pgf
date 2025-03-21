import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:pgf/pgf_app.dart';
import 'package:pgf/system/events.dart';
import 'package:pgf/system/storage.dart';
import 'package:pgf/system/system_tray.dart';
import 'package:pgf/widgets/pick_gif.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(List<String> args) async {
  if (args.firstOrNull == 'multi_window') {
    pickGifWindow(args);
  } else {
    mainWindow();
  }
}

Future<void> pickGifWindow(List<String> args) async {
  final windowId = int.parse(args[1]);
  final argument =
      args[2].isEmpty ? const {} : jsonDecode(args[2]) as Map<String, dynamic>;

  runApp(
    PickGif(
      windowController: WindowController.fromWindowId(windowId),
      args: argument,
    ),
  );
}

Future<void> mainWindow() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSystemTray();
  await Window.initialize();
  runApp(const PGFApp());
  if ((await loadParameter("gif")) == null) {
    await saveParameter("gif", DefaultGif);
  }

  doWhenWindowReady(() async {
    windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(alwaysOnTop: true);
    windowManager.waitUntilReadyToShow(windowOptions, () async {});
    String positionX = await loadParameter('positionX') ?? '0';
    String positionY = await loadParameter('positionY') ?? '0';
    appWindow
      ..size = Size(400, 300)
      ..position = Offset(double.parse(positionX), double.parse(positionY))
      ..show();
  });

  DesktopMultiWindow.setMethodHandler((call, fromWindowId) async {
    if (call.method == PickGif.pickGifMethod) {
      final url = call.arguments as String;
      eventBus.fire(OnNewGifEvent(url));
    }

    return "result";
  });
}
