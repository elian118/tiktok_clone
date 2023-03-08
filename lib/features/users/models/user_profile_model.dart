class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String birthday;
  final String bio;
  final String link;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.birthday,
    required this.bio,
    required this.link,
    required this.hasAvatar,
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        birthday = '',
        bio = '',
        link = '',
        hasAvatar = false;

  // JsonToDart 플러그인 설치 > ctrl + n > toMap()/toJson() -> 자동생성
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "birthday": birthday,
      "bio": bio,
      "link": link,
      "hasAvatar": hasAvatar,
    };
  }

  // JsonToDart 플러그인 설치 > ctrl + n > fromMap/fromJson factory -> 자동생성
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json["uid"],
      email: json["email"],
      name: json["name"],
      birthday: json["birthday"],
      bio: json["bio"],
      link: json["link"],
      hasAvatar: json["hasAvatar"],
    );
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? birthday,
    String? bio,
    String? link,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
