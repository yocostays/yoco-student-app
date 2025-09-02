// ignore_for_file: public_member_api_docs, sort_constructors_first
class Aminitiesitmes {
  final String imageName;
  final String title;
  final int id;

  Aminitiesitmes({
    required this.imageName,
    required this.title,
    required this.id,
  });
}

List<Aminitiesitmes> aminitiesItemslist = [
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/laundry.png',
      title: 'Laundry',
      id: 1),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/snooker.png',
      title: 'Snooker',
      id: 2),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/swimming.png',
      title: 'Swimming Pool',
      id: 3),

  Aminitiesitmes(
      imageName: 'assets/images/aminities2/badminton.png',
      title: 'Badminton Court',
      id: 4),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/tv.png',
      title: 'TV Room/ Entertainment Area',
      id: 5),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/football.png',
      title: 'Football Ground',
      id: 6),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/cricket.png',
      title: 'Cricket Ground',
      id: 7),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/cafeteria.png',
      title: 'Cafeteria Access',
      id: 8),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/table.png',
      title: 'Table Tennis',
      id: 9),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/gym.png', title: 'Gym', id: 10),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/basketball.png',
      title: 'Basketball Court',
      id: 11),
  Aminitiesitmes(
      imageName: 'assets/images/aminities2/yoga.png',
      title: 'Yoga Space',
      id: 12),

  // Add more items as needed
];

class Laundryitem {
  final String imageName;
  final String title;
  final int id;
  int Quntity;

  Laundryitem({
    required this.imageName,
    required this.title,
    required this.id,
    required this.Quntity,
  });
}

List<Laundryitem> laundyitems = [
  Laundryitem(
      id: 1,
      imageName: "assets/images/aminities/shirt.png",
      title: "Shirt / T-Shirt",
      Quntity: 0),
  Laundryitem(
      id: 2,
      imageName: "assets/images/aminities/Pant.png",
      title: "Trousers / Jeans",
      Quntity: 0),
  Laundryitem(
      id: 3,
      imageName: "assets/images/aminities/bed_sheet.png",
      title: "Bedsheets",
      Quntity: 0),
  Laundryitem(
      id: 3,
      imageName: "assets/images/aminities/pillow_cover.png",
      title: "Pillow Cover",
      Quntity: 0),
  Laundryitem(
      id: 4,
      imageName: "assets/images/aminities/towel.png",
      title: "Towel",
      Quntity: 0),
  Laundryitem(
      id: 5,
      imageName: "assets/images/aminities/others.png",
      title: "Others",
      Quntity: 0),
];

class Avalable {
  final String title;
  final int id;
  final bool status;

  Avalable({
    required this.title,
    required this.id,
    required this.status,
  });
}

List<Avalable> avalbelitme = [
  Avalable(
    id: 1,
    title: 'Available',
    status: true,
  ),
  Avalable(
    id: 2,
    title: 'Occupied',
    status: false,
  ),
  Avalable(
    id: 3,
    title: 'Under Maintenance',
    status: false,
  ),
];

class AnimitiesListitmes {
  final String imageName;
  final String title;
  final String date;
  final String time;
  final int id;

  AnimitiesListitmes({
    required this.imageName,
    required this.title,
    required this.date,
    required this.time,
    required this.id,
  });
}

List<AnimitiesListitmes> aminitieslist = [
  AnimitiesListitmes(
    imageName: 'assets/images/aminities/laundry.png',
    title: 'Laundry',
    id: 1,
    date: '22nd Feb, 2024',
    time: '10:30 AM - 1:00 PM',
  ),
  AnimitiesListitmes(
    imageName: 'assets/images/aminities/Snooker.png',
    title: 'Snooker',
    id: 2,
    date: '22nd Feb, 2024',
    time: '10:30 AM - 1:00 PM',
  ),
  AnimitiesListitmes(
    imageName: 'assets/images/aminities/swimming_pool.png',
    title: 'Swimming Pool',
    id: 3,
    date: '22nd Feb, 2024',
    time: '10:30 AM - 1:00 PM',
  ),
  AnimitiesListitmes(
    imageName: 'assets/images/aminities/swimming_pool.png',
    title: 'Swimming Pool',
    id: 3,
    date: '22nd Feb, 2024',
    time: '10:30 AM - 1:00 PM',
  ),
  AnimitiesListitmes(
    imageName: 'assets/images/aminities/badminton_court.png',
    title: 'Badminton Court',
    id: 4,
    date: '22nd Feb, 2024',
    time: '10:30 AM - 1:00 PM',
  ),
  AnimitiesListitmes(
    imageName: 'assets/images/aminities/tv_room.png',
    title: 'TV Room/ Entertainment Area',
    id: 5,
    date: '22nd Feb, 2024',
    time: '10:30 AM - 1:00 PM',
  ),
  AnimitiesListitmes(
    imageName: 'assets/images/aminities/football_ground.png',
    title: 'Football Ground',
    id: 6,
    date: '22nd Feb, 2024',
    time: '10:30 AM - 1:00 PM',
  ),
  AnimitiesListitmes(
    imageName: 'assets/images/aminities/Cricket_ground.png',
    title: 'Cricket Ground',
    id: 7,
    date: '22nd Feb, 2024',
    time: '10:30 AM - 1:00 PM',
  ),
];
