class Event {
  final int? id;

  final String? Name_Ar;
  final String? Name_En;
  final String? Description;
  final int? Status;

  Event({
    this.id,
    this.Name_Ar,
    this.Name_En,
    this.Description,
    this.Status,
  });

  // Method to create a Program instance from JSON data
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['ID'] != null ? json['ID'] as int : null,
      Name_Ar: json['Name_Ar'] != null ? json['Name_Ar'] as String : null,
      Name_En: json['Name_En'] != null ? json['Name_En'] as String : null,
      Description:
          json['Description'] != null ? json['Description'] as String : null,
      Status: json['Status'] != null ? json['Status'] as int : null,
    );
  }
}
