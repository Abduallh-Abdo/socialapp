class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? coverImage;
  String? bio;
  bool? isEmailVerified;
  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.image,
    this.bio,
    this.coverImage,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    bio = json['bio'];
    image = json['image'];
    coverImage = json['cover_image'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'bio': bio,
      'image': image,
      'cover_image': coverImage,
      'isEmailVerified': isEmailVerified,
    };
  }
}
