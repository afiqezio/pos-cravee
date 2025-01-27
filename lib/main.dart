import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:possystem/features/productTest/views/productPageMain.dart';
// import 'package:possystem/features/productTest/views/elokV.dart';
import 'package:possystem/features/splash_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: SplashScreen(),
    //   theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
    // );
    return MaterialApp(
      title: 'Products App',
      home: ProductsPage(),
    );
  }
}
