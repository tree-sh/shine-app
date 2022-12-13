import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../state/shopping_bag.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  double _width = -1;
  List<Product> _wishlistSelected = [];

  Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.close)
        ),
        title: Text("Wishlist", style: TextStyle(fontWeight: FontWeight.w500))
      ),
      body: Consumer<ShoppingBagNotifier>(
        builder: ((context, value, child) {
          return Container(
            color: Colors.black12,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: wishlistProductsBuilder(value.wishlistProducts),
                    ),
                  )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _width, 
                    height: _height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10
                          )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: _wishlistSelected.length > 0 &&
                                  value.wishlistProducts.every((product) => _wishlistSelected.map((e) => e.id).contains(product.id)),
                                onChanged: (bool? isSelected) {
                                  setState(() {
                                    isSelected == true ? _wishlistSelected = value.wishlistProducts : _wishlistSelected = [];
                                  });
                                },
                              ),
                              Text("All", style: TextStyle(fontSize: 18))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 18),
                          child: ElevatedButton(
                            onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Added to Bag!", style: TextStyle(fontSize: 18)))
                              );
                              value.addToBag(_wishlistSelected);
                              _wishlistSelected = [];
                            },
                            child: Text("ADD TO BAG", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(_width * 0.45, _height * 0.05)
                            )
                          ),
                        )
                      ],
                    )
                  )
                ),
              ],
            ),
          );
        })
      ));
  }

  List<Widget> wishlistProductsBuilder(List<Product> products) {
    return products.map((product) {
      return Container(
        width: _width * 0.90, 
        height: 200, 
        color:Colors.white,
        child: Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: _wishlistSelected.map((e) => e.id).contains(product.id),
              onChanged: (bool? isSelected) {
                setState(() {
                  isSelected == true ? _wishlistSelected.add(product) : _wishlistSelected.removeWhere((element) => element.id == product.id);
                });
              },
            ),
            Image.asset(product.image, height: 180, width: _width * 0.3),
            SizedBox(width: 10),
            Container(
              //height: 130,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: _width * 0.45,
                  child: Text(product.name, softWrap: true,)
                ),
                Text(
                  "₱${product.price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 21, color: Colors.orange, fontWeight: FontWeight.w600),
                 )
              ],
            ),
          )
                        ],
                      )
                    );
    }).toList();
  }
}