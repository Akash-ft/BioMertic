library biometrics;

import 'package:biometrics/src/Ibiometrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

enum AvailableBioMetric {
  faceImage,
  fingerPrint,
  bothBioMetrics,
  pinAndPattern,
  exception,

}

enum AuthState { validUser, invalidUser, exception, enrollBiometrics }

class Biometrics implements IBiometrics {
  late final LocalAuthentication auth;

  Biometrics() {
    auth = LocalAuthentication();
  }

  @override
  Future<AuthState> forceBiometricAuthentication() async {
    try {
      final authenticate = await auth.authenticate(
        options: AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            sensitiveTransaction: true,
            biometricOnly: true),
        localizedReason: "Validating User",
      );
      return (authenticate == true)
          ? AuthState.validUser
          : AuthState.invalidUser;
    } on PlatformException catch (e) {
      debugPrint(e.code);
      if (e.code == " Required security features not enabled ") {
        return AuthState.enrollBiometrics;
      }
      return AuthState.exception;
    }
  }

  @override
  Future<AuthState> biometricAuthentication() async {
    try {
      final authenticate = await auth.authenticate(
        options: AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          sensitiveTransaction: true,
          biometricOnly: await auth.isDeviceSupported(),
        ),
        localizedReason: "Validating User",
      );
      return (authenticate == true)
          ? AuthState.validUser
          : AuthState.invalidUser;
    } on PlatformException catch (e) {
      debugPrint(e.message);
      if (e.code =="Required security features not enabled") {
        return AuthState.enrollBiometrics;
      }else {
        return AuthState.exception;
      }
    }
  }

  @override
  Future<AvailableBioMetric> availableBioMetrics() async {
    late List<BiometricType> availableBiometrics;
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      if (canCheckBiometrics == true) {
        try {

          availableBiometrics = await auth.getAvailableBiometrics();
          if (availableBiometrics.contains(BiometricType.face) &&
              availableBiometrics.contains(BiometricType.fingerprint)) {
            return AvailableBioMetric.bothBioMetrics;
          } else if (availableBiometrics.contains(BiometricType.face)) {
            return AvailableBioMetric.faceImage;
          } else {
            return AvailableBioMetric.fingerPrint;
          }
        } on PlatformException catch (e) {
          debugPrint(e.message);
          return AvailableBioMetric.exception;
        }
      } else {
        return AvailableBioMetric.pinAndPattern;
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return AvailableBioMetric.exception;
    }
  }
}
