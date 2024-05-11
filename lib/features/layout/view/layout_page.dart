import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_state.dart';
import 'package:nike_sneaker_store/features/layout/bloc/layout_cubit.dart';
import 'package:nike_sneaker_store/features/layout/view/menu_page.dart';
import 'package:nike_sneaker_store/features/layout/view/widgets/ns_bottom_navigation_bar.dart';
import 'package:nike_sneaker_store/features/layout/view/widgets/ns_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    void goBrach(int index) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    return BlocSelector<LayoutCubit, int, int>(
      selector: (state) => state,
      builder: (context, state) {
        return ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
              return NSDrawer(
                controller: context.read<ZoomDrawerController>(),
                menuScreen: const MenuPage(),
                mainScreen: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (details.primaryDelta == null) return;
                    if (details.primaryDelta! > 1) {
                      context.read<ZoomDrawerController>().open?.call();
                    }
                  },
                  child: LayoutHome(
                    currentIndex: state,
                    navigationShell: navigationShell,
                    onTap: (index) {
                      context.read<LayoutCubit>().onChangePage(index);
                      goBrach(index);
                    },
                  ),
                ),
              );
            } else {
              return ColoredBox(
                color: Theme.of(context).colorScheme.secondary,
                child: Row(
                  children: [
                    const Flexible(flex: 3, child: MenuPage()),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10)),
                          child: Scaffold(
                              body: navigationShell,
                              bottomNavigationBar: BlocSelector<HomeBloc,
                                  HomeState, HomeViewStatus>(
                                selector: (state) => state.homeStatus,
                                builder: (context, homeStatus) {
                                  return NSBottomNavigationBar(
                                    currentIndex: state,
                                    onChangedPage:
                                        homeStatus == HomeViewStatus.loading
                                            ? null
                                            : (index) {
                                                context
                                                    .read<LayoutCubit>()
                                                    .onChangePage(index);
                                                goBrach(index);
                                              },
                                  );
                                },
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}

class LayoutHome extends StatelessWidget {
  const LayoutHome({
    required this.navigationShell,
    this.currentIndex = 0,
    this.onTap,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationShell,
        bottomNavigationBar: BlocSelector<HomeBloc, HomeState, HomeViewStatus>(
          selector: (state) => state.homeStatus,
          builder: (context, homeStatus) {
            return NSBottomNavigationBar(
              currentIndex: currentIndex,
              onChangedPage: homeStatus == HomeViewStatus.loading
                  ? null
                  : (index) {
                      onTap?.call(index);
                    },
            );
          },
        ));
  }
}
