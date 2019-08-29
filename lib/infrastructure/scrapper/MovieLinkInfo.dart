class MovieLinkInfo {
  /// Server name that provide the service
  final String serverName;

  /// Image resource for the server that provide the service
  final Uri imageUri;

  /// Page where the link to the movie is
  final Uri detailsUri;

  /// Link in the server provider that has the video
  Uri siteUri;

  /// Video resource location
  List<Uri> videoUri = [];

  MovieLinkInfo({this.serverName, this.imageUri, this.detailsUri});

  @override
  String toString() {
    if (videoUri.length > 0) {
      var videoURI =
          videoUri.map((i) => i.toString()).reduce((x, y) => x += "\n y");
      return "$serverName with image $imageUri, movie searched in $detailsUri "
          "found link to server $siteUri found:\n $videoURI ";
    }
    return "";
  }
}
