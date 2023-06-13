import 'package:go_router/go_router.dart';
import 'package:translateify/routing/route_utils.dart';
import 'package:translateify/ui/login_page.dart';
import 'package:translateify/ui/register_page.dart';
import 'package:translateify/ui/unsigned_page.dart';

import '../services/app_services.dart';
import '../ui/error_page.dart';
import '../ui/home.dart';
import '../ui/splash.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: APP_PAGE.splash.toPath,
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.home.toPath,
        name: APP_PAGE.home.toName,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: APP_PAGE.splash.toPath,
        name: APP_PAGE.splash.toName,
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: APP_PAGE.loginhome.toPath,
        name: APP_PAGE.loginhome.toName,
        builder: (context, state) => UnsignedPage(),
      ),
      GoRoute(
        path: APP_PAGE.phonelogin.toPath,
        name: APP_PAGE.phonelogin.toName,
        builder: (context, state) => const PhoneLoginPage(),
      ),
      GoRoute(
        path: APP_PAGE.maillogin.toPath,
        name: APP_PAGE.maillogin.toName,
        builder: (context, state) => const MailLoginPage(),
      ),
      GoRoute(
        path: APP_PAGE.signup.toPath,
        name: APP_PAGE.signup.toName,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: APP_PAGE.error.toPath,
        name: APP_PAGE.error.toName,
        builder: (context, state) => ErrorPage(error: state.extra.toString()),
      ),
    ],
    errorBuilder: (context, state) {
      print('error builder');
      return ErrorPage(error: state.error.toString());
    },
    redirect: (state) {
      final loginHomeLocation = state.namedLocation(APP_PAGE.loginhome.toName);
      final homeLocation = state.namedLocation(APP_PAGE.home.toName);
      final splashLocation = state.namedLocation(APP_PAGE.splash.toName);
      //final onboardLocation = state.namedLocation(APP_PAGE.onBoarding.toPath);
      final phoneLoginLocation =
          state.namedLocation(APP_PAGE.phonelogin.toName);
      final mailLoginLocation = state.namedLocation(APP_PAGE.maillogin.toName);
      final signUpLocation = state.namedLocation(APP_PAGE.signup.toName);

      final isLoggedIn = appService.loginState;
      final isInitialized = appService.initialized;

      //final isOnboarded = appService.onboarding;

      final isGoingToLogin = (state.subloc == loginHomeLocation) ||
          (state.subloc == phoneLoginLocation) ||
          (state.subloc == mailLoginLocation) ||
          (state.subloc == signUpLocation);
      final isGoingToInit = state.subloc == splashLocation;

      final isGoneHome = state.subloc == homeLocation;

      //final isGoingToOnboard = state.subloc == onboardLocation;

      // If not Initialized and not going to Initialized redirect to Splash
      if (!isInitialized) {
        if (!isGoingToInit) return splashLocation;
      } else {
        if (!isLoggedIn) {
          if (!isGoingToLogin) return loginHomeLocation;
        } else {
          if (!isGoneHome) {
            return homeLocation;
          } else {
            return null;
          }
        }
      }
      return null;
    },
  );
}
