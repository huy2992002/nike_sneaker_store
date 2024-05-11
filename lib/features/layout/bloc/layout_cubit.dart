import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<int> {
  LayoutCubit() : super(0);
  
  void onChangePage(int indexPage) {
    emit(indexPage);
  }
}
