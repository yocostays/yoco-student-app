// ignore_for_file: public_member_api_docs, sort_constructors_first
class KycModel {
  String filename;
  String? image;
  String? networkImage;
  bool uploaded;
  bool error;
  int id;

  KycModel({
    required this.filename,
    this.image,
    this.networkImage,
    this.uploaded = false,
    this.error = false,
    required this.id,
  });
}

List<KycModel> kycitem = [
  KycModel(
      id: 1,
      filename: 'Aadhaar Card',
      image: "assets/images/profile_image/addhar_card.png",
      uploaded: true),
  KycModel(
      id: 2,
      filename: 'Passport',
      image: "assets/images/profile_image/passport.png",
      error: true),
  KycModel(
      id: 3,
      filename: 'Voter Card',
      image: "assets/images/profile_image/voter_id.png",
      uploaded: false),
  KycModel(
      id: 4,
      filename: 'Driving License',
      image: "assets/images/profile_image/driving_licence.png",
      uploaded: true),
  KycModel(
      id: 5,
      filename: 'PAN Card',
      image: "assets/images/profile_image/pen_card.png",
      uploaded: false),
];
