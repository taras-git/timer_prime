import 'dart:convert';

class RandomNumberModel {
  int? randomNumber;
  String? errorMessage;

  RandomNumberModel({
    this.randomNumber,
    this.errorMessage,
  });

  RandomNumberModel copyWith({
    int? randomNumber,
    String? errorMessage,
  }) {
    return RandomNumberModel(
      randomNumber: randomNumber ?? this.randomNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'randomNumber': randomNumber,
      'errorMessage': errorMessage,
    };
  }

  factory RandomNumberModel.fromMap(Map<String, dynamic> map) {
    return RandomNumberModel(
      randomNumber: map['randomNumber']?.toInt() ?? 0,
      errorMessage: map['errorMessage']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RandomNumberModel.fromJson(String source) =>
      RandomNumberModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'RandomNumberModel(randomNumber: $randomNumber, errorMessage : $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RandomNumberModel &&
        other.randomNumber == randomNumber &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => Object.hash(
        randomNumber,
        errorMessage,
      );
}
