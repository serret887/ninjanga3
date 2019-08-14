enum BackdropSize {
  w300,
  w780,
  w1280,
  original,
}

enum PosterSize { w92, w154, w185, w342, w500, w780, original }

class ImagesTmdb {
  int id;
  List<Backdrops> backdrops;
  List<Posters> posters;

  getBestBackdrop({BackdropSize size = BackdropSize.w780}) {
    String sizeUrl = "";
    if (size == BackdropSize.w300) {
      sizeUrl = 'w300';
    }
    if (size == BackdropSize.w780) {
      sizeUrl = 'w780';
    }
    if (size == BackdropSize.w1280) {
      sizeUrl = 'w1280';
    }
    if (size == BackdropSize.original) {
      sizeUrl = 'original';
    }
    return 'https://image.tmdb.org/t/p/$sizeUrl/${this.backdrops?.first?.filePath}';
  }

  getBestPoster({PosterSize size = PosterSize.w185}) {
    String sizeUrl = "";
    if (size == PosterSize.w92) {
      sizeUrl = 'w92';
    }
    if (size == PosterSize.w154) {
      sizeUrl = 'w154';
    }
    if (size == PosterSize.w185) {
      sizeUrl = 'w185';
    }
    if (size == PosterSize.w342) {
      sizeUrl = 'w342';
    }
    if (size == PosterSize.w500) {
      sizeUrl = 'w500';
    }
    if (size == PosterSize.w780) {
      sizeUrl = 'w780';
    }
    if (size == PosterSize.original) {
      sizeUrl = 'original';
    }
    return 'https://image.tmdb.org/t/p/$sizeUrl/${this.posters?.first?.filePath}';
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
