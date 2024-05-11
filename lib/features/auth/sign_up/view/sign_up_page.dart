import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/components/dialog/ns_dialog.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/components/text_form_field/ns_text_form_field.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/prompt_text.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/title_auth.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/title_label.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_event.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_state.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/repository/auth_repository.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/utils/enum.dart';
import 'package:nike_sneaker_store/utils/validator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpProvider extends StatelessWidget {
  const SignUpProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(context.read<AuthRepository>()),
      child: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  /// Screen sign up page
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  /// The [TextEditingController] of [TextFormField] name
  TextEditingController _nameController = TextEditingController();

  /// The [TextEditingController] of [TextFormField] email
  TextEditingController _emailController = TextEditingController();

  /// The [TextEditingController] of [TextFormField] password
  TextEditingController _passwordController = TextEditingController();

  /// The [TextEditingController] of [TextFormField] confirm password
  TextEditingController _confirmController = TextEditingController();

  Future<void> _launchGmail() async {
    Uri uri = Uri.parse(NSConstants.pathGmail);
    if (!await launchUrl(uri)) {
      NSSnackBar.snackbarError(
        context,
        title: AppLocalizations.of(context).couldNotLaunchGmail,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormSubmissionStatus.failure) {
          NSSnackBar.snackbarError(
            context,
            title: state.message ?? '',
          );
        }
        if (state.status == FormSubmissionStatus.success) {
          NSDialog.dialog(
            context,
            title: SvgPicture.asset(
              Assets.icons.icEmailSend,
              height: 100,
            ),
            content: Text(
              AppLocalizations.of(context).pleaseCheckYourEmail,
              textAlign: TextAlign.center,
            ),
            actions: [
              Column(
                children: [
                  NSElevatedButton.text(
                    onPressed: _launchGmail,
                    text: AppLocalizations.of(context).goToEmail,
                  ),
                  const SizedBox(height: 14),
                  NSElevatedButton.text(
                    onPressed: () => context.push(NSRoutesConst.pathSignIn),
                    textColor: Theme.of(context).colorScheme.onBackground,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    text: AppLocalizations.of(context).goToSignIn,
                  ),
                ],
              ),
            ],
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.isValid != current.isValid ||
          previous.status != current.status,
      builder: (context, state) {
        bool isLoading = state.status == FormSubmissionStatus.loading;
        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                  top: 16,
                  bottom: 20,
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
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  TitleAuth(
                    title: AppLocalizations.of(context).registerAccount,
                    subTitle: AppLocalizations.of(context).fillYourDetails,
                  ),
                  const SizedBox(height: 32),
                  TitleLabel(text: AppLocalizations.of(context).yourName),
                  NSTextFormField.text(
                    controller: _nameController,
                    hintText: AppLocalizations.of(context).hintTextDefault,
                    onChanged: (value) => context.read<SignUpBloc>().add(
                          SignUpNameChanged(name: value),
                        ),
                    validator: (value) =>
                        Validator.validatorRequired(context, value),
                    textInputAction: TextInputAction.next,
                    readOnly: isLoading,
                  ),
                  const SizedBox(height: 14),
                  TitleLabel(text: AppLocalizations.of(context).emailAddress),
                  NSTextFormField.text(
                    controller: _emailController,
                    hintText: AppLocalizations.of(context).hintTextEmail,
                    onChanged: (value) => context.read<SignUpBloc>().add(
                          SignUpEmailChanged(email: value),
                        ),
                    validator: (value) =>
                        Validator.validatorEmail(context, value),
                    textInputAction: TextInputAction.next,
                    readOnly: isLoading,
                  ),
                  const SizedBox(height: 14),
                  TitleLabel(text: AppLocalizations.of(context).password),
                  NSTextFormField.password(
                    controller: _passwordController,
                    hintText: AppLocalizations.of(context).hintTextPassword,
                    onChanged: (value) => context.read<SignUpBloc>().add(
                          SignUpPasswordChanged(password: value),
                        ),
                    validator: (value) =>
                        Validator.validatorPassword(context, value),
                    textInputAction: TextInputAction.next,
                    readOnly: isLoading,
                  ),
                  const SizedBox(height: 14),
                  TitleLabel(
                      text: AppLocalizations.of(context).confirmPassword),
                  NSTextFormField.password(
                    controller: _confirmController,
                    hintText: AppLocalizations.of(context).hintTextPassword,
                    onChanged: (value) => context.read<SignUpBloc>().add(
                          SignUpConfirmPasswordChanged(
                            confirmPassword: value,
                          ),
                        ),
                    validator: (value) => Validator.validatorConfirmPassword(
                      context,
                      value,
                      _passwordController.text,
                    ),
                    textInputAction: TextInputAction.done,
                    readOnly: isLoading,
                    onFieldSubmitted: state.isValid
                        ? (_) => context.read<SignUpBloc>().add(
                              SubmitSignUpPressed(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            )
                        : null,
                  ),
                  const SizedBox(height: 20),
                  NSElevatedButton.text(
                    onPressed: state.isValid
                        ? () => context.read<SignUpBloc>().add(
                              SubmitSignUpPressed(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            )
                        : null,
                    text: AppLocalizations.of(context).signUp,
                    backgroundColor: state.isValid
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceVariant,
                    textColor: state.isValid
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    isDisable: isLoading,
                  ),
                  const SizedBox(height: 50),
                  PromptText(
                    text: AppLocalizations.of(context).alreadyAccount,
                    title: AppLocalizations.of(context).signIn,
                    onTap: isLoading
                        ? null
                        : () => context.push(NSRoutesConst.pathSignIn),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
  }
}
