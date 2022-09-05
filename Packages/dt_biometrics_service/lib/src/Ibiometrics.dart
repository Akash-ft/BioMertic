import 'package:biometrics/dt_biometric_service.dart';

abstract class IBiometrics {

  Future<AuthState> forceBiometricAuthentication() ;

  Future<AuthState> biometricAuthentication();

  Future<AvailableBioMetric> availableBioMetrics();
}
