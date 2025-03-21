import 'package:flutter/material.dart';
import 'package:pgf/system/events.dart';
import 'package:system_tray/system_tray.dart';

Future<void> initSystemTray() async {
  String path = 'assets/app_icon.ico';

  final AppWindow appWindow = AppWindow();
  final SystemTray systemTray = SystemTray();

  await systemTray.initSystemTray(title: "system tray", iconPath: path);

  final Menu menu = Menu();
  await menu.buildFrom([
    MenuItemLabel(label: 'Change', onClicked: (menuItem) => eventBus.fire(OnOpenGifPickerEvent())),
    MenuItemLabel(label: 'Show', onClicked: (menuItem) => appWindow.show()),
    MenuItemLabel(label: 'Hide', onClicked: (menuItem) => appWindow.hide()),
    MenuItemLabel(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
  ]);

  await systemTray.setContextMenu(menu);

  systemTray.registerSystemTrayEventHandler((eventName) {
    debugPrint("eventName: $eventName");
    if (eventName == kSystemTrayEventClick) {
      appWindow.show();
    } else if (eventName == kSystemTrayEventRightClick) {
      systemTray.popUpContextMenu();
    }
  });
}
