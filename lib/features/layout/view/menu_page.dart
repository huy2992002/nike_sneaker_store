import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/components/avatar/ns_avatar.dart';
import 'package:nike_sneaker_store/components/avatar/ns_image_network.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/dialog/ns_dialog.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_state.dart';
import 'package:nike_sneaker_store/features/layout/bloc/layout_cubit.dart';
import 'package:nike_sneaker_store/features/layout/view/widgets/card_menu_item.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/routes/ns_routes_const.dart';
import 'package:nike_sneaker_store/services/local/shared_pref_services.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) => Column(
                    children: [
                      SizedBox(
                        width: 48 * 2,
                        height: 48 * 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(48),
                          child: state.user?.avatar == null
                              ? NSAvatar(
                                  imagePath: Assets.images.imgAvatar.path)
                              : NSImageNetwork(
                                  path: state.user?.avatar,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        state.user?.name ?? '-:-',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                CardMenuItem(
                  onTap: () {
                    context.read<LayoutCubit>().onChangePage(3);
                    context.push(NSRoutesConst.pathProfile);
                    context.read<ZoomDrawerController>().close?.call();
                  },
                  title: AppLocalizations.of(context).profile,
                  iconPath: Assets.icons.icPerson,
                ),
                const SizedBox(height: 30),
                CardMenuItem(
                  onTap: () => context.push(NSRoutesConst.pathCart),
                  title: AppLocalizations.of(context).myCart,
                  iconPath: Assets.icons.icBag,
                ),
                const SizedBox(height: 30),
                CardMenuItem(
                  onTap: () {
                    context.read<LayoutCubit>().onChangePage(1);
                    context.push(NSRoutesConst.pathFavorite);
                    context.read<ZoomDrawerController>().close?.call();
                  },
                  title: AppLocalizations.of(context).favorite,
                  iconPath: Assets.icons.icHeartOutline,
                ),
                const SizedBox(height: 30),
                CardMenuItem(
                  onTap: () {
                    context.read<LayoutCubit>().onChangePage(2);
                    context.push(NSRoutesConst.pathNotification);
                    context.read<ZoomDrawerController>().close?.call();
                  },
                  title: AppLocalizations.of(context).notifications,
                  iconPath: Assets.icons.icNotification,
                ),
                const SizedBox(height: 30),
                CardMenuItem(
                  onTap: () => context.push(NSRoutesConst.pathSetting),
                  title: AppLocalizations.of(context).setting,
                  iconPath: Assets.icons.icSetting,
                ),
              ],
            ),
          ),
          const Spacer(),
          Divider(
            thickness: 1,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14).copyWith(left: 28),
            child: CardMenuItem(
              onTap: () {
                NSDialog.dialog(
                  context,
                  content: Text(AppLocalizations.of(context).doYouWantLogout),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        NSElevatedButton.text(
                          onPressed: () => context.pop(),
                          text: AppLocalizations.of(context).no,
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          textColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 14),
                        NSElevatedButton.text(
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                context
                                    .read<SupabaseServices>()
                                    .supabaseClient
                                    .auth
                                    .signOut();
                                context
                                    .read<SharedPrefServices>()
                                    .removeToken();
                                context.go(NSRoutesConst.pathSignIn);
                              },
                            );
                            context.pop();
                          },
                          text: AppLocalizations.of(context).yes,
                        ),
                      ],
                    ),
                  ],
                );
              },
              title: AppLocalizations.of(context).signOut,
              iconPath: Assets.icons.icSignOut,
            ),
          ),
        ],
      ),
    );
  }
}
