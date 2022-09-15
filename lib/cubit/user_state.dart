// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final Userdata userdata;
  const UserLoaded({
    required this.userdata,
  });
}
