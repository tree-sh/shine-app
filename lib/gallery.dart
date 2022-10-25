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
    return Center(
      child: Text('For ${widget.category} only')
    );
  }
}