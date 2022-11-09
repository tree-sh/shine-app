import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({super.key});

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back)
          )
      ),
      body: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.loose,
          children: [
            Image.asset(
              'images/dress.jpg', 
              height: _height * 0.80,
              fit: BoxFit.cover
            ),
           SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.all(10),
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
                  width: _width * 0.95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: _width,
                        child: Text(
                          "Blue Polkadot Dress",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 10, width: 10),
                      Container(
                        width: _width,
                        child: Text(
                          "₱299.99",
                          style: TextStyle(fontSize: 21, color: Colors.orange, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 10, width: 10),
                      Container(
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sizes:'),
                            Row(
                              children: const [
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
                      )
                    ],
                  )
                )
            )
          ]
        )
      //)
    );
  }
}