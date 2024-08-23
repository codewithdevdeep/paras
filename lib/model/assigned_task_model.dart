import 'dart:convert';

AssignedTaskModel assignedTaskModelFromJson(String str) =>
    AssignedTaskModel.fromJson(json.decode(str));

String assignedTaskModelToJson(AssignedTaskModel data) =>
    json.encode(data.toJson());

class AssignedTaskModel {
  List<AssignedTaskResponse> assignedTaskResponse;
  bool status;

  AssignedTaskModel({
    required this.assignedTaskResponse,
    required this.status,
  });

  factory AssignedTaskModel.fromJson(Map<String, dynamic> json) =>
      AssignedTaskModel(
        assignedTaskResponse: List<AssignedTaskResponse>.from(
            json["AssignedTaskResponse"]
                .map((x) => AssignedTaskResponse.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "AssignedTaskResponse":
            List<dynamic>.from(assignedTaskResponse.map((x) => x.toJson())),
        "status": status,
      };
}

class AssignedTaskResponse {
  List<Driver> driver;
  List<Route> route;
  List<Vehicle> vehicle;

  AssignedTaskResponse({
    required this.driver,
    required this.route,
    required this.vehicle,
  });

  factory AssignedTaskResponse.fromJson(Map<String, dynamic> json) =>
      AssignedTaskResponse(
        driver:
            List<Driver>.from(json["driver"].map((x) => Driver.fromJson(x))),
        route: List<Route>.from(json["route"].map((x) => Route.fromJson(x))),
        vehicle:
            List<Vehicle>.from(json["vehicle"].map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "driver": List<dynamic>.from(driver.map((x) => x.toJson())),
        "route": List<dynamic>.from(route.map((x) => x.toJson())),
        "vehicle": List<dynamic>.from(vehicle.map((x) => x.toJson())),
      };
}

class Driver {
  int id;
  int userId;
  String name;
  String email;
  String userType;
  String groupId;
  String driverImage;

  Driver({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.userType,
    required this.groupId,
    required this.driverImage,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
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

class Route {
  int id;
  String name;
  String returnName;
  int distance;
  String stoppages;
  int tollAmount;
  int isActive;

  Route({
    required this.id,
    required this.name,
    required this.returnName,
    required this.distance,
    required this.stoppages,
    required this.tollAmount,
    required this.isActive,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
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

class Vehicle {
  int id;
  String makeName;
  String modelName;
  String colorName;
  String year;
  int groupId;
  DateTime licExpDate;
  DateTime regExpDate;
  String vehicleImage;
  String engineType;
  String horsePower;
  String licensePlate;
  String mileage;
  int inService;
  int intMileage;

  Vehicle({
    required this.id,
    required this.makeName,
    required this.modelName,
    required this.colorName,
    required this.year,
    required this.groupId,
    required this.licExpDate,
    required this.regExpDate,
    required this.vehicleImage,
    required this.engineType,
    required this.horsePower,
    required this.licensePlate,
    required this.mileage,
    required this.inService,
    required this.intMileage,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        makeName: json["make_name"],
        modelName: json["model_name"],
        colorName: json["color_name"],
        year: json["year"],
        groupId: json["group_id"],
        licExpDate: DateTime.parse(json["lic_exp_date"]),
        regExpDate: DateTime.parse(json["reg_exp_date"]),
        vehicleImage: json["vehicle_image"],
        engineType: json["engine_type"],
        horsePower: json["horse_power"],
        licensePlate: json["license_plate"],
        mileage: json["mileage"],
        inService: json["in_service"],
        intMileage: json["int_mileage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "make_name": makeName,
        "model_name": modelName,
        "color_name": colorName,
        "year": year,
        "group_id": groupId,
        "lic_exp_date":
            "${licExpDate.year.toString().padLeft(4, '0')}-${licExpDate.month.toString().padLeft(2, '0')}-${licExpDate.day.toString().padLeft(2, '0')}",
        "reg_exp_date":
            "${regExpDate.year.toString().padLeft(4, '0')}-${regExpDate.month.toString().padLeft(2, '0')}-${regExpDate.day.toString().padLeft(2, '0')}",
        "vehicle_image": vehicleImage,
        "engine_type": engineType,
        "horse_power": horsePower,
        "license_plate": licensePlate,
        "mileage": mileage,
        "in_service": inService,
        "int_mileage": intMileage,
      };
}
