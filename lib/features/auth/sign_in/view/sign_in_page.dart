import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/button/ns_text_button.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/components/text_form_field/ns_text_form_field.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_event.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_state.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/prompt_text.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/title_auth.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/widgets/title_label.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_event.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/repository/auth_repository.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/utils/enum.dart';
import 'package:nike_sneaker_store/utils/validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInProvider extends StatelessWidget {
  const SignInProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(context.read<AuthRepository>()),
      child: const SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  /// Screen sign in page
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  /// The [TextEditingController] of [TextFormField] email
  TextEditingController _emailController = TextEditingController();

  /// The [TextEditingController] of [TextFormField] password
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormSubmissionStatus.failure) {
          NSSnackBar.snackbarError(
            context,
            title: state.message ?? '',
          );
        }
        if (state.status == FormSubmissionStatus.success) {
          context.go(NSRoutesConst.pathHome);
          context.read<HomeBloc>().add(HomeStarted(
                userId: Supabase.instance.client.auth.currentUser?.id ?? '',
              ));
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
                  top: 80,
                  bottom: 20,
                ),
                children: [
                  TitleAuth(
                    title: AppLocalizations.of(context).helloAgain,
                    subTitle: AppLocalizations.of(context).fillYourDetails,
                  ),
                  const SizedBox(height: 54),
                  TitleLabel(text: AppLocalizations.of(context).emailAddress),
                  NSTextFormField.text(
                    controller: _emailController,
                    hintText: AppLocalizations.of(context).hintTextEmail,
                    onChanged: (value) => context
                        .read<SignInBloc>()
                        .add(SignInEmailChanged(email: value)),
                    validator: (value) =>
                        Validator.validatorEmail(context, value),
                    textInputAction: TextInputAction.next,
                    readOnly: isLoading,
                  ),
                  const SizedBox(height: 30),
                  TitleLabel(text: AppLocalizations.of(context).password),
                  NSTextFormField.password(
                    controller: _passwordController,
                    hintText: AppLocalizations.of(context).hintTextPassword,
                    onChanged: (value) => context
                        .read<SignInBloc>()
                        .add(SignInPasswordChanged(password: value)),
                    validator: (value) =>
                        Validator.validatorPassword(context, value),
                    textInputAction: TextInputAction.done,
                    readOnly: isLoading,
                    onFieldSubmitted: state.isValid
                        ? (_) => context.read<SignInBloc>().add(
                              SubmitSignInPressed(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: NsTextButton(
                      onPressed: () => context.push(
                        NSRoutesConst.pathForgotPass,
                      ),
                      text: AppLocalizations.of(context).recoveryPassword,
                    ),
                  ),
                  const SizedBox(height: 24),
                  NSElevatedButton.text(
                    onPressed: state.isValid
                        ? () => context.read<SignInBloc>().add(
                              SubmitSignInPressed(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            )
                        : null,
                    text: AppLocalizations.of(context).signIn,
                    backgroundColor: state.isValid
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceVariant,
                    textColor: state.isValid
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    isDisable: isLoading,
                  ),
                  const SizedBox(height: 70),
                  PromptText(
                    text: AppLocalizations.of(context).newUser,
                    title: AppLocalizations.of(context).createAccount,
                    onTap: isLoading
                        ? null
                        : () => context.push(NSRoutesConst.pathSignUp),
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
    _emailController.dispose();
    _passwordController.dispose();
  }
}
