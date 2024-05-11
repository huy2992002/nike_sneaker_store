import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/avatar/ns_image_network.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/button/ns_text_button.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/components/text_form_field/ns_text_form_field.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_event.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_bloc.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_event.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_state.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/resources/ns_color.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';

class ProfilePage extends StatelessWidget {
  /// Screen profile page
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// The [TextEditingController] of [TextFormField] name
    TextEditingController _nameController = TextEditingController();

    /// The [TextEditingController] of [TextFormField] location
    TextEditingController _addressController = TextEditingController();

    /// The [TextEditingController] of [TextFormField] phone
    TextEditingController _phoneController = TextEditingController();

    _nameController.text = context.read<ProfileBloc>().state.name;
    _addressController.text = context.read<ProfileBloc>().state.address;
    _phoneController.text = context.read<ProfileBloc>().state.phoneNumber;
    String? userId =
        context.read<SupabaseServices>().supabaseClient.auth.currentUser?.id;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: NSAppBar(
            title: AppLocalizations.of(context).profile,
            colorAppBar: Theme.of(context).colorScheme.surface,
          ),
          body: BlocConsumer<ProfileBloc, ProfileState>(
            listenWhen: (previous, current) =>
                previous.buttonStatus != current.buttonStatus,
            listener: (context, state) {
              if (state.buttonStatus == ProfileSaveStatus.success) {
                NSSnackBar.snackbarSuccess(
                  context,
                  title: AppLocalizations.of(context).informationChangedSuccess,
                );
                context.read<HomeBloc>().add(HomeUserChanged(
                      name: state.name,
                      address: state.address,
                      phone: state.phoneNumber,
                      avatar: state.user?.avatar,
                    ));
              }
              if (state.buttonStatus == ProfileSaveStatus.failure) {
                NSSnackBar.snackbarError(context,
                    title: AppLocalizations.of(context).selectImageSuccess);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                            height: 96,
                            width: 96,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(48),
                              child: state.fileImage == null
                                  ? state.avatar == null
                                      ? Image.asset(
                                          Assets.images.imgAvatar.path)
                                      : NSImageNetwork(
                                          path: state.avatar,
                                          fit: BoxFit.cover,
                                        )
                                  : Image.file(
                                      state.fileImage!,
                                      fit: BoxFit.cover,
                                    ),
                            )),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          state.user?.name ?? '',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: NsTextButton(
                          onPressed: state.avatarStatus ==
                                      ProfileChangeProfileStatus
                                          .avatarLoading ||
                                  state.buttonStatus ==
                                      ProfileSaveStatus.loading
                              ? null
                              : () => context
                                  .read<ProfileBloc>()
                                  .add(ProfileAvatarChanged()),
                          text:
                              AppLocalizations.of(context).changeProfilePicture,
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      const SizedBox(height: 27),
                      Text(
                        AppLocalizations.of(context).yourName,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 5),
                      NSTextFormField.text(
                        controller: _nameController,
                        hintText: AppLocalizations.of(context).yourName,
                        onChanged: (value) => context
                            .read<ProfileBloc>()
                            .add(ProfileNameChanged(name: value)),
                        textInputAction: TextInputAction.next,
                        readOnly:
                            state.buttonStatus == ProfileSaveStatus.loading,
                      ),
                      const SizedBox(height: 27),
                      Text(
                        AppLocalizations.of(context).location,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 5),
                      NSTextFormField.text(
                        controller: _addressController,
                        hintText: AppLocalizations.of(context).location,
                        onChanged: (value) => context
                            .read<ProfileBloc>()
                            .add(ProfileAddressChanged(address: value)),
                        textInputAction: TextInputAction.next,
                        readOnly:
                            state.buttonStatus == ProfileSaveStatus.loading,
                      ),
                      const SizedBox(height: 27),
                      Text(
                        AppLocalizations.of(context).mobileNumber,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 5),
                      NSTextFormField.text(
                        controller: _phoneController,
                        hintText: AppLocalizations.of(context).mobileNumber,
                        onChanged: (value) => context
                            .read<ProfileBloc>()
                            .add(ProfilePhoneChanged(phoneNumber: value)),
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        readOnly:
                            state.buttonStatus == ProfileSaveStatus.loading,
                        onFieldSubmitted: state.canAction
                            ? (_) {
                                if (userId != null) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(ProfileSavePressed(userId: userId));
                                } else {
                                  NSSnackBar.snackbarError(
                                    context,
                                    title: AppLocalizations.of(context)
                                        .notFoundUser,
                                  );
                                }
                              }
                            : null,
                      ),
                      const SizedBox(height: 34),
                      NSElevatedButton.text(
                        onPressed: state.canAction
                            ? () {
                                if (userId != null) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(ProfileSavePressed(userId: userId));
                                } else {
                                  NSSnackBar.snackbarError(
                                    context,
                                    title: AppLocalizations.of(context)
                                        .notFoundUser,
                                  );
                                }
                              }
                            : null,
                        text: AppLocalizations.of(context).saveNow,
                        backgroundColor: state.canAction
                            ? Theme.of(context).colorScheme.primary
                            : NSColor.neutral.withOpacity(0.3),
                        textColor: state.canAction
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                        isDisable:
                            state.buttonStatus == ProfileSaveStatus.loading,
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
