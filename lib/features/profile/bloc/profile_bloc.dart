import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_event.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_state.dart';
import 'package:nike_sneaker_store/models/user_model.dart';
import 'package:nike_sneaker_store/repository/user_repository.dart';
import 'package:nike_sneaker_store/services/handle_error/error_extension.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.userRepository, this.filePicker)
      : super(const ProfileState()) {
    on<ProfileStarted>(_onStarted);
    on<ProfileNameChanged>(_onNameChanged);
    on<ProfileAddressChanged>(_onAddressChanged);
    on<ProfilePhoneChanged>(_onPhoneChanged);
    on<ProfileSavePressed>(_onSaveInformation);
    on<ProfileAvatarChanged>(_onAvatarChanged);
  }

  final UserRepository userRepository;
  final FilePicker filePicker;

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    String? name = event.name;
    String? address = event.address;
    String? phoneNumber = event.phoneNumber;
    String? avatar = event.avatar;

    UserModel? user = UserModel(
      name: name,
      address: address,
      phone: phoneNumber,
    );

    emit(state.copyWith(
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      avatar: avatar,
      user: user,
    ));
  }

  Future<void> _onNameChanged(
    ProfileNameChanged event,
    Emitter<ProfileState> emit,
  ) async {
    bool canAction = isValid(
      name: event.name,
      address: state.address,
      phoneNumber: state.phoneNumber,
      file: state.fileImage,
      user: state.user,
    );

    emit(state.copyWith(
      name: event.name,
      canAction: canAction,
    ));
  }

  Future<void> _onAddressChanged(
    ProfileAddressChanged event,
    Emitter<ProfileState> emit,
  ) async {
    bool canAction = isValid(
      name: state.name,
      address: event.address,
      phoneNumber: state.phoneNumber,
      file: state.fileImage,
      user: state.user,
    );

    emit(state.copyWith(
      address: event.address,
      canAction: canAction,
    ));
  }

  Future<void> _onPhoneChanged(
    ProfilePhoneChanged event,
    Emitter<ProfileState> emit,
  ) async {
    bool canAction = isValid(
      name: state.name,
      address: state.address,
      phoneNumber: event.phoneNumber,
      file: state.fileImage,
      user: state.user,
    );

    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
      canAction: canAction,
    ));
  }

  Future<void> _onSaveInformation(
    ProfileSavePressed event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(buttonStatus: ProfileSaveStatus.loading));
    try {
      String? avatar = await userRepository.uploadAvatar(state.fileImage);
      await userRepository.updateInformationUser(
        UserModel(
          uuid: event.userId,
          name: state.name,
          address: state.address,
          phone: state.phoneNumber,
          avatar: avatar,
        ),
      );
      emit(state.copyWith(
        user: UserModel(
          name: state.name,
          address: state.address,
          phone: state.phoneNumber,
          avatar: avatar,
        ),
        canAction: false,
        buttonStatus: ProfileSaveStatus.success,
      ));
    } on DioException catch (e) {
      emit(state.copyWith(
        buttonStatus: ProfileSaveStatus.failure,
        message: e.getFailure().message,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        buttonStatus: ProfileSaveStatus.failure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        buttonStatus: ProfileSaveStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onAvatarChanged(
    ProfileAvatarChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(avatarStatus: ProfileChangeProfileStatus.avatarLoading),
    );
    final result = await filePicker.pickFiles(type: FileType.image);
    if (result != null) {
      File fileImage = File(result.files.single.path!);
      bool canAction = isValid(
        name: state.name,
        address: state.address,
        phoneNumber: state.phoneNumber,
        file: fileImage,
        user: state.user,
      );
      emit(
        state.copyWith(
          fileImage: fileImage,
          canAction: canAction,
          avatarStatus: ProfileChangeProfileStatus.avatarSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(avatarStatus: ProfileChangeProfileStatus.avatarFailure),
      );
    }
  }
}

bool isValid({
  required String name,
  required String address,
  required String phoneNumber,
  File? file,
  UserModel? user,
}) {
  return name.isNotEmpty &&
      address.isNotEmpty &&
      RegExp(NSConstants.phonePattern).hasMatch(phoneNumber) &&
      (name != user?.name ||
          address != user?.address ||
          phoneNumber != user?.phone ||
          file != null);
}
