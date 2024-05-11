import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_bloc.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_event.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_state.dart';
import 'package:nike_sneaker_store/models/user_model.dart';
import 'package:nike_sneaker_store/repository/user_repository.dart';

import '../../repository/mock_user_repository.dart';
import '../../utils/mock_file_picker.dart';

void main() {
  late UserRepository userRepository;
  late ProfileBloc profileBloc;
  late FilePicker filePicker;

  setUp(() {
    filePicker = MockFilePicker();
    userRepository = MockUserRepository();
    profileBloc = ProfileBloc(userRepository, filePicker);
  });

  group('Profile Bloc ', () {
    test('initial state is Profile State', () {
      expect(profileBloc.state, equals(const ProfileState()));
    });

    blocTest(
      'emits information when started ',
      build: () => profileBloc,
      act: (bloc) {
        bloc.add(ProfileStarted(
          name: 'name',
          address: 'address',
          phoneNumber: 'phoneNumber',
          avatar: 'avatar',
        ));
      },
      expect: () => [
        ProfileState(
            name: 'name',
            address: 'address',
            phoneNumber: 'phoneNumber',
            avatar: 'avatar',
            user: UserModel(
              name: 'name',
              address: 'address',
              phone: 'phoneNumber',
            )),
      ],
    );

    blocTest(
      'emits address when address changed',
      build: () => profileBloc,
      seed: () => const ProfileState(address: 'address'),
      act: (bloc) {
        bloc.add(ProfileAddressChanged(address: 'new address'));
      },
      expect: () => [
        const ProfileState(address: 'new address'),
      ],
    );

    blocTest(
      'emits name when name changed',
      build: () => profileBloc,
      seed: () => const ProfileState(name: 'name2'),
      act: (bloc) {
        bloc.add(ProfileNameChanged(name: 'new name'));
      },
      expect: () => [
        const ProfileState(name: 'new name'),
      ],
    );

    blocTest(
      'emits phone when phone changed',
      build: () => profileBloc,
      seed: () => const ProfileState(phoneNumber: 'phone'),
      act: (bloc) {
        bloc.add(ProfilePhoneChanged(phoneNumber: 'new phone'));
      },
      expect: () => [
        const ProfileState(phoneNumber: 'new phone'),
      ],
    );

    blocTest(
      'emits information when save',
      build: () => profileBloc,
      seed: () => const ProfileState(
        name: 'name',
        address: 'address',
        phoneNumber: 'phone',
      ),
      act: (bloc) {
        bloc.add(ProfileSavePressed(userId: 'userId'));
      },
      expect: () => [
        const ProfileState(
          buttonStatus: ProfileSaveStatus.loading,
          name: 'name',
          address: 'address',
          phoneNumber: 'phone',
        ),
        ProfileState(
            name: 'name',
            address: 'address',
            phoneNumber: 'phone',
            user: UserModel(
              name: 'name',
              address: 'address',
              phone: 'phone',
              avatar: '',
            ),
            buttonStatus: ProfileSaveStatus.success),
      ],
    );

    blocTest(
      'emits message error when save failure',
      build: () => profileBloc,
      seed: () => const ProfileState(
        name: 'name',
        address: 'address',
        phoneNumber: 'phone',
      ),
      act: (bloc) {
        bloc.add(ProfileSavePressed(userId: ''));
      },
      expect: () => [
        const ProfileState(
          buttonStatus: ProfileSaveStatus.loading,
          name: 'name',
          address: 'address',
          phoneNumber: 'phone',
        ),
        const ProfileState(
          name: 'name',
          address: 'address',
          phoneNumber: 'phone',
          buttonStatus: ProfileSaveStatus.failure,
        ),
      ],
    );

    blocTest(
      'emits [avatarLoading, avatarSuccess] when file picking succeeds',
      build: () => profileBloc,
      act: (bloc) {
        bloc.add(ProfileAvatarChanged());
      },
      expect: () => [
        const ProfileState(
            avatarStatus: ProfileChangeProfileStatus.avatarLoading),
        ProfileState(
          fileImage: File('name.path'),
          avatarStatus: ProfileChangeProfileStatus.avatarSuccess,
        ),
      ],
    );
  });
}
