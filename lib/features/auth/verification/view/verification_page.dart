import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/components/otp/ns_otp_code.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/title_auth.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/title_label.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:responsive_builder/responsive_builder.dart';

class VerificationPage extends StatelessWidget {
  /// Screen verification page
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
            top: 23,
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: NsIconButton(
                onPressed: () => context.pop(),
                icon: SvgPicture.asset(
                  Assets.icons.icArrow,
                  width: getValueForScreenType(
                    context: context,
                    mobile: 24,
                    tablet: 28,
                  ),
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 11),
            TitleAuth(
              title: AppLocalizations.of(context).otpVerification,
              subTitle: AppLocalizations.of(context).pleaseCheckYourEmail,
            ),
            const SizedBox(height: 40),
            TitleLabel(text: AppLocalizations.of(context).otpCode),
            const NSOtpCode(),
            const SizedBox(height: 40),
            NSElevatedButton.text(
              onPressed: () {},
              text: AppLocalizations.of(context).verify,
            ),
          ],
        ),
      ),
    );
  }
}
