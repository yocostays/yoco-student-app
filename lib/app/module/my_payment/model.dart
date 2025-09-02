class PayMentlist {
  final int id;
  final String name;

  PayMentlist({required this.id, required this.name});
}

List<PayMentlist> paymenttitlelist = [
  PayMentlist(
    id: 1,
    name: 'Rent Billing',
  ),
  PayMentlist(
    id: 2,
    name: 'Fine Dues',
  ),
  PayMentlist(
    id: 3,
    name: 'Pay For Events',
  ),
  PayMentlist(
    id: 4,
    name: 'Payment History',
  ),
];

class itemlist {
  int id;
  String name;
  String reason;
  String date;
  int price;
  bool selected;

  itemlist({
    required this.id,
    required this.name,
    required this.reason,
    required this.date,
    required this.price,
    required this.selected, // Default value for selected is false
  });
}

List<itemlist> finedueslist = [
  itemlist(
      id: 1,
      name: 'Harsh jogi',
      reason: 'CCtv',
      date: '22nd Feb, 2024',
      price: 400,
      selected: false),
  itemlist(
      id: 2,
      name: 'Harsh jogi',
      reason: 'CCtv',
      date: '22nd Feb, 2024',
      price: 200,
      selected: false),
  itemlist(
      id: 3,
      name: 'Harsh jogi',
      reason: 'CCtv',
      date: '22nd Feb, 2024',
      price: 300,
      selected: false),
];
