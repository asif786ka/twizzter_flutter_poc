import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  final double radius;
  final String? profileImageUrl;
  final File? profileImage;

  const UserProfileImage({
    Key? key,
    required this.radius,
    this.profileImageUrl,
    this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      backgroundImage: profileImageUrl != null
          ? CachedNetworkImageProvider(profileImageUrl!)
          : const CachedNetworkImageProvider('https://picsum.photos/250?image=9'),
      child: _noProfileIcon(),
    );
  }

  Icon? _noProfileIcon() {
    if (profileImage == null && profileImageUrl!.isEmpty) {
      return Icon(
        Icons.account_circle,
        color: Colors.grey[400],
        size: radius * 2,
      );
    }
    return null;
  }
}
