import 'dart:convert';

TripHistoryModel tripHistoryModelFromJson(String str) =>
    TripHistoryModel.fromJson(json.decode(str));

String tripHistoryModelToJson(TripHistoryModel data) =>
    json.encode(data.toJson());

class TripHistoryModel {
  List<TripHistoryResponse> tripHistoryResponse;
  bool status;

  TripHistoryModel({
    required this.tripHistoryResponse,
    required this.status,
  });

  factory TripHistoryModel.fromJson(Map<String, dynamic> json) =>
      TripHistoryModel(
        tripHistoryResponse: List<TripHistoryResponse>.from(
            json["TripHistoryResponse"]
                .map((x) => TripHistoryResponse.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "TripHistoryResponse":
            List<dynamic>.from(tripHistoryResponse.map((x) => x.toJson())),
        "status": status,
      };
}

class TripHistoryResponse {
  int id;
  int customerId;
  int userId;
  String vehicleId;
  DateTime pickup;
  DateTime dropoff;
  String contractType;
  String weekOff;
  String vechileQty;
  String shift;
  int monthDays;
  int duration;
  String pickupAddr;
  String destAddr;
  List<Driver> driver;
  List<Route> route;

  TripHistoryResponse({
    required this.id,
    required this.customerId,
    required this.userId,
    required this.vehicleId,
    required this.pickup,
    required this.dropoff,
    required this.contractType,
    required this.weekOff,
    required this.vechileQty,
    required this.shift,
    required this.monthDays,
    required this.duration,
    required this.pickupAddr,
    required this.destAddr,
    required this.driver,
    required this.route,
  });

  factory TripHistoryResponse.fromJson(Map<String, dynamic> json) =>
      TripHistoryResponse(
        id: json["id"],
        customerId: json["customer_id"],
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        pickup: DateTime.parse(json["pickup"]),
        dropoff: DateTime.parse(json["dropoff"]),
        contractType: json["contract_type"],
        weekOff: json["week_off"],
        vechileQty: json["vechile_qty"],
        shift: json["shift"],
        monthDays: json["month_days"],
        duration: json["duration"],
        pickupAddr: json["pickup_addr"],
        destAddr: json["dest_addr"],
        driver:
            List<Driver>.from(json["driver"].map((x) => Driver.fromJson(x))),
        route: List<Route>.from(json["route"].map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "user_id": userId,
        "vehicle_id": vehicleId,
        "pickup": pickup.toIso8601String(),
        "dropoff": dropoff.toIso8601String(),
        "contract_type": contractType,
        "week_off": weekOff,
        "vechile_qty": vechileQty,
        "shift": shift,
        "month_days": monthDays,
        "duration": duration,
        "pickup_addr": pickupAddr,
        "dest_addr": destAddr,
        "driver": List<dynamic>.from(driver.map((x) => x.toJson())),
        "route": List<dynamic>.from(route.map((x) => x.toJson())),
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
