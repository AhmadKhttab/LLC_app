class Courses {
  final int? id;
  final String? code;
  final String? Name_Ar;
  final String? Name_En;
  final String? Description;
  final int? Status;
  final int? pecializations_ID;

  Courses({
    this.id,
    this.code,
    this.Name_Ar,
    this.Name_En,
    this.Description,
    this.Status,
    this.pecializations_ID,
  });

  // Method to create a Program instance from JSON data
  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      id: json['ID'] != null ? json['ID'] as int : null,
      code: json['code'] != null ? json['code'] as String : null,
      Name_Ar: json['Name_Ar'] != null ? json['Name_Ar'] as String : null,
      Name_En: json['Name_En'] != null ? json['Name_En'] as String : null,
      Description:
          json['Description'] != null ? json['Description'] as String : null,
      Status: json['Status'] != null ? json['Status'] as int : null,
      pecializations_ID: json['pecializations_ID'] != null
          ? json['pecializations_ID'] as int
          : null,
    );
  }
}
