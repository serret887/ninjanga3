import 'id.dart';

class MovieTrackTV {
  String title;
  int year;
  Ids ids;
  String tagline;
  String overview;
  String released;
  int runtime;
  String country;
  String updatedAt;
  String trailer;
  String homepage;
  double rating;
  int votes;
  int commentCount;
  String language;
  List<String> availableTranslations;
  List<String> genres;
  String certification;
  int airedEpisodes;
  MovieTrackTV(
      {this.title,
      this.year,
      this.ids,
      this.tagline,
      this.overview,
      this.released,
      this.runtime,
      this.country,
      this.updatedAt,
      this.trailer,
      this.homepage,
      this.rating,
      this.votes,
      this.commentCount,
      this.language,
      this.availableTranslations,
      this.genres,
      this.certification,
      this.airedEpisodes});

  MovieTrackTV.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    year = json['year'];
    ids = json['ids'] != null ? new Ids.fromJson(json['ids']) : null;
    tagline = json['tagline'];
    overview = json['overview'];
    released = json['released'];
    runtime = json['runtime'];
    country = json['country'];
    updatedAt = json['updated_at'];
    trailer = json['trailer'];
    homepage = json['homepage'];
    rating = json['rating'];
    votes = json['votes'];
    commentCount = json['comment_count'];
    language = json['language'];
    availableTranslations = json['available_translations']?.cast<String>();
    genres = json['genres']?.cast<String>();
    certification = json['certification'];
    airedEpisodes = json['aired_episodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['year'] = this.year;
    if (this.ids != null) {
      data['ids'] = this.ids.toJson();
    }
    data['tagline'] = this.tagline;
    data['overview'] = this.overview;
    data['released'] = this.released;
    data['runtime'] = this.runtime;
    data['country'] = this.country;
    data['updated_at'] = this.updatedAt;
    data['trailer'] = this.trailer;
    data['homepage'] = this.homepage;
    data['rating'] = this.rating;
    data['votes'] = this.votes;
    data['comment_count'] = this.commentCount;
    data['language'] = this.language;
    data['available_translations'] = this.availableTranslations;
    data['genres'] = this.genres;
    data['certification'] = this.certification;
    return data;
  }
}
