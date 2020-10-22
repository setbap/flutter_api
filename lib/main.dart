// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/app/services/api.dart';
import 'package:flutter_api/app/services/api.service.dart';
import 'package:flutter_api/app/repositories/data_repositorries.dart';
import 'package:flutter_api/app/services/cache.service.dart';
import 'package:flutter_api/app/ui/dashboard.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  Intl.defaultLocale = 'en_US';
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("en_US");
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    // DevicePreview(
    // enabled: !kReleaseMode,
    // builder: (context) =>
      MyApp(sharedPreferences: sharedPreferences)
    //  ,
    // ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({@required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) =>
          DataRepository(
              apiService: ApiService(api: Api.sandbox()),
              cacheService: CacheService(sharedPreferences)),
      child: MaterialApp(
        // builder: DevicePreview.appBuilder,
        title: 'Flutter Covid',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.deepOrange,
          accentColor: Colors.red,
          cardColor: Colors.white12,
        ),
        home: Dashboard(title: 'Coivd 2019'),
      ),
    );
  }
}
