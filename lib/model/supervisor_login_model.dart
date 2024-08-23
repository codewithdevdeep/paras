import 'dart:convert';

SupervisorLoginModel supervisorLoginModelFromJson(String str) =>
    SupervisorLoginModel.fromJson(json.decode(str));

String supervisorLoginModelToJson(SupervisorLoginModel data) =>
    json.encode(data.toJson());

class SupervisorLoginModel {
  List<SupervisorLoginResponse> supervisorLoginResponse;
  String apiToken;
  bool status;

  SupervisorLoginModel({
    required this.supervisorLoginResponse,
    required this.apiToken,
    required this.status,
  });

  factory SupervisorLoginModel.fromJson(Map<String, dynamic> json) =>
      SupervisorLoginModel(
        supervisorLoginResponse: List<SupervisorLoginResponse>.from(
            json["SupervisorLoginResponse"]
                .map((x) => SupervisorLoginResponse.fromJson(x))),
        apiToken: json["api_token"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "SupervisorLoginResponse":
            List<dynamic>.from(supervisorLoginResponse.map((x) => x.toJson())),
        "api_token": apiToken,
        "status": status,
      };
}

class SupervisorLoginResponse {
  int id;
  int userId;
  String name;
  String email;
  String userType;
  String groupId;
  String supervisorImage;

  SupervisorLoginResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.userType,
    required this.groupId,
    required this.supervisorImage,
  });

  factory SupervisorLoginResponse.fromJson(Map<String, dynamic> json) =>
      SupervisorLoginResponse(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        userType: json["user_type"],
        groupId: json["group_id"],
        supervisorImage: json["supervisor_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "user_type": userType,
        "group_id": groupId,
        "supervisor_image": supervisorImage,
      };
}
