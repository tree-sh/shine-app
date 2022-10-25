import 'package:flutter/material.dart';

class GalleryWidget extends StatefulWidget {
  final String category;
  const GalleryWidget({super.key, required this.category});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ]
      )
    );
  }
}