import 'package:flutter/material.dart';
import 'package:whats_app/common/theme/extention.dart';
import 'package:whats_app/view/widgets/messagebubbele.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final Color? avatarColor;

  const ChatScreen({
    super.key,
    required this.name,
    this.avatarColor,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  late AnimationController _sendButtonController;
  late Animation<double> _sendButtonAnimation;

  @override
  void initState() {
    super.initState();
    _sendButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _sendButtonAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _sendButtonController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _sendButtonController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text.trim());
        _messageController.clear();
      });
      
      // Animate send button
      _sendButtonController.forward().then((_) {
        _sendButtonController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.authAppbarTextColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            Hero(
              tag: 'avatar_${widget.name}',
              child: CircleAvatar(
                backgroundColor: widget.avatarColor,
                radius: 18,
                child: Text(
                  widget.name[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'online',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'view_contact', child: Text('View contact')),
              const PopupMenuItem(value: 'media', child: Text('Media, links, and docs')),
              const PopupMenuItem(value: 'search', child: Text('Search')),
              const PopupMenuItem(value: 'mute', child: Text('Mute notifications')),
              const PopupMenuItem(value: 'wallpaper', child: Text('Wallpaper')),
              const PopupMenuItem(value: 'more', child: Text('More')),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.theme.chatPageBgColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    message: _messages[index],
                    isMe: true,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.theme.chatTextFieldBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedBuilder(
                    animation: _sendButtonAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _sendButtonAnimation.value,
                        child: FloatingActionButton(
                          onPressed: _sendMessage,
                          mini: true,
                          backgroundColor: context.theme.circleImageColor,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}