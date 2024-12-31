import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/constants/paths.dart';
import 'package:jibber/core/constants/typography.dart';
import 'package:jibber/core/enums.dart';
import 'package:jibber/core/models/user_model.dart';
import 'package:jibber/core/providers/user_provider.dart';
import 'package:jibber/core/services/database_service.dart';
import 'package:jibber/ui/screens/chats/chats_viewmodel.dart';
import 'package:jibber/ui/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider(
      create: (context) => ChatsViewmodel(DatabaseService(), currentUser!),
      child: Consumer<ChatsViewmodel>(builder: (context, model, _) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
          child: Column(
            children: [
              30.verticalSpace,
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Chats", style: heading)),
              20.verticalSpace,
              CustomTextfield(
                isSearch: true,
                hintText: "Search here...",
                onChanged: model.search,
              ),
              10.verticalSpace,
              model.viewState == ViewState.loading
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : model.users.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text("No Users Yet...", style: heading),
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            itemCount: model.filteredUsers.length,
                            separatorBuilder: (context, index) =>
                                8.verticalSpace,
                            itemBuilder: (context, index) {
                              final user = model.filteredUsers[index];
                              return ChatTile(
                                user: user,
                                onTap: () => Navigator.pushNamed(
                                    context, chatRoom,
                                    arguments: user),
                              );
                            },
                          ),
                        )
            ],
          ),
        );
      }),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, this.onTap, required this.user});
  final UserModel user;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      leading: user.imageUrl == null
          ? CircleAvatar(
              radius: 25,
              child: Text(
                user.name![0],
                style: heading,
              ),
            )
          : ClipOval(
              child: Image.network(
                user.imageUrl!,
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
            ),
      title: Text(user.name!),
      subtitle: Text(
        user.lastMessage != null ? user.lastMessage!["content"] : "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            user.lastMessage == null ? "" : getTime(),
          ),
          8.verticalSpace,
          user.unreadCounter == 0 || user.unreadCounter == null
              ? const SizedBox(
                  height: 15,
                )
              : CircleAvatar(
                  radius: 9.r,
                  child: Text(
                    "${user.unreadCounter}",
                    style: small,
                  ),
                )
        ],
      ),
    );
  }

  String getTime() {
    DateTime now = DateTime.now();

    DateTime lastMessageTime = user.lastMessage == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(user.lastMessage!["timestamp"]);

    int minutes = now.difference(lastMessageTime).inMinutes % 60;

    if (minutes < 60) {
      return "$minutes minutes ago";
    } else {
      return "${now.difference(lastMessageTime).inHours % 24} hours ago";
    }
  }
}