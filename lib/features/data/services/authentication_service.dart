import 'package:capstone_pawfund_app/core/utils/debug_logger.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/shared_preferences_helper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class IAuthenticationService {
  Future<bool> checkJwtExpired();
}

class AuthenticationService extends IAuthenticationService {
  // kiểm tra hết hạn hay chưa
  // false là chưa hết hạn
  // true là hết hạn
  @override
  Future<bool> checkJwtExpired() async {
    try {
      String jwtToken = AuthPref.getToken();
      if (jwtToken.isNotEmpty) {
        var isExpired = _isExpired(jwtToken);
        if (!isExpired) {
          return false;
        } else {
          return true;
          // logout
          // return null
        }
      } else {
        DebugLogger.printLog("Failed to get jwtToken from SharedPreferences");
        return true;
      }
    } on Exception catch (e) {
      DebugLogger.printLog(e.toString());
      return true;
    }
  }

// true là hết hạn
// false là còn hạn
  bool _isExpired(String jwt) {
    final decoded = JwtDecoder.decode(jwt);
    final expiry = decoded['exp'];
    DateTime expiration = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
    final dateNow = DateTime.now();
    final check = expiration.isBefore(dateNow);
    return expiration.isBefore(dateNow);
  }
}
