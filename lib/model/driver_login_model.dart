import 'dart:convert';

List<DriverLoginResponse> driverLoginResponseDataJson(String str) =>
    List<DriverLoginResponse>.from(
        json.decode(str).map((x) => DriverLoginResponse.fromJson(x)));

String driverLoginResponseDataToJson(List<DriverLoginResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

DriverLoginModel driverLoginModelFromJson(String str) =>
    DriverLoginModel.fromJson(json.decode(str));

String driverLoginModelToJson(DriverLoginModel data) =>
    json.encode(data.toJson());

class DriverLoginModel {
  List<DriverLoginResponse> driverLoginResponse;
  String apiToken;
  bool status;

  DriverLoginModel({
    required this.driverLoginResponse,
    required this.apiToken,
    required this.status,
  });

  factory DriverLoginModel.fromJson(Map<String, dynamic> json) =>
      DriverLoginModel(
        driverLoginResponse: List<DriverLoginResponse>.from(
            json["DriverLoginResponse"]
                .map((x) => DriverLoginResponse.fromJson(x))),
        apiToken: json["api_token"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "DriverLoginResponse":
            List<dynamic>.from(driverLoginResponse.map((x) => x.toJson())),
        "api_token": apiToken,
        "status": status,
      };
}

class DriverLoginResponse {
  int id;
  int userId;
  String name;
  String email;
  String userType;
  String groupId;
  String driverImage;

  DriverLoginResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.userType,
    required this.groupId,
    required this.driverImage,
  });

  factory DriverLoginResponse.fromJson(Map<String, dynamic> json) =>
      DriverLoginResponse(
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
