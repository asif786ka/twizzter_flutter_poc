import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? username;
  final String? email;
  final String? profileImageUrl;
  final int? followers;
  final int? following;
  final String? bio;

  const User({
    this.id,
    this.username,
    this.email,
    this.profileImageUrl,
    this.followers,
    this.following,
    this.bio,
  });

  static const empty = User(
    id: '',
    username: '',
    email: '',
    profileImageUrl: 'https://picsum.photos/250?image=9',
    followers: 0,
    following: 0,
    bio: '',
  );

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        profileImageUrl,
        followers,
        following,
        bio,
      ];

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? profileImageUrl,
    int? followers,
    int? following,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following,
      'bio': bio,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic>? fetchDoc = doc.data() as Map<String, dynamic>?;
    return User(
      id: doc.id,
      username: fetchDoc?['username'] ?? 'usernameempty',
      email: fetchDoc?['email'] ?? 'emailempty',
      profileImageUrl: fetchDoc?['profileImageUrl'] ?? 'https://picsum.photos/250?image=9',
      followers: (fetchDoc?['followers'] ?? 0).toInt(),
      following: (fetchDoc?['following'] ?? 0).toInt(),
      bio: fetchDoc?['bio'] ?? '',
    );
  }
}
