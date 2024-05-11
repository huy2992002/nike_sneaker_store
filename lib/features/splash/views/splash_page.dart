import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/services/local/shared_pref.dart';
import 'package:nike_sneaker_store/services/local/shared_pref_services.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  /// Screen splash page
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _toPage();
    _changeBrightness();
  }

  void _changeBrightness() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          SharedPrefs.isDark ? Brightness.light : Brightness.dark,
    ));
  }

  Future<void> _toPage() async {
    await Future.delayed(const Duration(milliseconds: 2300), () {});
    if (!mounted) return;
    String? accessToken =
        await context.read<SharedPrefServices>().getAccessToken();
    if (accessToken == null) {
      if (SharedPrefs.isAccessed) {
        context.pushNamed(NSRoutesConst.nameSignIn);
      } else {
        SharedPrefs.isAccessed = true;
        context.push(NSRoutesConst.pathOnboarding);
      }
    } else {
      context.go(NSRoutesConst.pathHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.scrim,
      body: Center(
        child: Image.asset(Assets.images.imgLogo.path),
      ),
    );
  }
}
