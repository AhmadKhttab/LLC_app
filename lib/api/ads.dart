class ads {
  final int? id;
  final String? Title;
  final String? Image;
  final String? Description;
  final int? Status;

  ads({
    this.id,
    this.Title,
    this.Image,
    this.Description,
    this.Status,
  });

  // Method to create a Program instance from JSON data
  factory ads.fromJson(Map<String, dynamic> json) {
    return ads(
      id: json['ID'] != null ? json['ID'] as int : null,
      Title: json['Title'] != null ? json['Title'] as String : null,
      Image: json['Image'] != null ? json['Image'] as String : null,
      Description:
          json['Description'] != null ? json['Description'] as String : null,
      Status: json['Status'] != null ? json['Status'] as int : null,
    );
  }
}
