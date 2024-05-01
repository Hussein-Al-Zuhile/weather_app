import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@singleton
class ConnectionManager {
  List<ConnectivityResult>? currentConnectivityState;

  ConnectionManager() {
    Connectivity().onConnectivityChanged.listen((event) {
      currentConnectivityState = event;
    });
  }

  Future<bool> isInternetAvailable() async {
    // if (currentConnectivityState == null) return false;
    //
    // if (!currentConnectivityState!.any((element) {
    //   return element == ConnectivityResult.wifi ||
    //       element == ConnectivityResult.mobile ||
    //       element == ConnectivityResult.ethernet ||
    //       element == ConnectivityResult.vpn;
    // })) {
    //   return false;
    // } else {
      return InternetConnectionChecker().hasConnection;
    // }
  }
}
