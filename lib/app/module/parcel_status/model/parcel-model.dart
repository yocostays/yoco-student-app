// ignore_for_file: public_member_api_docs, sort_constructors_first
class ParcelModel {
  final int id;
  final String imageName;
  final String title;

  ParcelModel({
    required this.id,
    required this.imageName,
    required this.title,
  });
}

List<ParcelModel> Parcelitems = [
  ParcelModel(
    id: 1,
    imageName: "assets/images/parcel/news_paper.png",
    title: 'Newspaper',
  ),
  ParcelModel(
    id: 2,
    imageName: "assets/images/parcel/delivery_boy.png",
    title: 'Delivery Boy',
  ),
  ParcelModel(
    id: 3,
    imageName: "assets/images/parcel/milk.png",
    title: 'Milkman',
  ),
  ParcelModel(
    id: 4,
    imageName: "assets/images/parcel/tiffine_box.png",
    title: 'Tiffin Service',
  ),
];

class ParcelQnquiry {
  final int id;
  final String imageName;
  final String title;
  final String date;
  final String time;

  ParcelQnquiry({
    required this.id,
    required this.imageName,
    required this.title,
    required this.date,
    required this.time,
  });
}

List<ParcelQnquiry> parcelList = [
  ParcelQnquiry(
    id: 1,
    imageName: "assets/images/parcel/news_paper.png",
    title: 'Newspaper',
    time: '10:30 AM - 1:00 PM',
    date: '22nd Feb, 2024',
  ),
  ParcelQnquiry(
    id: 2,
    imageName: "assets/images/parcel/delivery_boy.png",
    title: 'Delivery Boy',
    time: '10:30 AM - 1:00 PM',
    date: '22nd Feb, 2024',
  ),
  ParcelQnquiry(
    id: 3,
    imageName: "assets/images/parcel/milk.png",
    title: 'Milkman',
    time: '10:30 AM - 1:00 PM',
    date: '22nd Feb, 2024',
  ),
  ParcelQnquiry(
    id: 4,
    imageName: "assets/images/parcel/tiffine_box.png",
    title: 'Tiffin Service',
    time: '10:30 AM - 1:00 PM',
    date: '22nd Feb, 2024',
  ),
];
