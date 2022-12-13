import 'package:flutter/material.dart';
import 'package:shine_app/models/product.dart';
import 'package:shine_app/state/shopping_bag.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatefulWidget {
  final Product product;
  const ProductDescription(this.product);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {

  bool isFavorite = false;
  bool isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var shoppingBagModel = Provider.of<ShoppingBagNotifier>(context);
    return SingleChildScrollView(
      child: Column(
          children: [
            SizedBox(height: height * 0.45),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3)
                  ),
                ],
              ),
              width: width * 0.95,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * 0.65,
                          child: Text(
                            widget.product.name,
                            softWrap: true,
                            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(children: [
                          GestureDetector(
                            onTap: (){
                              setState(() { 
                                if(!shoppingBagModel.wishlistContainsProduct(widget.product.id)) {
                                  shoppingBagModel.addToWishlist(widget.product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Added to Wishlist!", style: TextStyle(fontSize: 18)))
                                  );
                                } else {
                                  shoppingBagModel.removeFromWishlist(widget.product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Removed from Wishlist", style: TextStyle(fontSize: 18)))
                                  );
                                }
                              });
                            },
                            child: Consumer<ShoppingBagNotifier>(
                              builder: ((context, value, child) {
                                if(shoppingBagModel.wishlistContainsProduct(widget.product.id)){
                                  return const Icon(Icons.favorite, size: 32, color: Colors.red);
                                }
                                return const Icon(Icons.favorite_border_outlined, size: 32);
                              })
                            )
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: (){
                              if(!shoppingBagModel.cartContainsProduct(widget.product.id)) {
                                shoppingBagModel.add(widget.product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Added to Bag!", style: TextStyle(fontSize: 18)))
                               );
                              } else {
                                shoppingBagModel.remove(widget.product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Removed from Bag", style: TextStyle(fontSize: 18)))
                               );
                              }
                            },
                            child: Consumer<ShoppingBagNotifier>(
                              builder: ((context, value, child) {
                                if(value.products.map((item) => item.id).contains(widget.product.id)){
                                  return const Icon(Icons.shopping_bag, size: 32, color: Colors.green);
                                }
                                return const Icon(Icons.shopping_bag_outlined, size: 32);
                              })
                            ))
                        ])
                      ],
                    )
                  ),
                              SizedBox(height: 5, width: 10),
                              Container(
                                width: width,
                                child: Text(
                                  "₱${widget.product.price}",
                                  style: TextStyle(fontSize: 21, color: Colors.orange, fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(height: 20, width: 10),
                              Container(
                                width: width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sizes:'),
                                    Row(
                                      children: const [
                                        Chip(
                                          label: Text('XS'),
                                        ),
                                        Chip(
                                          label: Text('S'),
                                        ),
                                        Chip(
                                          label: Text('M'),
                                        ),
                                        Chip(
                                          label: Text('L'),
                                        ),
                                        Chip(
                                          label: Text('XL'),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ),
                            ],
                          )
                        )
                      ],
                    )
    );
  }
}