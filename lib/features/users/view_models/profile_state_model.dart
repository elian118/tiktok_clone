import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileStateModel extends StateNotifier<Map<String, dynamic>> {
  ProfileStateModel() : super({'isEditMode': false});

  void setValue(key, value) {
    state = {...state, key: value};
  }
}

final editProvider =
    StateNotifierProvider<ProfileStateModel, Map<String, dynamic>>(
        (ref) => ProfileStateModel());
