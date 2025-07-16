class Enums {
  static T enumFromString<T>(List<T> values, String value) {
    return values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => throw ArgumentError('Invalid enum value: $value'),
    );
  }
}
