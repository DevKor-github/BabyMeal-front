class GetPost {
  int? postId;
  String? updateDate;
  int? comments;
  int? likes;
  String? title;
  String? body;
  List<String>? photos;
  int? scrap;
  String? type;

  GetPost(
      {this.postId,
      this.updateDate,
      this.comments,
      this.likes,
      this.title,
      this.body,
      this.photos,
      this.scrap,
      this.type});

  GetPost.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    updateDate = json['updateDate'];
    comments = json['comments'];
    likes = json['likes'];
    title = json['title'];
    body = json['body'];
    photos = json['photos'].cast<String>();
    scrap = json['scrap'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['updateDate'] = this.updateDate;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['title'] = this.title;
    data['body'] = this.body;
    data['photos'] = this.photos;
    data['scrap'] = this.scrap;
    data['type'] = this.type;
    return data;
  }
}

class PostPost {
  int? comments;
  int? likes;
  String? title;
  String? body;
  List<String>? photos; //휴대폰 내 주소로 처리
  int? scrap;
  String? type;

  PostPost(
      {this.comments,
      this.likes,
      this.title,
      this.body,
      this.photos,
      this.scrap,
      this.type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['comments'] = this.comments;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['title'] = this.title;
    data['body'] = this.body;
    data['photos'] = this.photos;
    data['scrap'] = this.scrap;
    data['type'] = this.type;
    return data;
  }
}

class PostComment {
  int? postId;
  String? contents;

  PostComment({
    this.postId,
    this.contents,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['contents'] = this.contents;
    return data;
  }
}

class PostLike {
  int? postId;

  PostLike({
    this.postId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    return data;
  }
}

class PostScrap {
  int? postId;

  PostScrap({
    this.postId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    return data;
  }
}
