import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixiv_func_android/app/http/http.dart';
import 'package:pixiv_func_android/app/inject/inject.dart';
import 'package:pixiv_func_android/app/platform/api/platform_api.dart';
import 'package:pixiv_func_android/app/theme/app_theme.dart';
import 'package:pixiv_func_android/pages/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Inject.init();
  HttpConfig.refreshHttpClient();
  runApp(const App());

  final storageStatus = Permission.storage;

  if (!await storageStatus.isGranted) {
    Permission.storage.request();
  }
}

DateTime? _lastPopTime;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Pixiv Func',
      home: WillPopScope(
        onWillPop: () async {
          if (null == _lastPopTime || DateTime.now().difference(_lastPopTime!) > const Duration(seconds: 1)) {
            _lastPopTime = DateTime.now();
            Get.find<PlatformApi>().toast('再按一次退出');
            return false;
          } else {
            return true;
          }
        },
        child: const HomeWidget(),
      ),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      enableLog: false,
    );
  }
}
