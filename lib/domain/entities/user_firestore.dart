class FireStoreUser {
  final String email;
  final bool? isNewUser;

  FireStoreUser({
    required this.email,
    this.isNewUser,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        if (isNewUser != null) 'isNewUser': isNewUser,
      };

  factory FireStoreUser.fromJson(Map<String, dynamic> json) => FireStoreUser(
        email: json['email'] ?? '',
        isNewUser: json['isNewUser'] is bool
            ? json['isNewUser']
            : json['isNewUser'] == 'true',
      );

  FireStoreUser copyWith({
    String? email,
    String? name,
    bool? isNewUser,
  }) {
    return FireStoreUser(
      email: email ?? this.email,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }
}
