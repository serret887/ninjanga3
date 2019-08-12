import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/access_token.dart';
import '../models/device_code_oauth.dart';
import '../config_constants.dart';

class OauthDevice {
  final http.Client client;

  OauthDevice(this.client);

  Future<DeviceCodeOauth> generateCode() async {
    Uri uri = Uri.parse(Constants.apiUrl + Constants.oauthDeviceCodeUri);

    var response = await client
        .post(uri,
            headers: {'Content-Type': 'application/json'},
            body:
                json.encode({'client_id': '${Constants.apiClientIdHeaderKey}'}))
        .then(((resp) => json.decode(resp.body)))
        .catchError((err) => print(err));
    print(response);
    return DeviceCodeOauth.fromJson(response);
  }

  Future getAccessToken(DeviceCodeOauth code) async {
    Uri uri = Uri.parse(Constants.apiUrl + Constants.oauthDeviceTokenUri);
    var expired = DateTime.now().add(new Duration(seconds: code.expiresIn));
    AccessToken response;
    while (DateTime.now().compareTo(expired) == -1 && response == null) {
      response = await _getAccessToken(uri, code);
    }
    if (response == null) {
      throw Exception('You Token expired try again later');
    }
    print(response.toJson());
    return response;
  }

  Future<AccessToken> _getAccessToken(Uri uri, DeviceCodeOauth code) async {
    var resp = await Future.delayed(
        Duration(
          seconds: code.interval,
        ),
        () async => await client
            .post(uri,
                headers: {'Content-Type': 'application/json'},
                body: json.encode({
                  "code": '${code.deviceCode}',
                  "client_id": '${Constants.apiClientIdHeaderKey}',
                  "client_secret": '${Constants.clientSecret}'
                }))
            .then((resp1) => resp1)
            .catchError((err) => print(err)));

    print(resp.statusCode);
    if (resp.statusCode != 200) {
      return null;
    } else if (resp.statusCode == 418) {
      throw Exception("User denied the code");
    }
    print(resp.body);
    return AccessToken.fromJson(json.decode(resp.body));
  }
//TODO i ned to do the refresh token i don't want the users authenticate every 3 months
}
