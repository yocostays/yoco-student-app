class UnbordingContent {
  String? image;
  String? title;
  String? discription;

  UnbordingContent({this.image, this.title, this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Introducing Powerhouse for Hostel Perfection',
      image: 'assets/svg/onboarding1.svg',
      discription: "One Platform, Many Super Powers"),
  UnbordingContent(
      title: 'Effortless Management, Every Step',
      image: 'assets/svg/onboarding2.svg',
      discription:
          "Simplify daily operations with automated solutions for seamless hostel life."),
  UnbordingContent(
      title: 'Empowering Connection & Convenience',
      image: 'assets/svg/onboarding3.svg',
      discription:
          "From fees to feedback, all in one place—experience the ease of staying connected"),
];
