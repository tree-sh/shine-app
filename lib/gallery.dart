import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shine_app/models/product.dart';
import './enums/categories.dart';

class GalleryWidget extends StatefulWidget {
  final Categories category;
  const GalleryWidget({super.key, required this.category});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {

  List<Product> products = [
    Product(name: 'Orange T-shirt', image: 'images/tshirt.jpeg', price: 193.00, category: Categories.men),
    Product(name: 'Long Sleeves', image: 'images/long_sleeve.webp', price: 193.00, category: Categories.kids),
    Product(name: 'Long Sleeves Crew Neck Shirt', image: 'images/crew_neck.webp', price: 193.00, category: Categories.men),
    Product(name: 'Blue Polkadot Dress', image: 'images/dress.jpg', price: 193.00, category: Categories.women),
    Product(name: 'Blue Polkadot Dress', image: 'images/dress.jpg', price: 193.00, category: Categories.women),
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Search for ${categoryMapping[widget.category]}",
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0),
                ),
              )
            ),
            SizedBox(width: width, height: 10),
            SingleChildScrollView(
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  children: productsBuilder(width),
                ),
            )
          ]
        ),
      )
    );
  }

  List<Widget> productsBuilder(width) {
    return products.where((element){
        return element.category == widget.category;
    }).map((product) =>
      Container(
        width: width * 0.5,
        child: Card(
          child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(product.image),
                      Container(
                        width: width * 0.4,
                        child: Text(
                          product.name,
                          softWrap: true,
                        )
                      ),
                      Container(
                        width: width * 0.4,
                        child: Text(
                          "P${product.price.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 21)
                        )
                      )
                    ],
                  )
                )
    )
    ).toList(); 
  }
}