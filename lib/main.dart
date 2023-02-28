import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:son_pv/data/api/api_service.dart';
import 'package:son_pv/provider/pvdetail_provider.dart';
import 'package:son_pv/provider/pvlist_provider.dart';
import 'package:son_pv/provider/pvsearch_provider.dart';
import 'package:son_pv/ui/pv_detail.dart';
import 'package:son_pv/ui/pv_list.dart';
import 'package:son_pv/ui/search_list.dart';
import 'package:son_pv/ui/splashscreen.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<PvListProvider>(
            create: (context) => PvListProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider<PvDetailProvider>(
            create: (context) => PvDetailProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider<SearchProvider>(
            create: (context) => SearchProvider(apiService: ApiService()),
          ),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SON Product Verification',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => const SplashScreen(),
        '/pvList':(context) => const PvList(),
        '/pvDetail':(context) => const PvDetail(),
        '/search':(context) => const SearchPv(),
      },
    );
  }
}
