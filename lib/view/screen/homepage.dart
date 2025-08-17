import 'package:flutter/material.dart';
import 'package:whats_app/common/theme/extention.dart';
import 'package:whats_app/view/screen/chatpage.dart';
import 'package:whats_app/view/widgets/statustile.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fadeController;

  final List<Widget> _pages = [
    const ChatPage(),
    const StoriesPage(),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: context.theme.authAppbarTextColor,
        foregroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'new_group',
                child: Text('New group'),
              ),
              const PopupMenuItem(
                value: 'new_broadcast',
                child: Text('New broadcast'),
              ),
              const PopupMenuItem(
                value: 'linked_devices',
                child: Text('Linked devices'),
              ),
              const PopupMenuItem(
                value: 'starred_messages',
                child: Text('Starred messages'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
            ],
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: IndexedStack(
          key: ValueKey(_selectedIndex),
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.theme.profilePageBg,
        selectedItemColor: context.theme.authAppbarTextColor,
        unselectedItemColor: context.theme.greyColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Stories',
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ChatTile(
          name: 'Contact ${index + 1}',
          message: 'Last message from contact ${index + 1}',
          time: '${12 + (index % 12)}:${(index * 5) % 60}',
          avatarColor: index % 2 == 0 
              ? context.theme.circleImageColor 
              : context.theme.blueColor,
          unreadCount: index % 3 == 0 ? index + 1 : 0,
        );
      },
    );
  }
}

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



class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // My Story Section
          MyStoryTile(),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Recent updates',
              style: TextStyle(
                color: context.theme.greyColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),

          // Recent Story Updates
          ...List.generate(8, (index) {
            return StoryTile(
              name: 'Contact ${index + 1}',
              time: '${index + 1} ${index == 0 ? 'minute' : 'minutes'} ago',
              avatarColor: index % 2 == 0 
                  ? context.theme.circleImageColor 
                  : context.theme.blueColor,
              isViewed: index % 3 == 0,
            );
          }),
        ],
      ),
    );
  }
}

class MyStoryTile extends StatefulWidget {
  @override
  State<MyStoryTile> createState() => _MyStoryTileState();
}

class _MyStoryTileState extends State<MyStoryTile> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: context.theme.greyColor,
                  radius: 25,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.circleImageColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      title: const Text(
        'My story',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        'Tap to add story update',
        style: TextStyle(
          color: context.theme.greyColor,
          fontSize: 14,
        ),
      ),
      onTap: () {
        // Handle add story tap
      },
    );
  }
}




