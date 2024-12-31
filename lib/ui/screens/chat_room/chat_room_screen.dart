import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/constants/typography.dart';
import 'package:jibber/core/models/message_model.dart';
import 'package:jibber/core/models/user_model.dart';
import 'package:jibber/core/providers/user_provider.dart';
import 'package:jibber/core/services/chat_service.dart';
import 'package:jibber/ui/screens/chat_room/chat_room_viewmodel.dart';
import 'package:jibber/ui/widgets/chat_widgets.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({super.key, required this.receiver});
  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider(
      create: (context) =>
          ChatRoomViewmodel(ChatService(), currentUser!, receiver),
      child: Consumer<ChatRoomViewmodel>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: receiver.imageUrl != null
                        ? NetworkImage(receiver.imageUrl!)
                        : null,
                    child: receiver.imageUrl == null
                        ? Text(receiver.name?[0] ?? '', style: heading)
                        : null,
                  ),
                  SizedBox(width: 10.w),
                  Text(receiver.name ?? '', style: heading),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // WIP: Add functionality for more options
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: MessageList(
                      messages: model.messages,
                      currentUserId: currentUser!.uid as String,
                    ),
                  ),
                ),
                BottomField(
                  controller: model.controller,
                  onTap: () async {
                    try {
                      await model.saveMessage();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  const MessageList({
    super.key,
    required this.messages,
    required this.currentUserId,
  });

  final List<Message> messages;
  final String currentUserId;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant MessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > oldWidget.messages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages[index];
        return ChatBubble(
          isCurrentUser: message.senderId == widget.currentUserId,
          message: message,
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
