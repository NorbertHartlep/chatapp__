import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/compnents/compnents.dart';
import 'package:zego_zimkit/pages/message_list_page.dart';
import 'package:zego_zimkit/services/services.dart';
import 'package:zego_zimkit/utils/dialogs_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.username}) : super(key: key);
  final String username;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${widget.username}, there are your messages"),
        actions: [
          PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            position: PopupMenuPosition.under,
            icon: const Icon(CupertinoIcons.add_circled),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "New chat",
                  child: const ListTile(
                    leading: Icon(CupertinoIcons.chat_bubble_2_fill),
                    title: Text(
                      "New Chat",
                      maxLines: 1,
                    ),
                  ),
                  onTap: () => ZIMKit().showDefaultNewPeerChatDialog(context),
                ),
                PopupMenuItem(
                  value: "New group",
                  child: const ListTile(
                    leading: Icon(CupertinoIcons.person_2_fill),
                    title: Text(
                      "New Group",
                      maxLines: 1,
                    ),
                  ),
                  onTap: () => ZIMKit().showDefaultNewGroupChatDialog(context),
                ),
                PopupMenuItem(
                  value: "Join group",
                  child: const ListTile(
                    leading: Icon(Icons.group_add),
                    title: Text(
                      "Join Group",
                      maxLines: 1,
                    ),
                  ),
                  onTap: () => ZIMKit().showDefaultJoinGroupDialog(context),
                ),
              ];
            },
          )
        ],
      ),
      body: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ZIMKitMessageListPage(
                conversationID: conversation.id,
                conversationType: conversation.type,
              );
            }),
          );
        },
      ),
    );
  }
}
