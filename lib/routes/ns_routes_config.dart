import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/features/auth/change_password/view/change_password_page.dart';
import 'package:nike_sneaker_store/features/auth/forgot_password/view/forgot_password_page.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/sign_in_page.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/view/sign_up_page.dart';
import 'package:nike_sneaker_store/features/auth/verification/view/verification_page.dart';
import 'package:nike_sneaker_store/features/cart/view/cart_page.dart';
import 'package:nike_sneaker_store/features/cart_information/view/cart_information_page.dart';
import 'package:nike_sneaker_store/features/detail/view/detail_page.dart';
import 'package:nike_sneaker_store/features/favorite/view/favorite_page.dart';
import 'package:nike_sneaker_store/features/home/view/home_page.dart';
import 'package:nike_sneaker_store/features/layout/view/layout_page.dart';
import 'package:nike_sneaker_store/features/notification/view/notifications_page.dart';
import 'package:nike_sneaker_store/features/onboarding/view/onboarding_page.dart';
import 'package:nike_sneaker_store/features/profile/view/profile_page.dart';
import 'package:nike_sneaker_store/features/search/view/search_page.dart';
import 'package:nike_sneaker_store/features/setting/view/setting_page.dart';
import 'package:nike_sneaker_store/features/splash/views/splash_page.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';

class NSRoutesConfig {
  static final _rootNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'homeShell');
  static final _rootNavigatorFavorite =
      GlobalKey<NavigatorState>(debugLabel: 'favoriteShell');
  static final _rootNavigatorNotification =
      GlobalKey<NavigatorState>(debugLabel: 'notificationShell');
  static final _rootNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'profileShell');
  static GoRouter goRoute = GoRouter(
    initialLocation: NSRoutesConst.pathSplash,
    routes: [
      GoRoute(
        name: NSRoutesConst.nameSplash,
        path: NSRoutesConst.pathSplash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: NSRoutesConst.nameOnboarding,
        path: NSRoutesConst.pathOnboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: NSRoutesConst.nameSignIn,
        path: NSRoutesConst.pathSignIn,
        builder: (context, state) => const SignInProvider(),
      ),
      GoRoute(
        name: NSRoutesConst.nameSignUp,
        path: NSRoutesConst.pathSignUp,
        builder: (context, state) => const SignUpProvider(),
      ),
      GoRoute(
        name: NSRoutesConst.nameForgotPass,
        path: NSRoutesConst.pathForgotPass,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        name: NSRoutesConst.nameVerification,
        path: NSRoutesConst.pathVerification,
        builder: (context, state) => const VerificationPage(),
      ),
      GoRoute(
        name: NSRoutesConst.nameSearch,
        path: NSRoutesConst.pathSearch,
        builder: (context, state) => const SearchProvider(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => LayoutPage(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: NSRoutesConst.pathHome,
                name: NSRoutesConst.nameHome,
                builder: (context, state) => HomePage(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorFavorite,
            routes: [
              GoRoute(
                path: NSRoutesConst.pathFavorite,
                name: NSRoutesConst.nameFavorite,
                builder: (context, state) => FavoritePage(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorNotification,
            routes: [
              GoRoute(
                path: NSRoutesConst.pathNotification,
                name: NSRoutesConst.nameNotification,
                builder: (context, state) => NotificationsPage(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorProfile,
            routes: [
              GoRoute(
                path: NSRoutesConst.pathProfile,
                name: NSRoutesConst.nameProfile,
                builder: (context, state) => ProfilePage(
                  key: state.pageKey,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: NSRoutesConst.nameDetail,
        path: NSRoutesConst.pathDetail,
        builder: (context, state) {
          String tag = '';
          if (state.extra != null && state.extra is String) {
            tag = state.extra! as String;
          }
          return DetailPage(tag: tag);
        },
      ),
      GoRoute(
        name: NSRoutesConst.nameCart,
        path: NSRoutesConst.pathCart,
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        name: NSRoutesConst.nameCartInfo,
        path: NSRoutesConst.pathCartInfo,
        builder: (context, state) => const CartInfoProvider(),
      ),
      GoRoute(
        name: NSRoutesConst.nameSetting,
        path: NSRoutesConst.pathSetting,
        builder: (context, state) => const SettingPage(),
      ),
      GoRoute(
        name: NSRoutesConst.nameChangePassword,
        path: NSRoutesConst.pathChangePassword,
        builder: (context, state) => const ChangePasswordPage(),
      ),
    ],
  );
}
