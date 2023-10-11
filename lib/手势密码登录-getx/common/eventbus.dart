import 'package:event_bus/event_bus.dart';

// 创建一个事件总线
EventBus eventBusG=EventBus();

class EventSuccessSetPwd{
  bool success;
  EventSuccessSetPwd(this.success){
  }
}

class EventSetPwd{
  EventSetPwd(){}
}
