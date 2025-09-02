import 'package:yoco_stay_student/app/module/complaint_managment/model/complain_model.dart';

class ComplaintUtils {
  // Function to get image name based on category from API
  static String getImageNameFromCategory(String category) {
    // Loop through ComplaintItemList to find matching title
    for (var item in complaintItems) {
      if (item.title.toLowerCase() == category.toLowerCase()) {
        return item.imageName;
      }
    }
    // Return a default image if no match is found
    return 'assets/images/Complaints/Others_logo.png';
  }
}
