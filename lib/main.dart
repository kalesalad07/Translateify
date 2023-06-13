import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translateify/routing/app_router.dart';
import 'package:translateify/services/app_services.dart';
import 'package:translateify/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: UnsignedPage());
//   }
// }

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  MyApp({required this.sharedPreferences});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late AppService appService;
  late AuthService _authService;
  late StreamSubscription<bool> authSubscription;

  late StreamSubscription<bool> langSubscription;

  AuthService get authService => _authService;

  @override
  void initState() {
    appService = AppService(widget.sharedPreferences);
    _authService = AuthService();

    authSubscription = _authService.onAuthStateChange.listen(onAuthStateChange);

    super.initState();
  }

  void onAuthStateChange(bool login) {
    appService.loginState = login;
    appService.uid = _authService.currentUser!.uid;
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppService>(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter(appService)),
        Provider<AuthService>(create: (_) => _authService),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter =
              Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            theme: ThemeData(fontFamily: 'Product Sans'),
            debugShowCheckedModeBanner: false,
            title: "Translateify",
            routeInformationParser: goRouter.routeInformationParser,
            routerDelegate: goRouter.routerDelegate,
          );
        },
      ),
    );
  }
}
