import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/components/app_bar/ns_app_bar.dart';
import 'package:nike_sneaker_store/components/button/ns_icon_button.dart';
import 'package:nike_sneaker_store/components/snackbar/ns_snackbar.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_bloc.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_event.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_state.dart';
import 'package:nike_sneaker_store/features/notification/view/widgets/card_notification.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NotificationsPage extends StatelessWidget {
  /// Screen display notifications
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? userId =
        context.read<SupabaseServices>().supabaseClient.auth.currentUser?.id;
    return Scaffold(
        appBar: NSAppBar(
          title: AppLocalizations.of(context).notifications,
          rightIcon: NsIconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              Assets.icons.icTrash,
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
        body: BlocConsumer<NotificationBloc, NotificationState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == NotificationViewStatus.failure) {
              NSSnackBar.snackbarError(context, title: state.message);
            }
          },
          buildWhen: (previous, current) =>
              previous.itemStatus != current.itemStatus ||
              previous.status != current.status ||
              previous.notifications != current.notifications,
          builder: (context, state) {
            return state.status == NotificationViewStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.notifications.isNotEmpty)
                          Text(
                            AppLocalizations.of(context).recent,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        const SizedBox(height: 16),
                        if (state.notifications.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              top: 250,
                              right: 30,
                            ),
                            child: Text(
                              AppLocalizations.of(context)
                                  .noFavoriteNotification,
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
                        else
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.notifications.length,
                              itemBuilder: (_, index) {
                                final notification = state.notifications[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: CardNotification(
                                    notification: notification,
                                    onTap: notification.isRead
                                        ? null
                                        : () {
                                            if (userId != null) {
                                              context
                                                  .read<NotificationBloc>()
                                                  .add(
                                                    NotificationReadPressed(
                                                      userId: userId,
                                                      notificationId:
                                                          notification.uuid,
                                                    ),
                                                  );
                                            } else {
                                              NSSnackBar.snackbarError(
                                                context,
                                                title:
                                                    AppLocalizations.of(context)
                                                        .notFoundUser,
                                              );
                                            }
                                          },
                                  ),
                                );
                              },
                            ),
                          )
                      ],
                    ),
                  );
          },
        ));
  }
}
