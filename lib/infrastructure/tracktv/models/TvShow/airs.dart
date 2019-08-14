class Airs {
  String day;
  String time;
  String timezone;

  Airs({
    this.day,
    this.time,
    this.timezone,
  });

  factory Airs.fromJson(Map<String, dynamic> json) => new Airs(
        day: json["day"],
        time: json["time"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
        "timezone": timezone,
      };
}
