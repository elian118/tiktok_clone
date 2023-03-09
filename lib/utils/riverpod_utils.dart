// 전역 상태 변경
import 'package:flutter_riverpod/flutter_riverpod.dart';

void setMState<T>(WidgetRef ref, StateProvider state, T newValue) =>
    ref.read(state.notifier).update((state) => newValue);
