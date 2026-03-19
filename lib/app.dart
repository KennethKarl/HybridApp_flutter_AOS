import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'app_layout.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '어떠케어',
      theme: AppTheme.light,
      home: const AppLayout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
