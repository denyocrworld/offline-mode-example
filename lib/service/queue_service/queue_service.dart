import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class QueueService {
  static List queues = [];

  static load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonString = prefs.getString("queues") ?? "[]";
    queues = jsonDecode(jsonString);
    await processRequest();
  }

  static save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("queues", jsonEncode(queues));
  }

  static reset() async {
    queues = [];
    await save();
  }

  static addRequest({
    required String url,
    required String method,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> data,
  }) async {
    queues.add({
      "id": const Uuid().v4(),
      "date": DateTime.now().toIso8601String(),
      "url": url,
      "method": method,
      "headers": headers,
      "data": data,
      "status": "Pending",
    });
    await save();
    await processRequest();
  }

  static processRequest() async {
    var targetQueues = queues.where((item) => item["status"] != "Success");
    try {
      for (var item in targetQueues) {
        var id = item["id"];
        var date = item["date"];
        var url = item["url"];
        var method = item["method"].toString().toLowerCase();
        var headers = item["headers"];
        var data = item["data"];
        var status = item["status"];

        try {
          if (method == "post") {
            await Dio().post(
              url,
              options: Options(
                headers: headers,
              ),
              data: data,
            );
          } else if (method == "put") {
            await Dio().put(
              url,
              options: Options(
                headers: headers,
              ),
              data: data,
            );
          } else if (method == "delete") {
            await Dio().delete(
              url,
              options: Options(
                headers: headers,
              ),
              data: data,
            );
          }

          item["status"] = "Success";
        } on Exception {
          item["status"] = "Failed";
        }
      }
      await save();
    } on Exception {
      await save();
      return;
    }
  }
}
