import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileStarted extends ProfileEvent {
  ProfileStarted({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.avatar,
  });

  final String? name;
  final String? address;
  final String? phoneNumber;
  final String? avatar;

  @override
  List<Object?> get props => [name, address, phoneNumber, avatar];
}

class ProfileNameChanged extends ProfileEvent {
  ProfileNameChanged({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class ProfileAddressChanged extends ProfileEvent {
  ProfileAddressChanged({required this.address});

  final String address;

  @override
  List<Object?> get props => [address];
}

class ProfilePhoneChanged extends ProfileEvent {
  ProfilePhoneChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

class ProfileSavePressed extends ProfileEvent {
  ProfileSavePressed({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];
}

class ProfileAvatarChanged extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
