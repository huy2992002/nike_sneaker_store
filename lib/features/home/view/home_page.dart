import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/app_bar/app_bar_home.dart';
import 'package:nike_sneaker_store/components/dialog/ns_dialog.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/components/text_form_field/ns_search_box.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_bloc.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_event.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_event.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_state.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_category.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_product.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_sale.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/title_home.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:nike_sneaker_store/utils/enum.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  /// The home Screen
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.offset;

      if (currentScroll >= maxScroll * 0.9) {
        context.read<HomeBloc>().add(HomeLoadMore(
              userId: context
                      .read<SupabaseServices>()
                      .supabaseClient
                      .auth
                      .currentUser
                      ?.id ??
                  '',
              types: [
                CategoryType.allShoes.name,
                CategoryType.outDoor.name,
                CategoryType.tennis.name,
              ],
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size);

    List<CategoryModel> _categories = [
      CategoryModel(
        name: AppLocalizations.of(context).allShoes,
        type: CategoryType.allShoes.name,
      ),
      CategoryModel(
        name: AppLocalizations.of(context).outDoor,
        type: CategoryType.outDoor.name,
      ),
      CategoryModel(
        name: AppLocalizations.of(context).tennis,
        type: CategoryType.tennis.name,
      ),
    ];

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
      body: Column(
        children: [
          BlocConsumer<CartBloc, CartState>(
            builder: (context, state) => AppBarHome(
              onMenu: deviceType == DeviceScreenType.mobile
                  ? () => context.read<ZoomDrawerController>().open?.call()
                  : null,
              isMarkerNotification:
                  context.read<CartBloc>().state.myCarts.isNotEmpty,
            ),
            listenWhen: (previous, current) =>
                previous.cartInsertStatus != current.cartInsertStatus,
            listener: (context, state) {
              if (state.cartInsertStatus == CartQuantityStatus.insertSuccess) {
                NSSnackBar.snackbarSuccess(
                  context,
                  title: AppLocalizations.of(context).productAddSuccess,
                );
              }
              if (state.cartInsertStatus == CartQuantityStatus.insertFailure) {
                NSSnackBar.snackbarError(
                  context,
                  title: context.read<CartBloc>().state.message,
                );
              }
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                String? id = context
                    .read<SupabaseServices>()
                    .supabaseClient
                    .auth
                    .currentUser
                    ?.id;
                if (id == null) return;
                context.read<HomeBloc>().add(HomeStarted(userId: id));
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: NSSearchBox(
                      onTap: () => context.push(NSRoutesConst.pathSearch),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TitleHome(text: AppLocalizations.of(context).selectCategory),
                  BlocConsumer<HomeBloc, HomeState>(
                    listenWhen: (previous, current) =>
                        previous.homeStatus != current.homeStatus ||
                        previous.loadStatus != current.loadStatus ||
                        previous.favoriteStatus != current.favoriteStatus,
                    listener: (context, state) {
                      if (state.homeStatus == HomeViewStatus.failure ||
                          state.favoriteStatus ==
                              HomeFavoriteStatus.favoriteFailure ||
                          state.loadStatus == HomeLoadMoreStatus.loadFailure) {
                        NSSnackBar.snackbarError(context,
                            title: state.errorMessage);
                      }
                    },
                    buildWhen: (previous, current) =>
                        previous.homeStatus != current.homeStatus ||
                        previous.productDisplays != current.productDisplays ||
                        previous.loadStatus != current.loadStatus ||
                        previous.favoriteStatus != current.favoriteStatus,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              itemCount: _categories.length,
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              itemBuilder: (context, index) {
                                final category = _categories[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: CardCategory(
                                    onPressed: state.homeStatus ==
                                            HomeViewStatus.loading
                                        ? null
                                        : () => context.read<HomeBloc>().add(
                                              HomeCategoryPressed(
                                                index: index,
                                                type: category.type,
                                              ),
                                            ),
                                    text: category.name,
                                    selected: state.categoryIndex == index,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          TitleHome(
                              text: AppLocalizations.of(context).popularShoes),
                          SizedBox(
                            height: getValueForScreenType(
                              context: context,
                              mobile: 200,
                              tablet: 230,
                            ),
                            child: state.homeStatus == HomeViewStatus.loading
                                ? ListView.separated(
                                    itemCount: 3,
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    itemBuilder: (context, index) {
                                      return const CardProductLoading();
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 20),
                                  )
                                : state.productDisplays.isEmpty
                                    ? Center(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .productNotFound,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : ListView.builder(
                                        controller: scrollController,
                                        itemCount: state.loadStatus ==
                                                HomeLoadMoreStatus.loadCompeted
                                            ? state.productDisplays.length
                                            : state.productDisplays.length + 1,
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        itemBuilder: (context, index) {
                                          if (index <
                                              state.productDisplays.length) {
                                            final product =
                                                state.productDisplays[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: CardProduct(
                                                tag: NSConstants.tagProductHome(
                                                    product.uuid ?? ''),
                                                product: product,
                                                onTap: () {
                                                  context.push(
                                                    NSRoutesConst.pathDetail,
                                                    extra: NSConstants
                                                        .tagProductHome(
                                                            product.uuid ?? ''),
                                                  );
                                                  context
                                                      .read<DetailBloc>()
                                                      .add(
                                                        DetailSelectStarted(
                                                          product: product,
                                                        ),
                                                      );
                                                },
                                                onAddCart: () {
                                                  if (userId != null) {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(CartInsertPressed(
                                                            userId: userId,
                                                            product: product));
                                                  } else {
                                                    NSSnackBar.snackbarError(
                                                      context,
                                                      title:
                                                          AppLocalizations.of(
                                                                  context)
                                                              .notFoundUser,
                                                    );
                                                  }
                                                },
                                                onFavorite: () {
                                                  if (!product.isFavorite) {
                                                    updateFavorite(
                                                        product.uuid);
                                                  } else {
                                                    NSDialog.dialogQuestion(
                                                      context,
                                                      title: AppLocalizations
                                                              .of(context)
                                                          .doYouWantCancelFavorite,
                                                      action: () =>
                                                          updateFavorite(
                                                              product.uuid),
                                                    );
                                                  }
                                                },
                                                constraints:
                                                    const BoxConstraints(
                                                  maxWidth: 153,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  TitleHome(
                    text: AppLocalizations.of(context).newArrivals,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CardSale(
                      title: AppLocalizations.of(context).summerSale,
                      discount: 50,
                      imagePath: Assets.images.imgSumerSale.path,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryModel {
  CategoryModel({required this.name, required this.type});
  String name;
  String type;
}
