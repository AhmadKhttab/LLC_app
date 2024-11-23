class Trainerss {
  final String? First_Name_En;
  final String? Last_Name_En;
  final String? Image;
  final int? course_count;

  Trainerss({
    this.First_Name_En,
    this.Last_Name_En,
    this.Image,
    this.course_count,
  });

  // Method to create a Program instance from JSON data
  factory Trainerss.fromJson(Map<String, dynamic> json) {
    return Trainerss(
      First_Name_En: json['First_Name_En'] != null
          ? json['First_Name_En'] as String
          : null,
      Last_Name_En:
          json['Last_Name_En'] != null ? json['Last_Name_En'] as String : null,
      Image: json['Image'] != null ? json['Image'] as String : null,
      course_count:
          json['course_count'] != null ? json['course_count'] as int : null,
    );
  }
}
