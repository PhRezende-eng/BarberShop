sealed class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });
}

class UserModelADM extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelADM({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory UserModelADM.fromJson(Map<String, dynamic> json) {
    return UserModelADM(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      avatar: json["avatar"],
      workDays: json["workDays"],
      workHours: json["workHours"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}

class UserModelEmployee extends UserModel {
  final List<String> workDays;
  final List<int> workHours;

  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    required this.workDays,
    required this.workHours,
    super.avatar,
  });

  factory UserModelEmployee.fromJson(Map<String, dynamic> json) {
    return UserModelEmployee(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      avatar: json["avatar"],
      workDays: json["workHours"],
      workHours: json["workHours"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatar": avatar,
      "workDays": workDays,
      "workHours": workHours,
    };
  }
}
