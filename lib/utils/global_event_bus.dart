import 'dart:developer';

import 'package:event_bus/event_bus.dart';

class GlobalEventBus {
  EventBus? eventBus;
  factory GlobalEventBus() => _getInstance();

  static GlobalEventBus? _instance;

  static GlobalEventBus get instance => _getInstance();

  GlobalEventBus._internal() {
    log("internal Called");
    eventBus = EventBus();
  }

  static GlobalEventBus _getInstance() {
    return _instance ?? GlobalEventBus._internal();
  }
}

final EventBus mainEventBus = GlobalEventBus().eventBus!;
