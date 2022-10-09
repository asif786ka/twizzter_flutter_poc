import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twizzter/blocs/blocs.dart';
import 'package:twizzter/screens/profile/bloc/profile_bloc.dart';
import 'package:twizzter/screens/profile/widgets/widgets.dart';
import 'package:twizzter/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(content: state.failure.message),
          );
        }
      },
      builder: (context, state) {
        print("pr0file screen${state.user.toString()}");
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              state.user.username ?? 'No username',
              style: const TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            actions: [
              if (state.isCurrentUser)
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () => _logOut(context),
                ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0),
                      child: Row(
                        children: [
                          UserProfileImage(
                            radius: 40.0,
                            profileImageUrl: state.user.profileImageUrl,
                          ),
                          ProfileStats(
                            isCurrentUser: state.isCurrentUser,
                            isFollowing: state.isFollowing,
                            posts: 0, // state.posts.length
                            followers: state.user.followers ?? 0,
                            following: state.user.following ?? 0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: ProfileInfo(
                        username: state.user.username ?? 'No user info returned',
                        bio: state.user.bio ?? 'No bio',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _logOut(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogoutRequested());
    SystemNavigator.pop();
  }
}
