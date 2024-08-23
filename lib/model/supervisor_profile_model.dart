import 'dart:convert';

SupervisorProfileModel supervisorProfileModelFromJson(String str) =>
    SupervisorProfileModel.fromJson(json.decode(str));

String supervisorProfileModelToJson(SupervisorProfileModel data) =>
    json.encode(data.toJson());

class SupervisorProfileModel {
  List<SupervisorResponse> supervisorResponse;
  bool status;

  SupervisorProfileModel({
    required this.supervisorResponse,
    required this.status,
  });

  factory SupervisorProfileModel.fromJson(Map<String, dynamic> json) =>
      SupervisorProfileModel(
        supervisorResponse: List<SupervisorResponse>.from(
            json["SupervisorResponse"]
                .map((x) => SupervisorResponse.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "SupervisorResponse":
            List<dynamic>.from(supervisorResponse.map((x) => x.toJson())),
        "status": status,
      };
}

class SupervisorResponse {
  int id;
  int userId;
  String name;
  String email;
  String userType;
  String groupId;
  String supervisorImage;

  SupervisorResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.userType,
    required this.groupId,
    required this.supervisorImage,
  });

  factory SupervisorResponse.fromJson(Map<String, dynamic> json) =>
      SupervisorResponse(
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
