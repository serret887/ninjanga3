class Ids {
  int trakt;
  String slug;
  String imdb;
  int tmdb;

  Ids({this.trakt, this.slug, this.imdb, this.tmdb});

  Ids.fromJson(Map<String, dynamic> json) {
    trakt = json['trakt'];
    slug = json['slug'];
    imdb = json['imdb'];
    tmdb = json['tmdb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trakt'] = this.trakt;
    data['slug'] = this.slug;
    data['imdb'] = this.imdb;
    data['tmdb'] = this.tmdb;
    return data;
  }
}
