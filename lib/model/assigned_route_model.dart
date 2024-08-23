import 'dart:convert';

AssignedRouteModel assignedRouteModelFromJson(String str) =>
    AssignedRouteModel.fromJson(json.decode(str));

String assignedRouteModelToJson(AssignedRouteModel data) =>
    json.encode(data.toJson());

class AssignedRouteModel {
  List<AssignedRouteResponse> assignedRouteResponse;
  bool status;

  AssignedRouteModel({
    required this.assignedRouteResponse,
    required this.status,
  });

  factory AssignedRouteModel.fromJson(Map<String, dynamic> json) =>
      AssignedRouteModel(
        assignedRouteResponse: List<AssignedRouteResponse>.from(
            json["AssignedRouteResponse"]
                .map((x) => AssignedRouteResponse.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "AssignedRouteResponse":
            List<dynamic>.from(assignedRouteResponse.map((x) => x.toJson())),
        "status": status,
      };
}

class AssignedRouteResponse {
  int id;
  String name;
  String returnName;
  int distance;
  String stoppages;
  int tollAmount;
  int isActive;

  AssignedRouteResponse({
    required this.id,
    required this.name,
    required this.returnName,
    required this.distance,
    required this.stoppages,
    required this.tollAmount,
    required this.isActive,
  });

  factory AssignedRouteResponse.fromJson(Map<String, dynamic> json) =>
      AssignedRouteResponse(
        id: json["id"],
        name: json["name"],
        returnName: json["return_name"],
        distance: json["distance"],
        stoppages: json["stoppages"],
        tollAmount: json["toll_amount"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "return_name": returnName,
        "distance": distance,
        "stoppages": stoppages,
        "toll_amount": tollAmount,
        "is_active": isActive,
      };
}
