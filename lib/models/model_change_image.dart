class ChangeImageModel {
  int sourceId;
  String sourceType;
  String profileImage;

  ChangeImageModel({
    required this.sourceId,
    required this.sourceType,
    required this.profileImage,
  });

  factory ChangeImageModel.fromJson(Map<String, dynamic> json) =>
      ChangeImageModel(
        sourceId: json["source_id"],
        sourceType: json["source_type"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
    "source_id": sourceId,
    "source_type": sourceType,
    "profile_image": 'data:image/jpg;base64,' + profileImage,
  };
}