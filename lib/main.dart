import 'package:barleryroof/Views/EmailConfirmPage.dart';
import 'package:barleryroof/constant.dart';
import 'package:barleryroof/providers/announe_provider.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Views/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => UnitProvider()),
            ChangeNotifierProvider(create: (_) => AnnounceProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              primaryColor:Color(0xffD1B373),
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          ),
        );
      },
      child: Splash(),
    );  }
}
