import 'dart:convert';

DriverProfileModel driverProfileModelFromJson(String str) =>
    DriverProfileModel.fromJson(json.decode(str));

String driverProfileModelToJson(DriverProfileModel data) =>
    json.encode(data.toJson());

class DriverProfileModel {
  List<DriverProfileResponse> driverProfileResponse;
  bool status;

  DriverProfileModel({
    required this.driverProfileResponse,
    required this.status,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) =>
      DriverProfileModel(
        driverProfileResponse: List<DriverProfileResponse>.from(
            json["DriverProfileResponse"]
                .map((x) => DriverProfileResponse.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "DriverProfileResponse":
            List<dynamic>.from(driverProfileResponse.map((x) => x.toJson())),
        "status": status,
      };
}

class DriverProfileResponse {
  int id;
  int userId;
  String name;
  String email;
  String userType;
  String groupId;
  String driverImage;

  DriverProfileResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.userType,
    required this.groupId,
    required this.driverImage,
  });

  factory DriverProfileResponse.fromJson(Map<String, dynamic> json) =>
      DriverProfileResponse(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        userType: json["user_type"],
        groupId: json["group_id"],
        driverImage: json["driver_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "user_type": userType,
        "group_id": groupId,
        "driver_image": driverImage,
      };
}
