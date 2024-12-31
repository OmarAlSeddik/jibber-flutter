import 'package:flutter/material.dart';
import 'package:jibber/core/providers/user_provider.dart';
import 'package:jibber/ui/screens/chats/chats_screen.dart';
import 'package:jibber/ui/screens/main/main_viewmodel.dart';
import 'package:jibber/ui/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> _screens = [
    const ChatsScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;

    final items = [
      BottomNavigationBarItem(
          label: "Chats",
          icon: Icon(
            Icons.chat_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 24.0,
            semanticLabel: 'Chats Screen',
          )),
      BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(
            Icons.person_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 24.0,
            semanticLabel: 'Profile Screen',
          )),
    ];
    return ChangeNotifierProvider(
      create: (context) => MainViewmodel(),
      child: Consumer<MainViewmodel>(builder: (context, model, _) {
        return currentUser == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: MainScreen._screens[model.currentIndex],
                bottomNavigationBar: CustomNavBar(
                  onTap: model.setIndex,
                  items: items,
                ));
      }),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key, this.onTap, required this.items});

  final void Function(int)? onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BottomNavigationBar(
        onTap: onTap,
        items: items,
      ),
    );
  }
}
