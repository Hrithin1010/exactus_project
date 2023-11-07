import 'package:exactus_project/controller/providerController.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exactus_project/model/product_model.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    var cartList = context.watch<dataProvider>().carts;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100, 
              child: CachedNetworkImage(
                imageUrl: product.image!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title!,
                    maxLines: 2,
                    style: const TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (product.rating != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product.rating!.rate.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(fontSize: 14, fontFamily: 'avenir'),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      {
                        if (cartList.contains(product)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Item already in the cart...")));
                        } else {
                          Provider.of<dataProvider>(context, listen: false)
                              .addToCart(product);
                        }
                      }
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
