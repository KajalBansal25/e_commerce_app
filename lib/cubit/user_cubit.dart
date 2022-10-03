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
    fetchUser.then((userdata) {
      userData = userdata!;
      emit(UserLoaded(userdata: userdata));
    });
  }

  void updateUser({required Userdata u } ) async{
    Userdata? userDataTemp = await ApiService().putUserData(object: u);
if(userDataTemp!=null){
  emit(UserUpdate(userdata: userDataTemp));
}
else{
  print(" Emit data Moadal  :::::::::::::::");
}
  }

  void updateAddress({required Userdata ua})async{
    Userdata? userDataTemp=await ApiService().putUserData(object: ua);
    if(userDataTemp!=null){
      emit(UserUpdate(userdata: userDataTemp));
    }
    else{
      print(" Emit data Moadal  :::::::::::::::");
    }
  }

}
