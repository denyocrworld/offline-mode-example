import 'package:offline_app/module/queue_list/view/queue_list_view.dart';
import 'package:offline_app/state_util.dart';
import 'package:flutter/material.dart';
import 'package:offline_app/service/queue_service/queue_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await QueueService.reset();
  await QueueService.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QueueListView(),
    );
  }
}
