import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_bloc.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_event.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_state.dart';

import '../../utils/mock_data.dart';

void main() {
  late DetailBloc detailBloc;

  setUp(() {
    detailBloc = DetailBloc();
  });

  test('initial state is Detail Bloc', () {
    expect(detailBloc.state, equals(const DetailState()));
  });

  blocTest(
    'emit display product when started',
    build: () => detailBloc,
    act: (bloc) {
      bloc.add(DetailSelectStarted(product: MockData.mockProduct));
    },
    expect: () => [
      DetailState(
        productDisplay: MockData.mockProduct,
      ),
    ],
  );

  blocTest(
    'emit changed image product when on pressed',
    build: () => detailBloc,
    seed: () => DetailState(productDisplay: MockData.mockProduct),
    act: (bloc) {
      bloc.add(DetailChangeProductPressed(productImage: 'image2'));
    },
    expect: () => [
      DetailState(
        productDisplay: MockData.mockProduct,
        status: DetailViewStatus.changeColorLoading,
      ),
      DetailState(
          productDisplay: MockData.mockProduct.copyWith(imagePath: 'image2'),
          status: DetailViewStatus.changeColorSuccess),
    ],
  );

  blocTest(
    'emit isFavorite when pressed favorite',
    build: () => detailBloc,
    seed: () => DetailState(
        productDisplay: MockData.mockProduct.copyWith(isFavorite: false)),
    act: (bloc) {
      bloc.add(DetailFavoritePressed());
    },
    expect: () => [
      DetailState(
        productDisplay: MockData.mockProduct.copyWith(isFavorite: true),
      )
    ],
  );
}
