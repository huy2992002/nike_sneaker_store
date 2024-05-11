import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';

class BackgroundOnboardingWelcome extends StatelessWidget {
  const BackgroundOnboardingWelcome({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Assets.images.imgSplashHightLight.path),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(Assets.images.imgSplashFunny.path),
              ),
              const SizedBox(height: 130),
              Center(
                child: Image.asset(
                  Assets.images.imgLogoNike.path,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class BackgroundOnboardingLetStart extends StatelessWidget {
  const BackgroundOnboardingLetStart({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(Assets.images.imgSplashHightLight.path),
                  const Spacer(),
                  Image.asset(Assets.images.imgSplashFunny.path),
                  const SizedBox(width: 30),
                ],
              ),
              const SizedBox(height: 250),
              Center(
                child: Image.asset(
                  Assets.images.imgLogoNike.path,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class BackgroundOnboardingPower extends StatelessWidget {
  const BackgroundOnboardingPower({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Assets.images.imgSplashHightLight.path),
              const SizedBox(height: 250),
              Center(
                child: Image.asset(
                  Assets.images.imgLogoNike.path,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
