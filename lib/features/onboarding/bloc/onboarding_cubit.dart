import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void onChangePage(int indexPage) {
    emit(indexPage);
  }
}
