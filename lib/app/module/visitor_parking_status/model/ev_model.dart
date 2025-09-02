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

List<Vehicle> evactivepasslist = [
  Vehicle(
      id: 1,
      vehicleNumber: 'MH-40 AS 1659',
      vehicleName: "Ola x10",
      date: '22nd Feb, 2024',
      time: '10:30 AM - 1:00 PM',
      icon: 'assets/images/ev_slot_image/car.png'),
  Vehicle(
      id: 2,
      vehicleNumber: 'MH-40 AS 1659',
      vehicleName: "Ola x10",
      date: '22nd Feb, 2024',
      time: '10:30 AM - 1:00 PM',
      icon: 'assets/images/ev_slot_image/car.png'),
  Vehicle(
      id: 3,
      vehicleNumber: 'MH-40 AS 1659',
      vehicleName: "Ola x10",
      date: '22nd Feb, 2024',
      time: '10:30 AM - 1:00 PM',
      icon: 'assets/images/ev_slot_image/car.png'),
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

List<EvSelectlist> vehiclepassitems = [
  EvSelectlist(
    id: 1,
    imageName: "assets/images/ev_slot_image/bikicle.png",
    title: 'Bicycle',
  ),
  EvSelectlist(
    id: 2,
    imageName: "assets/images/ev_slot_image/scooter.png",
    title: 'Two wheeler',
  ),
  EvSelectlist(
    id: 3,
    imageName: "assets/images/ev_slot_image/car.png",
    title: 'Four Wheeler',
  ),
];
