import 'package:chpl_task/productModel.dart';
import 'package:chpl_task/productWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:retrofit/retrofit.dart';

import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Dio dio = Dio();
  ApiService? apiService;

  @override
  void initState() {
    apiService = ApiService(dio);
    getProducList();
    super.initState();
  }

  ProductList? model;
  ProductList? mainModel;
  getProducList() async {
    if (mainModel == null) {
      var response = await apiService?.getData();
      if (response != null) {
        mainModel = ProductList.fromJson(response);
        model = mainModel;
      }
    }
    setState(() {});
  }

  int totalPrice = 0, productCount = 0;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (controller.text.isEmpty) {
      model = mainModel;
    }
    if (model == null) {
      return const MaterialApp(
          home: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ));
    } else {
      return MaterialApp(
        home: Scaffold(
            body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onEditingComplete: () {},
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        model = ProductList();
                        model?.product = [];
                        for (var element in mainModel!.product!) {
                          if (element.prdName!.contains(value)) {
                            model!.product!.add(element);
                          }
                        }
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      prefixIcon:
                          Icon(Icons.search), // Add search icon as prefix
                      border: OutlineInputBorder(), // Optional border style
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: model!.product!.isNotEmpty
                          ? model!.product!
                              .map((item) => ProductWidget(
                                    buyCount: item.buyCount,
                                    name: item.prdName!,
                                    onTapAdd: (price, productId) {
                                      debugPrint("asidshd$productId");
                                      totalPrice = totalPrice + price;
                                      productCount++;

                                      for (int i = 0;
                                          i < model!.product!.length;
                                          i++) {
                                        if (model!.product![i].prdId ==
                                            productId) {
                                          debugPrint("asidshd");
                                          model!.product![i].buyCount++;
                                        }
                                      }

                                      setState(() {});
                                    },
                                    onTapSub: (price, productId) {
                                      totalPrice = totalPrice + price;
                                      productCount--;
                                      for (int i = 0;
                                          i < model!.product!.length;
                                          i++) {
                                        if (model!.product![i].prdId ==
                                            productId) {
                                          model!.product![i].buyCount--;
                                        }
                                      }
                                      setState(() {});
                                    },
                                    price: item.rate.toString(),
                                    url: item.prdImage!,
                                    productId: item.prdId.toString(),
                                  ))
                              .toList()
                              .cast<Widget>()
                          : [Container()],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.lightGreenAccent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 20, right: 20),
                        child: Row(
                          children: [
                            if (model != null)
                              Text(
                                "Showing ${model!.product!.length} of ${model!.product!.length}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                "Filter",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.tune,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.shopping_cart_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              productCount.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              "₹ ${totalPrice.toString()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const RotatedBox(
                                    quarterTurns: 2,
                                    child: Icon(Icons.arrow_back)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      );
    }
  }
}
