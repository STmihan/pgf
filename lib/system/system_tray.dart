import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';

Future<void> initSystemTray() async {
  String path = 'assets/app_icon.ico';

  final AppWindow appWindow = AppWindow();
  final SystemTray systemTray = SystemTray();

  await systemTray.initSystemTray(title: "system tray", iconPath: path);

  final Menu menu = Menu();
  await menu.buildFrom([
    MenuItemLabel(label: 'Change', onClicked: (menuItem) => onSelectGif()),
    MenuItemLabel(label: 'Show', onClicked: (menuItem) => appWindow.show()),
    MenuItemLabel(label: 'Hide', onClicked: (menuItem) => appWindow.hide()),
    MenuItemLabel(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
  ]);

  await systemTray.setContextMenu(menu);

  systemTray.registerSystemTrayEventHandler((eventName) {
    debugPrint("eventName: $eventName");
    if (eventName == kSystemTrayEventClick) {
      Platform.isWindows ? appWindow.show() : systemTray.popUpContextMenu();
    } else if (eventName == kSystemTrayEventRightClick) {
      Platform.isWindows ? systemTray.popUpContextMenu() : appWindow.show();
    }
  });
}

Future<void> onSelectGif() async {
  final window = await DesktopMultiWindow.createWindow();
  window
    ..setFrame(const Offset(0, 0) & const Size(400, 300))
    ..center()
    ..setTitle('Pick GIF')
    ..show();
}
