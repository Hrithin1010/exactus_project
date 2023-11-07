import 'package:exactus_project/controller/providerController.dart';
import 'package:exactus_project/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  late final ProductModel product;

  @override
  Widget build(BuildContext context) {
    var cartList = context.watch<dataProvider>().carts;
    num totalamount = 0;
    for (var item in cartList) {
      totalamount += (item.price! * item.count);
    }
    return Scaffold(
         backgroundColor: Colors.amber[50],
      appBar: AppBar(
          title: Text(
            " My Cart",
            style: TextStyle(
                fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 8,
                child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      var item = cartList[index];
                      totalamount = (item.price! * item.count) + totalamount;
                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 90,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(item.image!),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 50,
                                        child: Text(
                                          item.title!,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3, bottom: 6),
                                      child: Text(
                                        "\$${item.price.toString()}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          child: Text(
                                            "Buy Now",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 45, left: 50),
                                  child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<dataProvider>()
                                          .removefromCart(item);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Successfully deleted")));
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_outlined,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<dataProvider>(context,
                                                listen: false)
                                            .decrementItem(item);
                                      },
                                      child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor: Color(0xFF11334B),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, right: 3, top: 1),
                                      child: Text(
                                        item.count.toString(),
                                        style: TextStyle(
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<dataProvider>(context,
                                                listen: false)
                                            .addItem(item);
                                      },
                                      child: CircleAvatar(
                                        radius: 13,
                                        backgroundColor: Color(0xFF11334B),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
