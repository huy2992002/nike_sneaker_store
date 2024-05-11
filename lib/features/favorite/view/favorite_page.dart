import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/app_bar/action_icon_app_bar.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/dialog/ns_dialog.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_bloc.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_event.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_event.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_state.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_product.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FavoritePage extends StatefulWidget {
  /// Screen display favorite products
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    String? userId =
        context.read<SupabaseServices>().supabaseClient.auth.currentUser?.id;

    void updateFavorite(String? productId) {
      if (userId != null) {
        context.read<HomeBloc>().add(
              HomeFavoritePressed(
                userId: userId,
                productId: productId,
              ),
            );
      } else {
        NSSnackBar.snackbarError(
          context,
          title: AppLocalizations.of(context).notFoundUser,
        );
      }
    }

    return Scaffold(
      appBar: NSAppBar(
        title: AppLocalizations.of(context).favorite,
        rightIcon: ActionIconAppBar(
          isMarked: context.read<CartBloc>().state.myCarts.isNotEmpty,
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) =>
            previous.homeStatus != current.homeStatus,
        listener: (context, state) {
          if (state.homeStatus == HomeViewStatus.failure) {
            NSSnackBar.snackbarError(context, title: state.errorMessage);
          }
        },
        builder: (context, state) {
          final favoriteProducts =
              state.products.where((e) => e.isFavorite == true).toList();
          return favoriteProducts.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 250,
                    right: 30,
                  ),
                  child: Text(
                    AppLocalizations.of(context).noFavoriteProduct,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
              : GridView.builder(
                  itemCount: favoriteProducts.length,
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 28,
                    right: 20,
                    bottom: 28,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getValueForScreenType<int>(
                      context: context,
                      mobile: 2,
                      tablet: 3,
                      desktop: 4,
                    ),
                    mainAxisSpacing: getValueForScreenType(
                      context: context,
                      mobile: 24,
                      tablet: 16,
                    ),
                    crossAxisSpacing: getValueForScreenType(
                      context: context,
                      mobile: 24,
                      tablet: 16,
                    ),
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (_, index) {
                    final product = favoriteProducts[index];
                    return Center(
                      child: CardProduct(
                        tag: NSConstants.tagProductFavorite(product.uuid ?? ''),
                        product: product,
                        onFavorite: () {
                          if (!product.isFavorite) {
                            updateFavorite(product.uuid);
                          } else {
                            NSDialog.dialogQuestion(
                              context,
                              title: AppLocalizations.of(context)
                                  .doYouWantCancelFavorite,
                              action: () => updateFavorite(product.uuid),
                            );
                          }
                        },
                        onTap: () {
                          context.push(
                            NSRoutesConst.pathDetail,
                            extra: NSConstants.tagProductFavorite(
                                product.uuid ?? ''),
                          );
                          context.read<DetailBloc>().add(
                                DetailSelectStarted(
                                  product: product,
                                ),
                              );
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
