import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/components/dialog/ns_dialog.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/features/cart/view/widgets/cart_information_item.dart';
import 'package:nike_sneaker_store/features/cart/view/widgets/cart_total_cost.dart';
import 'package:nike_sneaker_store/features/cart_information/bloc/cart_info_bloc.dart';
import 'package:nike_sneaker_store/features/cart_information/bloc/cart_info_event.dart';
import 'package:nike_sneaker_store/features/cart_information/bloc/cart_info_state.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CartInfoProvider extends StatelessWidget {
  const CartInfoProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartInfoBloc>(
      create: (context) => CartInfoBloc(),
      child: const CartInformationPage(),
    );
  }
}

class CartInformationPage extends StatelessWidget {
  const CartInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _addressController = TextEditingController();
    FocusNode _focusNodeEmail = FocusNode();
    FocusNode _focusNodePhone = FocusNode();
    FocusNode _addressNode = FocusNode();

    String? userId =
        context.read<SupabaseServices>().supabaseClient.auth.currentUser?.id;

    _emailController.text = context
            .read<SupabaseServices>()
            .supabaseClient
            .auth
            .currentUser
            ?.email ??
        '';
    _phoneController.text = context.read<HomeBloc>().state.user?.phone ?? '';
    _addressController.text =
        context.read<HomeBloc>().state.user?.address ?? '';

    context.read<CartInfoBloc>().add(CartInfoStarted(
          email: _emailController.text,
          phoneNumber: _phoneController.text,
          address: _addressController.text,
        ));
    return BlocBuilder<CartInfoBloc, CartInfoState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: NSAppBar(
              title: AppLocalizations.of(context).myCart,
              leftIcon: NsIconButton(
                onPressed: () => context.pop(),
                icon: SvgPicture.asset(
                  Assets.icons.icArrow,
                  width: getValueForScreenType(
                    context: context,
                    mobile: 24,
                    tablet: 28,
                  ),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 46,
                right: 20,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).contactInformation,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    CartInformationItem(
                      controller: _emailController,
                      iconPath: Assets.icons.icEmail,
                      label: AppLocalizations.of(context).emailAddress,
                      onEdit: _focusNodeEmail.requestFocus,
                      focusNode: _focusNodeEmail,
                      onChanged: (value) => context
                          .read<CartInfoBloc>()
                          .add(CartInfoEmailChanged(email: value)),
                      readOnly:
                          state.status == CartCheckOutStatus.checkoutLoading,
                    ),
                    const SizedBox(height: 16),
                    CartInformationItem(
                      controller: _phoneController,
                      iconPath: Assets.icons.icPhone,
                      label: AppLocalizations.of(context).phone,
                      onEdit: _focusNodePhone.requestFocus,
                      focusNode: _focusNodePhone,
                      keyboardType: TextInputType.phone,
                      readOnly:
                          state.status == CartCheckOutStatus.checkoutLoading,
                      onChanged: (value) => context
                          .read<CartInfoBloc>()
                          .add(CartInfoPhoneChanged(phoneNumber: value)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context).address,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _addressController,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                            onChanged: (value) => context
                                .read<CartInfoBloc>()
                                .add(CartInfoAddressChanged(address: value)),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              border: InputBorder.none,
                            ),
                            focusNode: _addressNode,
                            readOnly: state.status ==
                                CartCheckOutStatus.checkoutLoading,
                          ),
                        ),
                        GestureDetector(
                          onTap: _addressNode.requestFocus,
                          child: SvgPicture.asset(Assets.icons.icEdit),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BlocConsumer<CartBloc, CartState>(
              listenWhen: (previous, current) =>
                  previous.cartCheckoutStatus != current.cartCheckoutStatus,
              listener: (context, stateCart) {
                if (stateCart.cartCheckoutStatus ==
                    CartEventCheckOutStatus.checkoutFailure) {
                  NSSnackBar.snackbarError(context, title: stateCart.message);
                }
                if (stateCart.cartCheckoutStatus ==
                    CartEventCheckOutStatus.checkoutSuccess) {
                  NSDialog.dialog(
                    context,
                    title: Center(
                      child: CircleAvatar(
                          radius: 65,
                          child:
                              Image.asset(Assets.images.imgSuccessfully.path)),
                    ),
                    content: Text(
                      AppLocalizations.of(context).yourPaymentSuccessful,
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      NSElevatedButton.text(
                        onPressed: () => context.go(NSRoutesConst.pathHome),
                        text: AppLocalizations.of(context).backToShopping,
                      )
                    ],
                  );
                }
              },
              buildWhen: (previous, current) =>
                  previous.cartCheckoutStatus != current.cartCheckoutStatus,
              builder: (context, stateCart) {
                return CartTotalCost(
                  onCheckout: () {
                    if (userId != null) {
                      context.read<CartBloc>().add(
                            CartCheckoutPressed(userId: userId),
                          );
                    } else {
                      NSSnackBar.snackbarError(
                        context,
                        title: AppLocalizations.of(context).notFoundUser,
                      );
                    }
                  },
                  canCheckOut: state.canAction,
                  isDisable: stateCart.cartCheckoutStatus ==
                      CartEventCheckOutStatus.checkoutLoading,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
