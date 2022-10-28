import 'package:flutter/material.dart';
import 'package:shine_app/enums/categories.dart';
import './gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white
      ),
      home: const MyHomePage(title: 'SHINE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Map<String, Categories>> tabTitles = const [
    { 'Women': Categories.women }, 
    { 'Men': Categories.men },
    { 'Kids': Categories.kids }
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: tabTitles.map<Tab>((title) => Tab(text: title.keys.first.toUpperCase())).toList(),
          ),
        ),
        body: TabBarView(
          children: tabTitles.map<GalleryWidget>((title) => GalleryWidget(category: title.values.first)).toList(),
        ),
      ),
    );
  }
}
