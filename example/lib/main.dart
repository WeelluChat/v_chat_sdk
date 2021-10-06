import 'package:example/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:v_chat_sdk/v_chat_sdk.dart';
import 'controllers/lang_controller.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await VChatController.instance.init(
      baseUrl: "10.0.2.2:3000",
      appName: "test_v_chat",
      isUseFirebase: true,
      lightTheme: vchatLightTheme,
      darkTheme: vchatDarkTheme,
      enableLogger: true);
  // add support new language
  // v_chat will change the language one you change it
  VChatController.instance.setLocaleMessages(
      languageCode: "ar", countryCode: "EG", lookupMessages: Ar());

  runApp(ChangeNotifierProvider<LangController>(
    create: (context) => LangController(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    context.watch<LangController>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.read<LangController>().theme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: context.read<LangController>().locale,
      home: SplashScreen(),
    );
  }
}

class Ar implements LookupString {
  @override
  String test() => "اختبار ";
}