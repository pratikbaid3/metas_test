import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:metas_test/flavour_config.dart';
import 'package:metas_test/modules/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

import 'modules/dashboard/apis/character_provider.dart';
import 'modules/dashboard/views/detail_screen.dart';

void mainCommon({required FlavourConfig config}) {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeProvider(config: config),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CharacterProvider>(
          create: (context) => CharacterProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Character Viewer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DetailScreen(),
        builder: EasyLoading.init(),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                homeProvider.config?.api ?? "",
              ),
            ],
          ),
        ),
      );
    });
  }
}
