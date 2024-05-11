import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/app_bar/action_icon_app_bar.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/avatar/ns_image_network.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_bloc.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_event.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_state.dart';
import 'package:nike_sneaker_store/features/detail/view/widgets/ns_read_more.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_event.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/resources/ns_color.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:nike_sneaker_store/utils/extension.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DetailPage extends StatelessWidget {
  /// Screen display detail of [ProductModel]

  const DetailPage({
    required this.tag,
    super.key,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size);
    return BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: NSAppBar(
          leftIcon: NsIconButton(
            onPressed: () => context.pop(),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            icon: SvgPicture.asset(
              Assets.icons.icArrow,
              width: getValueForScreenType(
                context: context,
                mobile: 24,
                tablet: 28,
              ),
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          title: 'Details',
          rightIcon: ActionIconAppBar(
            isMarked: context.read<CartBloc>().state.myCarts.isNotEmpty,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            top: 26,
            right: 20,
          ),
          children: [
            Text(
              state.productDisplay?.name ?? '',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.productDisplay?.category ?? '',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              state.productDisplay?.price?.toPriceDollar() ?? '',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Hero(
                tag: tag,
                child: NSImageNetwork(
                  path: state.productDisplay?.imagePath,
                  height: 120,
                  width: 200,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    (state.productDisplay?.productsInSameColor?.length ?? 0) > 5
                        ? 5
                        : state.productDisplay?.productsInSameColor?.length ??
                            0, (index) {
                  final productImage =
                      state.productDisplay?.productsInSameColor?[index];
                  return GestureDetector(
                    onTap: () => context.read<DetailBloc>().add(
                          DetailChangeProductPressed(
                              productImage: productImage),
                        ),
                    child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.only(right: 14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          border: state.productDisplay?.imagePath ==
                                  productImage
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: NSImageNetwork(
                          path: productImage,
                          width: 56,
                          height: 56,
                        )),
                  );
                }),
              ),
            ),
            const SizedBox(height: 30),
            NSReadMore(text: state.productDisplay?.description ?? '')
          ],
        ),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 27).copyWith(bottom: 40),
          child: Row(
            mainAxisAlignment: deviceType == DeviceScreenType.mobile
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  String? userId = context
                      .read<SupabaseServices>()
                      .supabaseClient
                      .auth
                      .currentUser
                      ?.id;
                  if (userId != null) {
                    context.read<DetailBloc>().add(DetailFavoritePressed());
                    context.read<HomeBloc>().add(
                          HomeFavoritePressed(
                            userId: userId,
                            productId: state.productDisplay?.uuid,
                          ),
                        );
                  } else {
                    NSSnackBar.snackbarError(
                      context,
                      title: AppLocalizations.of(context).notFoundUser,
                    );
                  }
                },
                child: CircleAvatar(
                  radius: getValueForScreenType(
                    context: context,
                    mobile: 26,
                    tablet: 30,
                  ),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: SvgPicture.asset(
                    state.productDisplay?.isFavorite ?? false
                        ? Assets.icons.icHeart
                        : Assets.icons.icHeartOutline,
                    width: getValueForScreenType(
                      context: context,
                      mobile: 26,
                      tablet: 30,
                    ),
                    color: state.productDisplay?.isFavorite ?? false
                        ? NSColor.favorite
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              NSElevatedButton.icon(
                onPressed: () {
                  String? userId = context
                      .read<SupabaseServices>()
                      .supabaseClient
                      .auth
                      .currentUser
                      ?.id;
                  if (userId != null && state.productDisplay != null) {
                    context.read<CartBloc>().add(
                          CartInsertPressed(
                              userId: userId, product: state.productDisplay!),
                        );
                  } else {
                    NSSnackBar.snackbarError(
                      context,
                      title: AppLocalizations.of(context).notFoundUser,
                    );
                  }
                },
                icon: SvgPicture.asset(
                  Assets.icons.icBag,
                  width: getValueForScreenType(
                    context: context,
                    mobile: 26,
                    tablet: 30,
                  ),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                text: AppLocalizations.of(context).addToCart,
              )
            ],
          ),
        ),
      );
    });
  }
}
