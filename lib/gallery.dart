import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:shine_app/models/product.dart';

class GalleryWidget extends StatefulWidget {
  final String category;
  const GalleryWidget({super.key, required this.category});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {

  double _width = -1;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    final products = getProducts();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Search for ${widget.category}",
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0),
                ),
              )
            ),
            SizedBox(width: _width, height: 10),
            FutureBuilder(
                  future: getProducts(),
                  builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                    if(snapshot.hasData)
                    {
                      return StaggeredGrid.count(
                        crossAxisCount: 2,
                        children: snapshot.data!
                          .where((data) => data.category.toUpperCase() == widget.category.toUpperCase())
                          .map((data) => productsBuilder(data)).toList(),
                      );
                    }
                    return Container();
                  },
                )
            
          ]
        ),
      )
    );
  }

  Widget productsBuilder(product) {
    return Container(
        width: _width * 0.5,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(product.image),
                      Container(
                        width: _width * 0.4,
                        child: Text(
                          product.name,
                          softWrap: true,
                        )
                      ),
                      Container(
                        width: _width * 0.4,
                        child: Text(
                          "P${product.price.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 21)
                        )
                      )
                    ],
                  )
                )
      );
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse(dotenv.env['PRODUCTS_API'] ?? '')
    );

    if (response.statusCode == 200) {
    final List<dynamic> responseList = jsonDecode(response.body);
    return responseList.map((res) => Product.fromJson(res)).toList();
  } else {
    throw Exception('Failed to load products');
  }
  }
}