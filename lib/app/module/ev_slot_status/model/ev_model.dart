class Vehicle {
  int id;
  String vehicleNumber;
  String vehicleName;
  String date;
  String time;
  String icon;

  Vehicle({
    required this.id,
    required this.vehicleNumber,
    required this.vehicleName,
    required this.date,
    required this.time,
    required this.icon,
  });
}

List<Vehicle> evactivelist = [
  Vehicle(
      id: 1,
      vehicleNumber: 'MH-40 AS 1659',
      vehicleName: "Ola x10",
      date: '22nd Feb, 2024',
      time: '10:30 AM - 1:00 PM',
      icon: 'assets/images/ev_slot_image/ev_slot_charger.png'),
  Vehicle(
      id: 2,
      vehicleNumber: 'MH-40 AS 1659',
      vehicleName: "Ola x10",
      date: '22nd Feb, 2024',
      time: '10:30 AM - 1:00 PM',
      icon: 'assets/images/ev_slot_image/ev_slot_charger.png'),
  Vehicle(
      id: 3,
      vehicleNumber: 'MH-40 AS 1659',
      vehicleName: "Ola x10",
      date: '22nd Feb, 2024',
      time: '10:30 AM - 1:00 PM',
      icon: 'assets/images/ev_slot_image/ev_slot_charger.png'),
  Vehicle(
      id: 4,
      vehicleNumber: 'MH-40 AS 1659',
      vehicleName: "Ola x10",
      date: '22nd Feb, 2024',
      time: '10:30 AM - 1:00 PM',
      icon: 'assets/images/ev_slot_image/ev_slot_charger.png'),
];

class EvSelectlist {
  final int id;
  final String imageName;
  final String title;

  EvSelectlist({
    required this.id,
    required this.imageName,
    required this.title,
  });
}

List<EvSelectlist> Evitems = [
  EvSelectlist(
    id: 1,
    imageName: "assets/images/ev_slot_image/ev_bicycle.png",
    title: 'Bicycle',
  ),
  EvSelectlist(
    id: 2,
    imageName: "assets/images/ev_slot_image/ev_motercycle.png",
    title: 'Two wheeler',
  ),
  EvSelectlist(
    id: 3,
    imageName: "assets/images/ev_slot_image/ev_car.png",
    title: 'Four Wheeler',
  ),
];
