class CencelHistoryData {
  String? sId;
  String? date;
  bool? canUndoBooking;
  bool? breakfast;
  bool? lunch;
  bool? dinner;
  bool? snacks;
  String? cancellationReason;
  String? bookingStatus;

  CencelHistoryData(
      {this.sId,
      this.date,
      this.breakfast,
      this.canUndoBooking,
      this.lunch,
      this.dinner,
      this.snacks,
      this.cancellationReason,
      this.bookingStatus});

  CencelHistoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    breakfast = json['breakfast'];
    canUndoBooking = json['canUndoBooking'];
    lunch = json['lunch'];
    dinner = json['dinner'];
    snacks = json['snacks'];
    cancellationReason = json['cancellationReason'];
    bookingStatus = json['bookingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['date'] = date;
    data['breakfast'] = breakfast;
    data['canUndoBooking'] = canUndoBooking;
    data['lunch'] = lunch;
    data['dinner'] = dinner;
    data['snacks'] = snacks;
    data['cancellationReason'] = cancellationReason;
    data['bookingStatus'] = bookingStatus;
    return data;
  }
}
