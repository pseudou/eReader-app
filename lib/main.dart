import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'core/theme/theme_config.dart';
import 'routing/app_router.dart';
import 'features/splash/presentation/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return CupertinoApp(
      title: 'LoreBubbl',
      theme: ThemeConfig.darkTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.home,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}