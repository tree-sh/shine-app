import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shine_app/screens/bag/shopping_bag.dart';
import 'package:shine_app/screens/product_display/product_display.dart';
import 'package:shine_app/screens/wishlist/wishlist.dart';
import 'package:shine_app/state/shopping_bag.dart';
import 'screens/gallery/gallery.dart';
import 'models/product.dart';

Future<void> main() async{
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShoppingBagNotifier())
      ],
      child: const MyApp()
    )
  );
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
        primarySwatch: white,
        //colorScheme: ColorScheme.fromSwatch(primarySwatch: white).copyWith(secondary: Colors.black),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black,
          textTheme: ButtonTextTheme.primary
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            textStyle: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
      onGenerateRoute: (settings) {
      final arguments = settings.arguments;
      switch (settings.name) {
        case '/product':
          if (arguments is Product) {
            return MaterialPageRoute(builder: (context) => ProductDisplay(arguments));
          }
          break;
        case '/shopping-bag':
          return MaterialPageRoute(builder: (context) => const ShoppingBag());
        case '/wishlist':
          return MaterialPageRoute(builder: (context) => const Wishlist());
        default:
          return MaterialPageRoute(builder: (context) => const MyHomePage(title: "SHINE"));
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
          title: Text(widget.title, style: const TextStyle(fontSize: 28)),
          leading: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/wishlist');
            },
            child: const Icon(Icons.favorite_outline, size: 32)
          ),
          titleSpacing: 0,
          actions: [
            Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/shopping-bag');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.shopping_bag_outlined, size: 32),
                  ),
                ),
                Positioned(
                  right: 6,
                  child: Consumer<ShoppingBagNotifier>(
                    builder:(context, value, child) {
                      if(value.totalItemsInBag > 0)
                      {
                        return Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            value.totalItemsInBag.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                )
              ]
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
