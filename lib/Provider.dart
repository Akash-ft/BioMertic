import 'package:biometrics/dt_biometric_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final biometricProvider = Provider((ref) => Biometrics());

final biometricAuthentication = FutureProvider((ref) async {
  final biometrics =
      await ref.read(biometricProvider).biometricAuthentication();
  return biometrics;
});

final availableBioMetrics = FutureProvider((ref) async {
  final biometrics = await ref.read(biometricProvider).availableBioMetrics();
  return biometrics;
});

final biometricAuthenticationStateProvider = StateProvider((ref) {
  final biometricState = ref.watch(biometricAuthentication);
  return biometricState;
});

final availableBioMetricStateProvider = StateProvider((ref) {
  final availablebiometricState = ref.watch(availableBioMetrics);
  return availablebiometricState;
});


// final  userStateNotifier = StateNotifierProvider<UserStateNotifier , AuthState>((ref) {
//   return UserStateNotifier();
// });
//
//
// class UserStateNotifier extends StateNotifier<AuthState> {
//   UserStateNotifier() : super(AuthState.invalidUser);
//
//   AuthState userState(){
//     return state;
//   }
//
//   void updateState(AuthState model) {
//     state = model;
//   }
// }
