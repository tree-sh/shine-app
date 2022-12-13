import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shine_app/models/product.dart';
import 'package:shine_app/state/shopping_bag.dart';

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({super.key});

  @override
  State<ShoppingBag> createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {

  double _width = -1;
  double _height = -1;
  List<Product> shoppingBagSelected = [];
  double selectedPrice = 0;

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
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.close)
        ),
        title: Text("Shopping Bag", style: TextStyle(fontWeight: FontWeight.w500))
      ),
      body: Consumer<ShoppingBagNotifier>(
        builder: (context, value, child){
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
                    children: shoppingBagProductsBuilder(value.products)
                  ),
                ),
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
                              value: shoppingBagSelected.length > 0 &&
                                value.products.every((product) => shoppingBagSelected.map((e) => e.id).contains(product.id)),
                              onChanged: (bool? isSelected) {
                               setState(() {
                                 isSelected == true ? value.products.forEach((selected) {
                                    if(!shoppingBagSelected.any((element) => element.id == selected.id)) {
                                      shoppingBagSelected.add(selected);
                                    }
                                  }) :
                                  shoppingBagSelected = [];
                                 computePrice();
                               });
                              },
                            ),
                            Text("All", style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Text(
                              "₱${selectedPrice.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 21, color: Colors.orange, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 10),
                            Container(
                              color: Colors.blue,
                              child: ElevatedButton(
                                onPressed: (){
                                  value.checkout(shoppingBagSelected);
                                  selectedPrice = 0;
                                  shoppingBagSelected = [];
                                },
                                child: Text("CHECKOUT", style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(_width * 0.45, _height * 0.05)
                                )
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  )
                )
              ),
            ],
          )
          );
        } 
      ));
  }

  List<Widget> shoppingBagProductsBuilder(List<Product> products){
    return products.map((product){
      return Container(
        width: _width * 0.90, 
        height: 200, 
        color:Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: shoppingBagSelected.map((e) => e.id).contains(product.id),
              onChanged: (bool? value) {
                setState(() {
                  value == true ? shoppingBagSelected.add(product) : shoppingBagSelected.removeWhere((selected) => selected.id == product.id);
                  computePrice();
                });  
              },
            ),
            Image.asset(product.image, height: 180, width: _width * 0.3),
            SizedBox(width: 10),
            Container(
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _width * 0.45,
                    child: Text(product.name, softWrap: true,)
                  ),
                  Text(
                    "₱${product.price}",
                    style: TextStyle(fontSize: 21, color: Colors.orange, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all()
                  ),
                  child: Consumer<ShoppingBagNotifier>(
                    builder: ((context, value, child) {
                      return Row(
                      children: [
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: (){
                            product.qty = product.quantity + 1;
                            value.replaceProduct(product);
                          },
                          child: Icon(Icons.add, size: 25)
                        ),
                        SizedBox(width: 15),
                        Text("${product.quantity}", style: TextStyle(fontSize: 25)),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: (){
                            if(product.quantity > 1)
                            {
                              
                              product.qty = product.quantity - 1;
                              value.replaceProduct(product);
                            }
                            else {
                              _showMyDialog(context, value, product);
                              
                            }
                          },
                          child: Icon(Icons.remove, size: 25)
                        ),
                        SizedBox(width: 8)
                      ],
                    );
                    })
                  )
                )
              ],
            ),
          )
        ],
      )
    );
    }).toList();
  }

  Future<void> _showMyDialog(BuildContext context, ShoppingBagNotifier model, Product product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to remove this item from the list?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
              onPressed: () {
                model.remove(product);
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  void computePrice(){
    selectedPrice = shoppingBagSelected.length > 0 ? 
      shoppingBagSelected.map((selected) => selected.price * selected.quantity).reduce((value, element) => value + element)
      : 0;
  }
}