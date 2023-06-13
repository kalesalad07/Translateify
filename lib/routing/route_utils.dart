enum APP_PAGE { splash, loginhome, phonelogin, maillogin, signup, home, error }

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.splash:
        return '/splash';
      case APP_PAGE.loginhome:
        return '/loginhome';
      case APP_PAGE.phonelogin:
        return '/phonelogin';
      case APP_PAGE.maillogin:
        return '/maillogin';
      case APP_PAGE.signup:
        return '/signup';
      case APP_PAGE.home:
        return '/home';
      case APP_PAGE.error:
        return '/error';
      default:
        return '/loginhome';
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.splash:
        return "SPLASH";
      case APP_PAGE.loginhome:
        return "LOGIN";
      case APP_PAGE.phonelogin:
        return "PHONE";
      case APP_PAGE.maillogin:
        return "EMAIL";
      case APP_PAGE.signup:
        return "SIGNUP";
      case APP_PAGE.error:
        return "ERROR";

      default:
        return "HOME";
    }
  }

  // String get toTitle {
  //   switch (this) {
  //     case APP_PAGE.home:
  //       return "My App";
  //     case APP_PAGE.login:
  //       return "My App Log In";
  //     case APP_PAGE.splash:
  //       return "My App Splash";
  //     case APP_PAGE.error:
  //       return "My App Error";
  //     case APP_PAGE.onBoarding:
  //       return "Welcome to My App";
  //     default:
  //       return "My App";
  //   }
  // }
}
