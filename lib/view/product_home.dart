import 'package:exactus_project/controller/getx_controller.dart';
import 'package:exactus_project/controller/providerController.dart';
import 'package:exactus_project/view/cartPage.dart';
import 'package:exactus_project/view/widgets/nav_drawer.dart';
import 'package:exactus_project/view/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductHome extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    var cartpage_list = context.watch<dataProvider>().carts;
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Cart()));
              },
              child: Badge(
                largeSize: 25,
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
      body: SizedBox(
        child: Obx(() {
          if (productController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              itemCount: productController.productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return ProductTile(productController.productList[index]);
              },
            );
          }
        }),
      ),
    );
  }
}
