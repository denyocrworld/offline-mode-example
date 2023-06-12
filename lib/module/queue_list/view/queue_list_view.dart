import 'package:flutter/material.dart';
import 'package:offline_app/core.dart';

class QueueListView extends StatefulWidget {
  const QueueListView({Key? key}) : super(key: key);

  Widget build(context, QueueListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("QueueList"),
        actions: [
          IconButton(
            onPressed: () => Get.to(const ProductListView()),
            icon: const Icon(
              Icons.add_box,
              size: 24.0,
            ),
          ),
          IconButton(
            onPressed: () => controller.deleteAllRequestExample(),
            icon: const Icon(
              Icons.refresh,
              size: 24.0,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => controller.createRequestExample(),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: QueueService.queues.length,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  var item = QueueService.queues[index];
                  return Card(
                    child: ListTile(
                      leading: Text(item["method"]),
                      title: Text(item["url"]),
                      subtitle: const Text("id"),
                      trailing: Text(item["status"]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 200.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<QueueListView> createState() => QueueListController();
}
