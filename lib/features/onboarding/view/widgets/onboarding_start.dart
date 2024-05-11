import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/features/onboarding/view/widgets/onboarding_background.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';

class OnboardingStart extends StatelessWidget {
  const OnboardingStart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BackgroundOnboardingLetStart(
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.2),
        child: Column(
          children: [
            Image.asset(
              Assets.images.imgPrOnboardLetStart.path,
              height: size.height * 0.3,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context).letStartJourney,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context).smartGorgeousFashionable,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
