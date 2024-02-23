class FridgeRecipe {
  int? simpleDietId;
  String? dietName;
  int? time;
  String? difficulty;
  bool? heart;

  FridgeRecipe({
    this.simpleDietId,
    this.dietName,
    this.time,
    this.difficulty,
    this.heart,
  });

  factory FridgeRecipe.fromJson(Map<String, dynamic> json) {
    return FridgeRecipe(
      simpleDietId: json['simpleDietId'],
      dietName: json['dietName'],
      time: json['time'],
      difficulty: json['difficulty'],
      heart: json['heart'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'simpleDietId': simpleDietId,
      'dietName': dietName,
      'time': time,
      'difficulty': difficulty,
      'heart': heart,
    };
  }

  @override
  String toString() {
    return 'FridgeRecipe(simpleDietId: $simpleDietId, dietName: $dietName, time: $time, difficulty: $difficulty, heart: $heart)';
  }

}