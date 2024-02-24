class GetRecipe {
  int? simpleDietId;
  String? dietName;
  String? description;
  int? time;
  String? difficulty;
  bool? heart;

  GetRecipe({
    this.simpleDietId,
    this.dietName,
    this.description,
    this.time,
    this.difficulty,
    this.heart,
  });

  factory GetRecipe.fromJson(Map<String, dynamic> json) {
    return GetRecipe(
      simpleDietId: json['simpleDietId'],
      dietName: json['dietName'],
      description: json['description'],
      time: json['time'],
      difficulty: json['difficulty'],
      heart: json['heart'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'simpleDietId': simpleDietId,
      'dietName': dietName,
      'description': description,
      'time': time,
      'difficulty': difficulty,
      'heart': heart,
    };
  }

  @override
  String toString() {
    return 'GetRecipe(simpleDietId: $simpleDietId, dietName: $dietName, description: $description, time: $time, difficulty: $difficulty, heart: $heart)';
  }
}
