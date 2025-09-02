class TotalHomedata {
  int? complainCount;
  int? leaveCount;
  int? eventCount;
  int? announcement;

  TotalHomedata(
      {this.complainCount,
      this.leaveCount,
      this.eventCount,
      this.announcement});

  TotalHomedata.fromJson(Map<String, dynamic> json) {
    complainCount = json['complainCount'];
    leaveCount = json['leaveCount'];
    eventCount = json['eventCount'];
    announcement = json['announcement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['complainCount'] = complainCount;
    data['leaveCount'] = leaveCount;
    data['eventCount'] = eventCount;
    data['announcement'] = announcement;
    return data;
  }
}
