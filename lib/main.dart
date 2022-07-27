import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/modules/auth/home.dart';
import 'package:pos_app/modules/auth/register.dart';
import 'package:pos_app/modules/auth/verify_otp.dart';
import 'package:pos_app/routes.dart';
import '/data/providers/app_state_manager.dart';
import 'package:pos_app/styles/theme_app.dart';
import 'package:provider/provider.dart';
import 'data/setting/config_app.dart';
import 'modules/auth/login.dart';
import 'modules/auth/sales_invoice.dart';

//TODO: easy_localization package setup for ios
//TODO: local_auth package setup for ios
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'SA'),
      startLocale: const Locale('ar', 'SA'),
      saveLocale: true,
      child:  MyApp(token:await ConfigApp.getToken())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key,required this.token}) : super(key: key);
 final String? token;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>AppStateManager()),
      ],
      child: Consumer<AppStateManager>(
        builder: (_, loginManager, __) {
          // print(loginManager.user?.token);
          return MaterialApp(
          title: 'HR App',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeApp.light,
            initialRoute: Routes.SALES_INVOICE_PAGE,
            onGenerateRoute: (RouteSettings settings) {
            return Routes.fadeThrough(settings, (context) {
              switch (settings.name) {
                case Routes.LOGIN_PAGE:
                  return const Login();
                case Routes.REGISTER_PAGE:
                  return const Register();
                case Routes.VERIFY_OTP_PAGE:
                  return const VerifyOtp();
                case Routes.HOME_PAGE:
                  return const Home();
                case Routes.SALES_INVOICE_PAGE:
                  return const SalesInvoice();
                  default:
                    return const Login();
              }
            });
          },
        );
        },
      ),
    );
  }
}
