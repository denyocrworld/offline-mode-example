import 'dart:math';

import 'package:flutter/material.dart';
import 'package:offline_app/core.dart';

class ProductListController extends State<ProductListView>
    implements MvcController {
  static late ProductListController instance;
  late ProductListView view;

  @override
  void initState() {
    instance = this;
    getProducts();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  List products = [];
  getProducts() async {
    products = await ProductService().getProducts();
    setState(() {});
  }

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
    await getProducts();
  }
}
