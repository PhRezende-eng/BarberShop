class BarbershopModel {
  final int id;
  final int userId;
  final String name;
  final List<String> openingDays;
  final List<int> openingHours;

  BarbershopModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.openingDays,
    required this.openingHours,
  });

  factory BarbershopModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'user_id': final int userId,
        'name': final String name,
        'opening_day': final List<String> openingDays,
        'opening_hours': final List<int> openingHours,
      } =>
        BarbershopModel(
          id: id,
          userId: userId,
          name: name,
          openingDays: openingDays,
          openingHours: openingHours,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
