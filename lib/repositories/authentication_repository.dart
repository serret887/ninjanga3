import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/access_token.dart';
import 'package:ninjanga3/infrastructure/tracktv/models/device_code_oauth.dart';
import 'package:ninjanga3/infrastructure/tracktv/services/oauth_device.dart';

class AuthenticationRepository {
  final OauthDevice oauthDevice;
  final FlutterSecureStorage storage;

  AuthenticationRepository(this.oauthDevice, this.storage);

  Future<DeviceCodeOauth> authenticate() async {
    return await oauthDevice.generateCode();
  }

  Future<bool> hasToken() async {
    String value = await storage.read(key: "access_token");
    return value != null && value.isNotEmpty;
  }

  Future deleteToken() async {
    await storage.delete(
      key: "access_token",
    );
    await storage.delete(
      key: "refresh_token",
    );
  }

  Future persistToken(AccessToken token) async {
    await storage.write(key: "access_token", value: token.accessToken);
    await storage.write(key: "refresh_token", value: token.refreshToken);
  }

  Future<AccessToken> retrieveAccessToken(DeviceCodeOauth code) async {
    return await oauthDevice.getAccessToken(code);
  }
}
