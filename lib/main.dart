import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_event.dart';
import 'package:nike_sneaker_store/features/layout/bloc/layout_cubit.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_bloc.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_event.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_bloc.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_event.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_bloc.dart';
import 'package:nike_sneaker_store/features/setting/bloc/setting_state.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/repository/auth_repository.dart';
import 'package:nike_sneaker_store/repository/product_repository.dart';
import 'package:nike_sneaker_store/repository/user_repository.dart';
import 'package:nike_sneaker_store/routes/ns_routes_config.dart';
import 'package:nike_sneaker_store/services/local/shared_pref.dart';
import 'package:nike_sneaker_store/services/local/shared_pref_services.dart';
import 'package:nike_sneaker_store/services/remote/api_client.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:nike_sneaker_store/themes/ns_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(desktop: 1024, tablet: 550, watch: 200),
  );

  await Supabase.initialize(
      url: NSConstants.urlSupabase, anonKey: NSConstants.apiKeySupabase);
  await SharedPrefs.initialization();

  runApp(const MyApp());
}

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SupabaseServices>(
            create: (context) => SupabaseServices(
              supabaseClient: Supabase.instance.client,
            ),
          ),
          RepositoryProvider<SharedPrefServices>(
            create: (context) => SharedPrefServices(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
          RepositoryProvider<ApiClient>(
            create: (context) => ApiClient(
              dio: Dio(),
              supabaseClient: Supabase.instance.client,
              prefs: context.read<SharedPrefServices>(),
            ),
          ),
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(
              supabaseServices: context.read<SupabaseServices>(),
              sharedPrefServices: context.read<SharedPrefServices>(),
            ),
          ),
          RepositoryProvider<ProductRepository>(
            create: (context) => ProductRepository(
              supabaseServices: context.read<SupabaseServices>(),
            ),
          ),
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(
              supabaseServices: context.read<SupabaseServices>(),
              apiClient: context.read<ApiClient>(),
            ),
          ),
          RepositoryProvider<ZoomDrawerController>(
            create: (context) => ZoomDrawerController(),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              context.read<ProductRepository>(),
              context.read<UserRepository>(),
            )..add(HomeStarted(
                userId: Supabase.instance.client.auth.currentUser?.id ?? '',
              )),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(
              context.read<ProductRepository>(),
              context.read<UserRepository>(),
            )..add(CartStarted(
                userId: Supabase.instance.client.auth.currentUser?.id ?? '',
              )),
          ),
          BlocProvider<SettingBloc>(create: (context) => SettingBloc()),
          BlocProvider<DetailBloc>(create: (context) => DetailBloc()),
          BlocProvider(create: (context) => LayoutCubit()),
          BlocProvider<NotificationBloc>(
            create: (context) => NotificationBloc(
              context.read<ProductRepository>(),
              context.read<UserRepository>(),
            )..add(NotificationStarted(
                userId: Supabase.instance.client.auth.currentUser?.id ?? '',
              )),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) =>
                ProfileBloc(context.read<UserRepository>(), FilePicker.platform)
                  ..add(ProfileStarted(
                    name: context.read<HomeBloc>().state.user?.name,
                    address: context.read<HomeBloc>().state.user?.address,
                    phoneNumber: context.read<HomeBloc>().state.user?.phone,
                    avatar: context.read<HomeBloc>().state.user?.avatar,
                  )),
          ),
        ],
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            NSTheme nsTheme = NSTheme();
            return MaterialApp.router(
              title: 'Nike Sneaker Store',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale,
              themeMode: state.themeMode,
              theme: nsTheme.lightTheme(context),
              darkTheme: nsTheme.darkTheme(context),
              routerConfig: NSRoutesConfig.goRoute,
              scaffoldMessengerKey: scaffoldMessengerKey,
            );
          },
        ));
  }
}
