class User {
  final String id;
  final String email;
  final String fullName;
  final bool isActive;
  final List<String> roles;
  final String token;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.isActive,
    required this.roles,
    required this.token,
  });

  bool get isAdmin {
    return roles.contains('admin');
  }

  // factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
  //     CreditsResponse(
  //       id: json["id"],
  //       email: json["email"],
  //       fullName: json["fullName"],
  //       isActive: json["isActive"],
  //       roles: List<String>.from(json["roles"].map((x) => x)),
  //       token: json["token"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "email": email,
  //       "fullName": fullName,
  //       "isActive": isActive,
  //       "roles": List<dynamic>.from(roles.map((x) => x)),
  //       "token": token,
  //     };
}
