import 'package:flutter/services.dart';
import 'package:flutter_bmflocation/src/private/bdmap_location_method_id.dart';

class BMFLocatioAuxiliaryDispatcher {
  ///移动热点识别
  void getNetworkState(MethodChannel channel) async {
    try {
      channel.invokeMethod(
          BMFLocationAuxiliaryFuctionMethodId.kLocationNetworkState);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
