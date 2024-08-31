import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:velveta_app/core/enums/connectivityStatus.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:get/get.dart';

class MyAppController extends GetxController {
  @override
  Connectivity connectivity = Connectivity();
  RxBool online = false.obs;
  void onInit() async {
    checkConnection();
    super.onInit();
  }

  void checkConnection() async {
    ConnectivityStatus status =
        connectivitySerivce.getStatus(await connectivity.checkConnectivity());

    connectivitySerivce.connectivityStatusController.add(status);
    isOnline = online.value = status == ConnectivityStatus.ONLINE;

    connectivitySerivce.connectivityStatusController.stream.listen((event) {
      isOnline = online.value = event == ConnectivityStatus.ONLINE;
    });
  }
}
