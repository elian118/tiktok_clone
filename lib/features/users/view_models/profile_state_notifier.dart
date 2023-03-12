import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileStateNotifier extends StateNotifier<Map<String, dynamic>> {
  ProfileStateNotifier() : super({'isEditMode': false});

  void setValue(key, value) {
    state = {...state, key: value};
  }
}

final editProvider =
    StateNotifierProvider<ProfileStateNotifier, Map<String, dynamic>>(
        (ref) => ProfileStateNotifier());
