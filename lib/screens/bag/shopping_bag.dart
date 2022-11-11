import 'package:flutter/material.dart';
import 'package:shine_app/models/product.dart';

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({super.key});

  @override
  State<ShoppingBag> createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
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
      body: Container(
        color: Colors.black12,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      width: _width * 0.90, 
                      height: 200, 
                      color:Colors.white,
                      child: Row(
                        children: [
                          Radio<String>(
                            value: "Blue Dress",
                            groupValue: "Blue Dres",
                            activeColor: Colors.black,
                            onChanged: (value){
                              print("Clicked radio button");
                            },
                          ),
                          Image.asset("images/crew_neck.webp", height: 180, width: _width * 0.3),
                          SizedBox(width: 10),
                          Container(
                            height: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Olive Green Crew Neck"),
                                Text(
                                    "₱229.00",
                                    style: TextStyle(fontSize: 21, color: Colors.orange, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all()
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: (){},
                                        child: Icon(Icons.add, size: 25)
                                      ),
                                      SizedBox(width: 15),
                                      Text("9", style: TextStyle(fontSize: 25)),
                                      SizedBox(width: 15),
                                      GestureDetector(
                                        onTap: (){},
                                        child: Icon(Icons.remove, size: 25)
                                      ),
                                      SizedBox(width: 8)
                                    ],
                                  )
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ),
                  ],
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
                          Radio<String>(
                            value: "Blue Dress",
                            groupValue: "Blue Dres",
                            activeColor: Colors.black,
                            onChanged: (value){
                              print("Clicked radio button");
                            }
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
                            "₱229.00",
                            style: TextStyle(fontSize: 21, color: Colors.orange, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 10),
                          Container(
                            //width: _width * 0.45,
                            color: Colors.blue,
                            child: ElevatedButton(
                              onPressed: (){},
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
    ),
      ));
  }
}