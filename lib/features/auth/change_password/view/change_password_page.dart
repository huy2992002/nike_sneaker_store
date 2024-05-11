import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/components/text_form_field/ns_text_form_field.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/title_label.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/utils/validator.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChangePasswordPage extends StatelessWidget {
  /// Screen change password page
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// The [TextEditingController] of [TextFormField] current password
    TextEditingController currentPasswordController = TextEditingController();

    /// The [TextEditingController] of [TextFormField] new password
    TextEditingController newPasswordController = TextEditingController();

    /// The [TextEditingController] of [TextFormField] confirm password
    TextEditingController confirmPasswordController = TextEditingController();

    /// The global key check [Validator] in page
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: NSAppBar(
          title: AppLocalizations.of(context).changePassword,
          leftIcon: NsIconButton(
            onPressed: () => context.pop(),
            icon: SvgPicture.asset(
              Assets.icons.icArrow,
              width: getValueForScreenType(
                context: context,
                mobile: 24,
                tablet: 28,
              ),
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                top: 97,
              ),
              children: [
                TitleLabel(
                  text: AppLocalizations.of(context).currentPassword,
                ),
                NSTextFormField.password(
                  controller: currentPasswordController,
                  hintText: AppLocalizations.of(context).hintTextPassword,
                  validator: (value) =>
                      Validator.validatorPassword(context, value),
                ),
                const SizedBox(height: 41),
                TitleLabel(
                  text: AppLocalizations.of(context).newPassword,
                ),
                NSTextFormField.password(
                  controller: newPasswordController,
                  hintText: AppLocalizations.of(context).hintTextPassword,
                  validator: (value) =>
                      Validator.validatorPassword(context, value),
                ),
                const SizedBox(height: 41),
                TitleLabel(
                  text: AppLocalizations.of(context).confirmPassword,
                ),
                NSTextFormField.password(
                  controller: confirmPasswordController,
                  hintText: AppLocalizations.of(context).hintTextPassword,
                  validator: (value) => Validator.validatorConfirmPassword(
                    context,
                    value,
                    newPasswordController.text,
                  ),
                ),
                const SizedBox(height: 100),
                NSElevatedButton.text(
                  // onPressed: onSave,
                  text: AppLocalizations.of(context).saveNow,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
