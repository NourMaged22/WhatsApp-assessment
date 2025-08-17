import 'package:flutter/material.dart';
import 'package:whats_app/common/theme/extention.dart';
import 'package:whats_app/view/screen/chatpage.dart';

class ChatTile extends StatefulWidget {
  final String name;
  final String message;
  final String time;
  final Color? avatarColor;
  final int unreadCount;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.avatarColor,
    this.unreadCount = 0,
  });

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.02, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    _openChat();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  void _openChat() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
          name: widget.name,
          avatarColor: widget.avatarColor,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: SlideTransition(
            position: _slideAnimation,
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              child: Container(
                color: Colors.transparent,
                child: ListTile(
                  leading: Hero(
                    tag: 'avatar_${widget.name}',
                    child: CircleAvatar(
                      backgroundColor: widget.avatarColor ?? context.theme.circleImageColor,
                      radius: 25,
                      child: Text(
                        widget.name[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  subtitle: Text(
                    widget.message,
                    style: TextStyle(
                      color: context.theme.greyColor,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.time,
                        style: TextStyle(
                          color: widget.unreadCount > 0 
                              ? context.theme.circleImageColor 
                              : context.theme.greyColor,
                          fontSize: 12,
                          fontWeight: widget.unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      if (widget.unreadCount > 0) ...[
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: context.theme.circleImageColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.unreadCount > 99 ? '99+' : widget.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}