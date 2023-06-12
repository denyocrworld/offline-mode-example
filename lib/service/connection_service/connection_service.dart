import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  isOffline() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      try {
        await Dio().get(
          "https://reqres.in/api/users",
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ),
        );
        return false;
      } on Exception {
        return true;
      }
    }
    return true;
  }
}
