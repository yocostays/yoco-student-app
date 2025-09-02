class EmergencyItem {
  final String image;
  final int id;
  final String name;

  EmergencyItem({
    required this.image,
    required this.id,
    required this.name,
  });

  // Optionally, you can add methods for convenience, such as fromJson and toJson
  factory EmergencyItem.fromJson(Map<String, dynamic> json) {
    return EmergencyItem(
      image: json['image'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'id': id,
      'name': name,
    };
  }
}

List<EmergencyItem> EmergencydataList = [
  EmergencyItem(
    image: "assets/images/emergency_support/medical_emergency.png",
    id: 1,
    name: "Medical Emergency",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/theft.png",
    id: 2,
    name: "Theft",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/need_food.png",
    id: 3,
    name: "Need Food",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/lift.png",
    id: 4,
    name: "Stuck In Lift",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/natural_disater.png",
    id: 5,
    name: "Natural Disaster",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/Violence.png",
    id: 6,
    name: "Violence",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/Fire_emergency.png",
    id: 7,
    name: "Fire Emergency",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/complaint.png",
    id: 8,
    name: "Threat",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/Mental_depression.png",
    id: 9,
    name: "Mental Depression",
  ),
  EmergencyItem(
    image: "assets/images/emergency_support/Suicidal_emergency.png",
    id: 10,
    name: "Suicidal Emergency",
  ),
];

class Chat {
  int id;
  String user;
  String message;

  Chat({required this.id, required this.user, required this.message});

  // Method to display the chat details
  void displayChat() {
    print('ID: $id');
    print('User: $user');
    print('Message: $message');
  }
}

List<Chat> chates = [
  Chat(
    id: 1,
    user: 'sender',
    message: 'Hey! How have you been?',
  ),
  Chat(
    id: 1,
    user: 'Reciver',
    message: "Awesome! Let’s meet up",
  ),
];
