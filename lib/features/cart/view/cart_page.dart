import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/components/dialog/ns_dialog.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/features/cart/view/widgets/card_cart_product.dart';
import 'package:nike_sneaker_store/features/cart/view/widgets/cart_total_cost.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CartPage extends StatelessWidget {
  /// Screen display my carts
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? userId =
        context.read<SupabaseServices>().supabaseClient.auth.currentUser?.id;
    return BlocConsumer<CartBloc, CartState>(
      listenWhen: (previous, current) =>
          previous.cartInsertStatus != current.cartInsertStatus,
      listener: (context, state) {
        if (state.cartInsertStatus == CartQuantityStatus.decrementFailure) {
          NSSnackBar.snackbarWarning(
            context,
            title: AppLocalizations.of(context).productHaveBeenRemove,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: NSAppBar(
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
            title: AppLocalizations.of(context).myCart,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: state.myCarts.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context).cartEmpty,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SlidableAutoCloseBehavior(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)
                              .intItem(state.myCarts.length),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 8),
                            itemCount: state.myCarts.length,
                            itemBuilder: (_, index) {
                              final product = state.myCarts[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: const ScrollMotion(),
                                    children: [
                                      const SizedBox(width: 8),
                                      SlidableAction(
                                        onPressed: (_) {
                                          NSDialog.dialogQuestion(
                                            context,
                                            title: AppLocalizations.of(context)
                                                .doYouWantRemoveFromCart,
                                            action: () {
                                              if (userId != null ||
                                                  product.uuid != null) {
                                                context.read<CartBloc>().add(
                                                      CartRemovePressed(
                                                        userId: userId!,
                                                        product: product,
                                                      ),
                                                    );
                                              }
                                            },
                                          );
                                        },
                                        icon: Icons.remove_circle_outline_sharp,
                                        backgroundColor:
                                            Theme.of(context).colorScheme.error,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ],
                                  ),
                                  child: CardCartProduct(
                                    product: product,
                                    onPlus: () {
                                      if (userId != null) {
                                        context.read<CartBloc>().add(
                                              CartIncrementPressed(
                                                userId: userId,
                                                product: product,
                                              ),
                                            );
                                      } else {
                                        NSSnackBar.snackbarError(
                                          context,
                                          title: AppLocalizations.of(context)
                                              .notFoundUser,
                                        );
                                      }
                                    },
                                    onLess: () {
                                      if (userId != null) {
                                        context.read<CartBloc>().add(
                                              CartDecrementPressed(
                                                userId: userId,
                                                product: product,
                                              ),
                                            );
                                      } else {
                                        NSSnackBar.snackbarError(
                                          context,
                                          title: AppLocalizations.of(context)
                                              .notFoundUser,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          bottomNavigationBar: CartTotalCost(
            onCheckout: () => context.push(NSRoutesConst.pathCartInfo),
            canCheckOut: state.myCarts.isNotEmpty,
          ),
        );
      },
    );
  }
}
