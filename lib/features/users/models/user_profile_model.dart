class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        bio = '',
        link = '';

  // JsonToDart 플러그인 설치 > ctrl + n > toMap()/toJson() -> 자동생성
  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
    };
  }

  // JsonToDart 플러그인 설치 > ctrl + n > fromMap/fromJson factory -> 자동생성
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json["uid"],
      email: json["email"],
      name: json["name"],
      bio: json["bio"],
      link: json["link"],
    );
  }
}
