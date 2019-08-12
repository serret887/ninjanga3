class ImagesTmdb {
  int id;
  List<Backdrops> backdrops;
  List<Posters> posters;

  getBestBackdrop() {
    return 'https://image.tmdb.org/t/p/w780/${this.backdrops.first.filePath}';
  }

  getBestPoster() {
    return 'https://image.tmdb.org/t/p/w342/${this.backdrops.first.filePath}';
  }

  ImagesTmdb({this.id, this.backdrops, this.posters});

  ImagesTmdb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['backdrops'] != null) {
      backdrops = new List<Backdrops>();
      json['backdrops'].forEach((v) {
        backdrops.add(new Backdrops.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = new List<Posters>();
      json['posters'].forEach((v) {
        posters.add(new Posters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.backdrops != null) {
      data['backdrops'] = this.backdrops.map((v) => v.toJson()).toList();
    }
    if (this.posters != null) {
      data['posters'] = this.posters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Backdrops {
  String filePath;

  Backdrops({
    this.filePath,
  });

  Backdrops.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}

class Posters {
  String filePath;

  Posters({
    this.filePath,
  });

  Posters.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}
