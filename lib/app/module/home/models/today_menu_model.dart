class TodayMenuModel {
  String? sId;
  String? date;
  String? breakfast;
  String? lunch;
  String? snacks;
  String? dinner;

  TodayMenuModel(
      {this.sId,
      this.date,
      this.breakfast,
      this.lunch,
      this.snacks,
      this.dinner});

  TodayMenuModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    breakfast = json['breakfast'];
    lunch = json['lunch'];
    snacks = json['snacks'];
    dinner = json['dinner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['date'] = date;
    data['breakfast'] = breakfast;
    data['lunch'] = lunch;
    data['snacks'] = snacks;
    data['dinner'] = dinner;
    return data;
  }
}
