import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shine_app/screens/product_display/product_display.dart';
import './gallery.dart';
import 'models/product.dart';

Future<void> main() async{
  await dotenv.load();
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
      onGenerateRoute: (settings) {
      final arguments = settings.arguments;
      switch (settings.name) {
        case '/product':
          if (arguments is Product) {
            return MaterialPageRoute(builder: (context) => ProductDisplay(arguments));
          }
          break;
        default:
          return MaterialPageRoute(builder: (context) => MyHomePage(title: "SHINE"));
      }
    },
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

  final List<String> tabTitles = const [
    "Women",
    "Men", 
    "Kids"
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(fontSize: 28)),
          leading: const Icon(Icons.favorite_outline, size: 32),
          titleSpacing: 0,
          actions: const [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.shopping_bag_outlined, size: 32),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: tabTitles.map<Tab>((title) => Tab(text: title.toUpperCase())).toList(),
          ),
        ),
        body: TabBarView(
          children: tabTitles.map<GalleryWidget>((title) => GalleryWidget(category: title)).toList(),
        ),
      ),
    );
  }
}
