import 'package:exactus_project/controller/getx_controller.dart';
import 'package:exactus_project/controller/providerController.dart';
import 'package:exactus_project/view/cartPage.dart';
import 'package:exactus_project/view/widgets/nav_drawer.dart';
import 'package:exactus_project/view/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class ProductHome extends StatefulWidget {
  @override
  State<ProductHome> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    var cartpage_list = context.watch<dataProvider>().carts;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 28, 50),
        title: const Text("Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Cart()));
              },
              child: Badge(
                largeSize: 5,
                backgroundColor: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${cartpage_list.length}'),
                    Icon(Icons.shopping_cart)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Navdrawer(),
      body: Obx(() {
        if (productController.isLoading.value) {
          return  Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
            itemCount: productController.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return ProductTile(productController.productList[index]);
            },
          );
        }
      }),
    );
  }
}
