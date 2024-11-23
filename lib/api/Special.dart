class Special {
  final int? id;

  final String? Name_Ar;
  final String? Name_En;
  final String? Description;
  final int? Status;
  final int? Program_ID;
  Special(
      {this.id,
      this.Name_Ar,
      this.Name_En,
      this.Description,
      this.Status,
      this.Program_ID});

  // Method to create a Program instance from JSON data
  factory Special.fromJson(Map<String, dynamic> json) {
    return Special(
      id: json['ID'] != null ? json['ID'] as int : null,
      Name_Ar: json['Name_Ar'] != null ? json['Name_Ar'] as String : null,
      Name_En: json['Name_En'] != null ? json['Name_En'] as String : null,
      Description:
          json['Description'] != null ? json['Description'] as String : null,
      Status: json['Status'] != null ? json['Status'] as int : null,
      Program_ID: json['Program_ID'] != null ? json['Program_ID'] as int : null,
    );
  }
}
