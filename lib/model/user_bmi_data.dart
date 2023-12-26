class UserBmiData {
  final double height;
  final double weight;

//<editor-fold desc="Data Methods">
  const UserBmiData({
    required this.height,
    required this.weight,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserBmiData &&
          runtimeType == other.runtimeType &&
          height == other.height &&
          weight == other.weight);

  @override
  int get hashCode => height.hashCode ^ weight.hashCode;

  @override
  String toString() {
    return 'UserBmiData{ height: $height, weight: $weight,}';
  }

  UserBmiData copyWith({
    double? height,
    double? weight,
  }) {
    return UserBmiData(
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
    };
  }

  factory UserBmiData.fromJson(Map<String, dynamic> map) {
    return UserBmiData(
      height: map['height'] as double,
      weight: map['weight'] as double,
    );
  }

//</editor-fold>
}
