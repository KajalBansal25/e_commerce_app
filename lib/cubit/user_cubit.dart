// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:equatable/equatable.dart';

import 'package:e_commerce_app/model/user_data_modal.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  Userdata userData = Userdata();
  final Future<Userdata?> fetchUser = ApiService().getUserData();
  UserCubit() : super(UserInitial());

  void getUser() {
    fetchUser.then((userdata) => emit(UserLoaded(userdata: userdata!)));
  }
}
