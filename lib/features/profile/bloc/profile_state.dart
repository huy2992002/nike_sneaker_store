import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/user_model.dart';

enum ProfileSaveStatus { initial, loading, success, failure }

enum ProfileChangeProfileStatus {
  initial,
  avatarLoading,
  avatarSuccess,
  avatarFailure,
}

class ProfileState extends Equatable {
  const ProfileState({
    this.user,
    this.name = '',
    this.address = '',
    this.phoneNumber = '',
    this.avatar,
    this.fileImage,
    this.buttonStatus = ProfileSaveStatus.initial,
    this.avatarStatus = ProfileChangeProfileStatus.initial,
    this.canAction = false,
    this.message = '',
  });

  final UserModel? user;
  final String name;
  final String address;
  final String phoneNumber;
  final String? avatar;
  final File? fileImage;
  final ProfileChangeProfileStatus avatarStatus;
  final ProfileSaveStatus buttonStatus;
  final bool canAction;
  final String message;

  ProfileState copyWith({
    UserModel? user,
    String? name,
    String? address,
    String? phoneNumber,
    String? avatar,
    File? fileImage,
    ProfileChangeProfileStatus? avatarStatus,
    ProfileSaveStatus? buttonStatus,
    bool? canAction,
    String? message,
  }) {
    return ProfileState(
      user: user ?? this.user,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      fileImage: fileImage ?? this.fileImage,
      avatarStatus: avatarStatus ?? this.avatarStatus,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      canAction: canAction ?? this.canAction,
      message: this.message,
    );
  }

  @override
  List<Object?> get props => [
        name,
        address,
        phoneNumber,
        avatar,
        user,
        avatarStatus,
        buttonStatus,
        canAction,
        message
      ];
}
