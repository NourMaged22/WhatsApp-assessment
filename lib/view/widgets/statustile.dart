import 'package:flutter/material.dart';
import 'package:whats_app/common/theme/extention.dart';
import 'package:whats_app/view/screen/statuspage.dart';

class StoryTile extends StatefulWidget {
  final String name;
  final String time;
  final Color? avatarColor;
  final bool isViewed;

  const StoryTile({
    super.key,
    required this.name,
    required this.time,
    this.avatarColor,
    this.isViewed = false,
  });

  @override
  State<StoryTile> createState() => _StoryTileState();
}

class _StoryTileState extends State<StoryTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) {
      _controller.reverse();
      _openStory();
    });
  }

  void _openStory() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => StoryViewer(
          name: widget.name,
          avatarColor: widget.avatarColor,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.8,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.isViewed 
                      ? context.theme.greyColor! 
                      : context.theme.circleImageColor!,
                  width: 2.5,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: widget.avatarColor ?? context.theme.circleImageColor,
                radius: 23,
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
              widget.time,
              style: TextStyle(
                color: context.theme.greyColor,
                fontSize: 14,
              ),
            ),
            onTap: _onTap,
          ),
        );
      },
    );
  }
}