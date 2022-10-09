import 'package:flutter/material.dart';
import 'package:twizzter/screens/screens.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({
    Key? key,
    required this.isCurrentUser,
    required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              EditProfileScreen.routeName,
              arguments: EditProfileScreenArgs(context: context),
            ),
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.amber,
                textStyle: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
            child: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        : TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                foregroundColor: isFollowing ? Colors.grey[300] : Theme.of(context).primaryColor,
                backgroundColor: isFollowing ? Colors.black : Colors.white,
                textStyle: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: const TextStyle(fontSize: 16.0),
            ),
          );
  }
}
