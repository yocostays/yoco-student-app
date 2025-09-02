// ignore_for_file: non_constant_identifier_names

import 'package:yoco_stay_student/app/module/amenities_booking/model.dart';

class ComplaintItem {
  final String imageName;
  final String title;
  final List<Complaint> complaints;

  ComplaintItem({
    required this.imageName,
    required this.title,
    required this.complaints,
  });
}

List<ComplaintItem> complaintItems = [
  ComplaintItem(
    imageName: 'assets/images/Complaints/security_logo.png',
    title: 'Security',
    complaints: security_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/parking_logo.png',
    title: 'Parking',
    complaints: parking_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/electricity_logo.png',
    title: 'Electricity',
    complaints: electricity_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/water_logo.png',
    title: 'Water',
    complaints: water_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/Housekeeping_logo.png',
    title: 'Housekeeping',
    complaints: housekeeping_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/lift_logo.png',
    title: 'Lift',
    complaints: lift_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/Amenities_logo.png',
    title: 'Amenities',
    complaints: amenities_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/Room-mate_logo.png',
    title: 'Room-Mate',
    complaints: roommate_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/Rent_Issue_logo.png',
    title: 'Rent Issue',
    complaints: Rentissue_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/Medical_logo.png',
    title: 'Medical',
    complaints: medical_complaints,
  ),
  ComplaintItem(
    imageName: 'assets/images/Complaints/Others_logo.png',
    title: 'others',
    complaints: others_complaints,
  ),
  // Add more items as needed
];

class Complaint {
  final int id;
  final String complaint;

  Complaint({
    required this.id,
    required this.complaint,
  });

  // Optionally, you can add methods for convenience, such as fromJson and toJson
  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      complaint: json['complaint'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'complaint': complaint,
    };
  }
}

List<Complaint> security_complaints = [
  Complaint(id: 1, complaint: 'Absence of a Security Guard.'),
  Complaint(id: 2, complaint: 'Guard denied duty.'),
  Complaint(id: 3, complaint: 'Misbehaviour of Security Guard'),
  Complaint(id: 4, complaint: 'Security guard is drinking/ smoking on duty.'),
  Complaint(id: 5, complaint: 'Security guard Sleeping on Duty.'),
  Complaint(id: 6, complaint: 'Parcel Missing or Security Breaches.'),
  Complaint(id: 7, complaint: 'Failure to Respond to Emergencies.'),
  Complaint(id: 8, complaint: 'Violence in Hostel (Ragging).'),
  Complaint(id: 9, complaint: 'Suspicious Person seen in Hostel.'),
  Complaint(id: 10, complaint: 'Others.'),
];

List<Complaint> parking_complaints = [
  Complaint(id: 1, complaint: 'Unable to Find Guest Parking Space.'),
  Complaint(id: 2, complaint: 'Vehicle Missing from Parking.'),
  Complaint(
      id: 3, complaint: 'Unauthorised Vehicle Parked in My Designated Spot'),
  Complaint(
      id: 4, complaint: 'No Available Parking Spaces Due to Crowded Lot.'),
  Complaint(
      id: 5, complaint: 'Request for Enhanced Parking Lot Security Measures.'),
  Complaint(id: 6, complaint: 'Insufficient Lighting in the Parking Area.'),
  Complaint(id: 7, complaint: 'Others.'),
];

List<Complaint> electricity_complaints = [
  Complaint(id: 1, complaint: 'Electrical Problem in My Room.'),
  Complaint(id: 2, complaint: 'Electric Fault in a Building.'),
  Complaint(id: 3, complaint: 'Electricity Cut on My Floor.'),
  Complaint(id: 4, complaint: 'Flickering Lights in Common Areas.'),
  Complaint(id: 5, complaint: 'Voltage Fluctuations Causing Appliance Damage.'),
  Complaint(id: 6, complaint: 'Overloaded Circuits Tripping Frequently.'),
  Complaint(
      id: 7, complaint: 'Inadequate Lighting in Corridors and Stairwells.'),
  Complaint(
      id: 8, complaint: 'Inadequate Lighting in Corridors and Stairwells.'),
  Complaint(id: 9, complaint: 'Issues Related to CCTV Cameras.'),
  Complaint(id: 10, complaint: 'Others.'),
];

List<Complaint> water_complaints = [
  Complaint(id: 1, complaint: 'Drinking Water Issue.'),
  Complaint(id: 2, complaint: 'General Water Availability.'),
  Complaint(id: 3, complaint: 'Water Pipeline Damaged.'),
  Complaint(id: 4, complaint: 'Water Tank is not Clean.'),
  Complaint(id: 5, complaint: 'Tap Leakages & Shower Malfunctions.'),
  Complaint(id: 6, complaint: 'Hot Water Problems.'),
  Complaint(id: 7, complaint: 'Water Quality Concerns.'),
  Complaint(id: 8, complaint: 'Drainage and Sewage Issues.'),
  Complaint(id: 9, complaint: 'Others.'),
];

List<Complaint> housekeeping_complaints = [
  Complaint(id: 1, complaint: 'Unclean Bathrooms.'),
  Complaint(id: 2, complaint: 'Lack of Regular Cleaning.'),
  Complaint(id: 3, complaint: 'Unpleasant Odors.'),
  Complaint(id: 4, complaint: 'Inadequate Waste Management.'),
  Complaint(id: 5, complaint: 'Insufficient Supplies.'),
  Complaint(id: 6, complaint: 'Neglected Common Areas.'),
  Complaint(id: 7, complaint: 'Maintenance Issues.'),
  Complaint(id: 8, complaint: 'Lack of Staff Response.'),
  Complaint(id: 9, complaint: 'Others.'),
];

