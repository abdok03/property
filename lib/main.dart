import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'InvestmentHomeScreen.dart';
import ' exploreOptionPage.dart';
import 'ViewMarketTrendsScreen.dart';
import 'StartInvestingPage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الاستثمار العقاري',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Almarai',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InvestmentHomeScreen(),
        '/explore': (context) => const ExploreOptionsPage(),
        '/market': (context) => ViewMarketTrendsScreen(),
        '/invest': (context) => const StartInvestingPage(),
      },
    );
  }
}