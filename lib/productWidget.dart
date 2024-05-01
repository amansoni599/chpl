import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  String url, name, price, productId;
  int buyCount;
  final Function(int, int) onTapAdd;
  final Function(int, int) onTapSub;
  ProductWidget(
      {super.key,
      required this.onTapAdd,
      required this.buyCount,
      required this.onTapSub,
      required this.productId,
      required this.name,
      required this.price,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  height: 100,
                  width: 100,
                  "https://deepwebtechs.com/calc/public/image/$url"),
              const SizedBox(
                height: 10,
              ),
              Text(
                name.toString(),
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Price:  $price",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      onTapAdd(
                          int.parse(
                            price,
                          ),
                          int.parse(productId));
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.lightGreenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(child: Icon(Icons.add)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      buyCount.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (buyCount > 0) {
                        onTapSub(int.parse(price), int.parse(productId));
                      }
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightGreenAccent,
                      ),
                      child: const Center(child: Icon(Icons.remove)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
