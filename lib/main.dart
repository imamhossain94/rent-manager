import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'app/view/home/home_view.dart';
import 'global.dart';
import 'models/product.dart';
import 'models/spice.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  await Hive.initFlutter();

  Hive.registerAdapter(SpiceAdapter());
  Hive.registerAdapter(ProductAdapter());

  await Hive.openBox<Product>('products');
  quantity.onInit();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('bn', 'BD')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {

      return SimpleBuilder(builder: (_) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Spice',
            theme: color.currentTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: HomeScreen()
        );
      });
    });
  }
}
