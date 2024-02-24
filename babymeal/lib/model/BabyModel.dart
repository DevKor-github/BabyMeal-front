class PostBaby {
  String? babyName;
  String? birth;
  String? allergy;
  String? needs;

  PostBaby({this.babyName, this.birth, this.allergy, this.needs});

  PostBaby.fromJson(Map<String, dynamic> json) {
    babyName = json['babyName'];
    birth = json['birth'];
    allergy = json['allergy'];
    needs = json['needs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['babyName'] = this.babyName;
    data['birth'] = this.birth;
    data['allergy'] = this.allergy;
    data['needs'] = this.needs;
    return data;
  }
}