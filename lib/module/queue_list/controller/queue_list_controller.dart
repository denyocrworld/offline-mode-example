import 'dart:math';

import 'package:flutter/material.dart';
import 'package:offline_app/service/queue_service/queue_service.dart';
import 'package:offline_app/state_util.dart';
import '../view/queue_list_view.dart';

class QueueListController extends State<QueueListView>
    implements MvcController {
  static late QueueListController instance;
  late QueueListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  createRequestExample() async {
    await QueueService.addRequest(
      url: "https://capekngoding.com/demoapi/api/products",
      method: "post",
      headers: {
        "Content-Type": "application/json",
      },
      data: {
        "product_name": "Example ${Random().nextInt(1000)}",
        "price": 25,
      },
    );
    setState(() {});
  }

  deleteAllRequestExample() async {
    await QueueService.addRequest(
      url: "https://capekngoding.com/demoapi/api/products/action/delete-all",
      method: "delete",
      headers: {
        "Content-Type": "application/json",
      },
      data: {},
    );
    setState(() {});
  }
}
