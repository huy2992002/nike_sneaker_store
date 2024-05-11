import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/features/onboarding/view/widgets/onboarding_background.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';

class OnboardingPower extends StatelessWidget {
  const OnboardingPower({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BackgroundOnboardingPower(
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.2),
        child: Column(
          children: [
            Image.asset(
              Assets.images.imgPrOnboardPower.path,
              height: size.height * 0.3,
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context).youHavePowerTo,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context).thereAreManyBeautifulAttractive,
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
