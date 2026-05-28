import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/localization/app_strings.dart';
import 'feature/blinkit_money/presentation/screens/blinkit_money_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFF111116),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const FlickTvApp());
}

class FlickTvApp extends StatelessWidget {
  const FlickTvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppStrings.of(context).appTitle,
      localizationsDelegates: const [AppStrings.delegate],
      supportedLocales: AppStrings.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'BlinkFont'),
      home: const BlinkitMoneyScreen(),
    );
  }
}
