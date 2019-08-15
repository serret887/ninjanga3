class DeviceCodeOauth {
  String deviceCode;
  String userCode;
  String verificationUrl;
  int expiresIn;
  int interval;

  DeviceCodeOauth(
      {this.deviceCode,
        this.userCode,
        this.verificationUrl,
        this.expiresIn,
        this.interval});

  DeviceCodeOauth.fromJson(Map<String, dynamic> json) {
    deviceCode = json['device_code'];
    userCode = json['user_code'];
    verificationUrl = json['verification_url'];
    expiresIn = json['expires_in'];
    interval = json['interval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_code'] = this.deviceCode;
    data['user_code'] = this.userCode;
    data['verification_url'] = this.verificationUrl;
    data['expires_in'] = this.expiresIn;
    data['interval'] = this.interval;
    return data;
  }
}