
class CheckEmail{
  bool data = false;

  CheckEmail({this.data = false});

  CheckEmail.fromJson(Map<String, dynamic> json){
    data = json['data'];
  }

}

class CheckName{
  bool data = false;

  CheckName({this.data = false});

  CheckName.fromJson(Map<String, dynamic> json){
    data = json['data'];
  }

}

class PostAuth{
  String? accessToken;

  PostAuth({this.accessToken});

  PostAuth.fromJson(Map<String, dynamic> json) {
    accessToken = json['data']['accessToken'];
  }
}


class PostLogin{
  String? message;

  PostLogin({this.message});

  PostLogin.fromJson(Map<String, dynamic>json){
    message = json['message'];
  }
}