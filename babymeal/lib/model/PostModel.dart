class GetPostDetail {
  int? postId;
  String? updateDate;
  int? comments;
  int? likes;
  String? title;
  String? body;
  List<String>? filePaths;
  int? scrap;
  String? type;

  GetPostDetail(
      {this.postId,
      this.updateDate,
      this.comments,
      this.likes,
      this.title,
      this.body,
      this.filePaths,
      this.scrap,
      this.type});

  GetPostDetail.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    updateDate = json['updateDate'];
    comments = json['comments'];
    likes = json['likes'];
    title = json['title'];
    body = json['body'];
    filePaths = json['filePaths'].cast<String>();
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
    data['filePaths'] = this.filePaths;
    data['scrap'] = this.scrap;
    data['type'] = this.type;
    return data;
  }
}

class GetPost {
  int? postId;
  String? updateTime;
  int? comments;
  int? likes;
  String? title;
  List<String>? filePath;
  String? type;
  String? customerName;

  GetPost(
      {this.postId,
      this.updateTime,
      this.comments,
      this.likes,
      this.title,
      this.filePath,
      this.type,
      this.customerName});

  GetPost.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    updateTime = json['updateTime'];
    comments = json['comments'];
    likes = json['likes'];
    title = json['title'];
    filePath = json['filePath'].cast<String>();
    type = json['type'];
    customerName = json['customerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['updateTime'] = this.updateTime;
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['title'] = this.title;
    data['filePath'] = this.filePath;
    data['type'] = this.type;
    data['customerName'] = this.customerName;
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

class GetComment {
  int? postId;
  String? contents;
  String? customerName;
  String? time;

  GetComment({this.postId, this.contents, this.customerName, this.time});

  GetComment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    contents = json['contents'];
    customerName = json['customerName'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['contents'] = this.contents;
    data['customerName'] = this.customerName;
    data['time'] = this.time;
    return data;
  }
}
