import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/app_bar/action_icon_app_bar.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/components/text_form_field/ns_search_box.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_bloc.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_event.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_product.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_product_width.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_bloc.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_event.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_state.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/repository/product_repository.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:nike_sneaker_store/utils/debounce.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchProvider extends StatelessWidget {
  const SearchProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
        productRepository: context.read<ProductRepository>(),
      ),
      child: const SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /// The [TextEditingController] of [TextFormField] search
  TextEditingController _searchController = TextEditingController();

  Debounce debounce = Debounce(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    String? userId =
        context.read<SupabaseServices>().supabaseClient.auth.currentUser?.id;
    void onProduct(ProductModel product) {
      context.push(
        NSRoutesConst.pathDetail,
        extra: NSConstants.tagProductFavorite(product.uuid ?? ''),
      );

      context.read<DetailBloc>().add(
            DetailSelectStarted(
              product: product,
            ),
          );
    }

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: NSAppBar(
          title: AppLocalizations.of(context).search,
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
          rightIcon: ActionIconAppBar(
            isMarked: context.read<CartBloc>().state.myCarts.isNotEmpty,
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.searchProducts != current.searchProducts,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  NSSearchBox(
                    controller: _searchController,
                    onChanged: (value) {
                      debounce.run(() {
                        context
                            .read<SearchBloc>()
                            .add(SearchTextChanged(searchText: value));
                      });
                    },
                    isCancel: _searchController.text.isNotEmpty,
                    onCancel: () {
                      _searchController.clear();
                      context.read<SearchBloc>().add(RemoveTextPressed());
                    },
                  ),
                  const SizedBox(height: 18),
                  if (state.status == SearchViewStatus.loading)
                    const Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Expanded(
                      child: state.searchProducts.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 250),
                              child: Text(
                                _searchController.text.isEmpty
                                    ? AppLocalizations.of(context).searchProduct
                                    : AppLocalizations.of(context).isNoResult,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ResponsiveBuilder(
                              builder: (context, sizingInformation) {
                                if (sizingInformation.isMobile) {
                                  return GridView.builder(
                                    itemCount: state.searchProducts.length,
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 28),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
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
                                      final product =
                                          state.searchProducts[index];

                                      return Center(
                                        child: CardProduct(
                                          tag: NSConstants.tagProductSearch(
                                              product.uuid ?? ''),
                                          product: product,
                                          onTap: () => onProduct(product),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return ListView.separated(
                                    padding: const EdgeInsets.all(24),
                                    itemCount: state.searchProducts.length,
                                    itemBuilder: (context, index) {
                                      final product =
                                          state.searchProducts[index];

                                      return CardProductWith(
                                        tag: NSConstants.tagProductSearch(
                                            product.uuid ?? ''),
                                        product: product,
                                        onTap: () => onProduct(product),
                                        onAddCart: () {
                                          if (userId != null) {
                                            context.read<CartBloc>().add(
                                                CartInsertPressed(
                                                    userId: userId,
                                                    product: product));
                                          } else {
                                            NSSnackBar.snackbarError(
                                              context,
                                              title:
                                                  AppLocalizations.of(context)
                                                      .notFoundUser,
                                            );
                                          }
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 24),
                                  );
                                }
                              },
                            ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
}