List<Complaint> lift_complaints = [
  Complaint(id: 1, complaint: 'Lift Out of Service.'),
  Complaint(id: 2, complaint: 'Lift Fan Malfunction.'),
  Complaint(id: 3, complaint: 'Cleanliness Concerns.'),
  Complaint(id: 4, complaint: 'Unusual Noise From Lift.'),
  Complaint(id: 5, complaint: 'Door Malfunction.'),
  Complaint(id: 6, complaint: 'Inadequate Lighting.'),
  Complaint(id: 7, complaint: 'Others.'),
];

List<Complaint> amenities_complaints = [
  Complaint(id: 1, complaint: 'Difficulty in Amenities Booking.'),
  Complaint(id: 2, complaint: 'Unauthorised Use of Amenities Slot.'),
  Complaint(
      id: 3, complaint: 'Poor Maintenance of the Swimming Pool/Other sports.'),
  Complaint(id: 4, complaint: 'Damaged Equipment in Amenities Area.'),
  Complaint(id: 5, complaint: 'Insufficient Lighting in Amenities Spaces.'),
  Complaint(id: 6, complaint: 'Laundry related complaints.'),
  Complaint(
      id: 7, complaint: 'Inadequate Storage Space for Amenities Equipment.'),
  Complaint(id: 8, complaint: 'Others.'),
];

List<Complaint> roommate_complaints = [
  Complaint(id: 1, complaint: 'Roommate talking on mobile Overnight.'),
  Complaint(id: 2, complaint: 'Roommate creating noise.'),
  Complaint(id: 3, complaint: 'Messy living habits'),
  Complaint(id: 4, complaint: 'Borrowing without asking.'),
  Complaint(id: 5, complaint: 'Lack of communication.'),
  Complaint(id: 6, complaint: 'Different schedules.'),
  Complaint(id: 7, complaint: 'Personal hygiene.'),
  Complaint(id: 8, complaint: 'Room change request.'),
  Complaint(id: 9, complaint: 'Others.'),
];

List<Complaint> Rentissue_complaints = [
  Complaint(id: 1, complaint: 'Late rent payment.'),
  Complaint(id: 2, complaint: 'Hostel fees bill not received.'),
  Complaint(id: 3, complaint: 'Amount debited but wallet not updated.'),
  Complaint(id: 4, complaint: 'Disputes over hostel fees amount.'),
  Complaint(id: 5, complaint: 'Failure to pay utilities or shared expenses.'),
  Complaint(id: 6, complaint: 'Issues with fee increase or lease terms.'),
  Complaint(
      id: 7, complaint: 'Difficulty with fee collection or payment method.'),
  Complaint(
      id: 8,
      complaint: 'Hostel fee payment delays due to unforeseen circumstances.'),
  Complaint(id: 9, complaint: 'Emergencies.'),
];

List<Complaint> medical_complaints = [
  Complaint(id: 1, complaint: 'Delayed medical assistance.'),
  Complaint(id: 2, complaint: 'Lack of access to essential medications.'),
  Complaint(id: 3, complaint: 'Insufficient medical facilities (First-Aid).'),
  Complaint(id: 4, complaint: 'Inadequate hygiene standards.'),
  Complaint(id: 5, complaint: 'Mismanagement of medical records.'),
  Complaint(id: 6, complaint: 'Inadequate mental health support.'),
  Complaint(id: 7, complaint: 'Difficulty in obtaining medical appointments.'),
];

List<Complaint> others_complaints = [];

List<AnimitiesListitmes> ComplaintItemList = [
  AnimitiesListitmes(
    id: 01,
    imageName: 'assets/images/8496260 1.png',
    title: 'Lift',
    date: '22nd Feb, 2024',
    time: '10:30 AM',
  ),
  AnimitiesListitmes(
    id: 01,
    imageName: 'assets/images/Complaints/parking_logo.png',
    title: 'parking',
    date: '22nd Feb, 2024',
    time: '10:30 AM',
  ),
  AnimitiesListitmes(
    id: 01,
    imageName: 'assets/images/Complaints/electricity_logo.png',
    title: 'Electricity',
    date: '22nd Feb, 2024',
    time: '10:30 AM',
  ),
  AnimitiesListitmes(
    id: 01,
    imageName: 'assets/images/Complaints/water_logo.png',
    title: 'Water',
    date: '22nd Feb, 2024',
    time: '10:30 AM',
  ),
  AnimitiesListitmes(
    id: 01,
    imageName: 'assets/images/Complaints/Room-mate_logo.png',
    title: 'Room-mate',
    date: '22nd Feb, 2024',
    time: '10:30 AM',
  ),
  AnimitiesListitmes(
    id: 01,
    imageName: 'assets/images/Complaints/Medical_logo.png',
    title: 'Medical',
    date: '22nd Feb, 2024',
    time: '10:30 AM',
  ),
  AnimitiesListitmes(
    id: 01,
    imageName: 'assets/images/Complaints/Others_logo.png',
    title: 'Others',
    date: '22nd Feb, 2024',
    time: '10:30 AM',
  ),
];
