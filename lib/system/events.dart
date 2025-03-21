import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class OnNewGifEvent {
  final String url;
  OnNewGifEvent(this.url);
}
