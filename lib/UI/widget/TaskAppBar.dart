import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screen/Login_Screen.dart';
import 'package:task_manager/UI/Screen/UpdateProfileScreen.dart';
import 'package:task_manager/UI/controllers/auth_controller.dart';

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppBar({super.key, required this.UpdateProfileScreen});

  final bool UpdateProfileScreen;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return AppBar(
      title: GestureDetector(
        onTap: () {
          UpdateProfileScreen
              ? (Navigator.pushNamed(context, Updateprofilescreen.name,))
              : ();
        },
        child: Row(
          children: [
            CircleAvatar(radius:16,
              backgroundImage: MemoryImage(
                base64Decode(AuthController.userData?.photo ?? ''),
              ),
              onBackgroundImageError: (_, __) => Icon(Icons.person),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AuthController.userData?.firstName ?? ''} ${AuthController.userData?.lastName ?? ''}.',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 0),
                  Text(
                    AuthController.userData?.email ?? '',
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color.fromARGB(255, 114, 255, 59),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Log out'),
                      content: Text('Do you want to Log out '),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await AuthController.clearUserData();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginScreen.name,
                              (value) => false,
                            );
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.output, color: Colors.black, size: 36),
            ),
          ],
        ),
      ), // or any title you want
      centerTitle: true,
      backgroundColor: Colors.blue,
      toolbarHeight: 60,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
