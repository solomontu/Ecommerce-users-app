import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final internetSream = StateNotifierProvider.autoDispose<Network, bool>(
    (ref) => Network.initialize());

class Network extends StateNotifier<bool> {
  var conner = Connectivity();
  Network.initialize() : super(true) {
    try {
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          state = false;
        } else {
          state = true;
        }
      });
    } on Exception catch (e) {
      print(e.toString);
    }
  }

  // Future<bool> network() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     return false;
  //   } else {
  //     return false;
  //   }
  // }

  // networkState() {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.none) {
  //       state = false;
  //     } else if (result == ConnectivityResult.mobile) {
  //       state = true;
  //     } else {
  //       state = true;
  //     }
  //   });
  // }
}
