import 'package:flutter/material.dart';
import 'package:shine_app/models/product.dart';

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
                    offset: Offset(0, 3), // changes position of shadow
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
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(children: [
                          GestureDetector(
                            onTap: (){
                              setState(() { isFavorite = !isFavorite; });
                            },
                            child: isFavorite ? Icon(Icons.favorite, size: 32, color: Colors.red) :  Icon(Icons.favorite_outline, size: 32)
                          ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: (){
                                          setState((){ isAddedToCart = !isAddedToCart; }); 
                                        },
                                        child: isAddedToCart ? Icon(Icons.shopping_bag, size: 32, color: Colors.green) : Icon(Icons.shopping_bag_outlined, size: 32)
                                      ),
                                    ],),
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