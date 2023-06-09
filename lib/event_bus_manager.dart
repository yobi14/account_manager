
import 'package:event_bus/event_bus.dart';

class EventBusManager {
  EventBus _eventBus = EventBus();

  EventBusManager._privateConstructor();

  static final EventBusManager _busManager =
  EventBusManager._privateConstructor();

  factory EventBusManager() {
    return _busManager;
  }

  static EventBusManager get instance {
    return _busManager;
  }

  static EventBus get eventBus {
    return _busManager._eventBus;
  }

  static void onDestroy() {
    eventBus.destroy();
  }
}

//数值更新的事件
class ValueChangeEvent {
  final String value;
  ValueChangeEvent(this.value);
}

class Event {
  static const String addAccount = "1";//添加新账号
  static const String refreshList = "2";//刷新列表
  static const String decryptSuccess = "3"; //解密成功
  static const String onlyShowTitle = "4"; //账号列表仅显示标题
  static const String showAll = "5"; //账号列表显示所有内容
}