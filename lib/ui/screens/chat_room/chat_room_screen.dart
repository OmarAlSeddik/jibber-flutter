import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/constants/typography.dart';
import 'package:jibber/core/context_extension.dart';
import 'package:jibber/core/models/user_model.dart';
import 'package:jibber/core/providers/user_provider.dart';
import 'package:jibber/core/services/chat_service.dart';
import 'package:jibber/ui/screens/chat_room/chat_room_viewmodel.dart';
import 'package:jibber/ui/widgets/chat_widgets.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.receiver});
  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider(
      create: (context) =>
          ChatRoomViewmodel(ChatService(), currentUser!, receiver),
      child: Consumer<ChatRoomViewmodel>(builder: (context, model, _) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.sw * 0.05, vertical: 10.h),
                  child: Column(
                    children: [
                      35.verticalSpace,
                      _buildHeader(context, name: receiver.name!),
                      15.verticalSpace,
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(0),
                          itemCount: model.messages.length,
                          separatorBuilder: (context, index) =>
                              10.verticalSpace,
                          itemBuilder: (context, index) {
                            final message = model.messages[index];
                            return ChatBubble(
                              isCurrentUser:
                                  message.senderId == currentUser!.uid,
                              message: message,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BottomField(
                controller: model.controller,
                onTap: () async {
                  try {
                    await model.saveMessage();
                  } catch (e) {
                    context.showSnackbar(e.toString());
                  }
                },
              )
            ],
          ),
        );
      }),
    );
  }

  Row _buildHeader(BuildContext context, {String name = ""}) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        15.horizontalSpace,
        Text(
          name,
          style: heading.copyWith(fontSize: 20.sp),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
