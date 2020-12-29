import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';


class BioAuth {
  
  Future<bool> checkBio() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biometrics $e");
    }

    print("biometric is available: $canCheckBiometrics");

    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("Avalible Biomatrics: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    bool authenticated = false;
    
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Touch your finger on the sensor to login',
          useErrorDialogs: true,
          stickyAuth: false,
          iOSAuthStrings: IOSAuthMessages(
            cancelButton: 'cancel',
            goToSettingsButton: 'settings',
            goToSettingsDescription: 'Please set up your Touch ID.',
            lockOut: 'Please reenable your Touch ID'),
          androidAuthStrings:
              AndroidAuthMessages(signInTitle: "Login to HomePage"));
          
    } catch (e) {
      print("error using biometric auth: $e");
    }

    print("authenticated: $authenticated");

    if (authenticated) {
      return true;
    } else {
      return false;
    }
  }
}