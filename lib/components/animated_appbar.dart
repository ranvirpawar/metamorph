import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedTaskAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AnimatedTaskAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AnimatedTaskAppBar> createState() => _AnimatedTaskAppBarState();
}

class _AnimatedTaskAppBarState extends State<AnimatedTaskAppBar> with SingleTickerProviderStateMixin {
  final List<String> motivationalQuotes = [
    "Make it happen, Captain! 🚀",
    "The task you're looking for is here.",
    "Your destiny awaits. Write it down.",
    "One task at a time, hero.",
    "Create your own future, one step at a time.",
    "The adventure starts here.",
    "Don't dream it, do it.",
    "This is just the beginning.",
    "Every mission starts with a plan.",
    "It's your time to shine.",
    "Become the hero of your own story.",
    "Ninjas have missions. You have tasks.",
    "Embrace your journey, one task at a time.",
    "Prepare for battle, one task at a time.",
    "Chase your goals like a Hunter.",
    "Write your own destiny.",
    "Tasks? Just like training. We got this!",
    "Shinobi never give up, and neither should you.",
    "Your goal, your power.",
    "Master your tasks, master your future.",
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _animationController.reverse().then((_) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % motivationalQuotes.length;
        });
        _animationController.forward();
      });
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                motivationalQuotes[_currentIndex],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Create Task',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.refresh, color: Colors.white70),
      //     onPressed: () {
      //       _animationController.reverse().then((_) {
      //         setState(() {
      //           _currentIndex = (_currentIndex + 1) % motivationalQuotes.length;
      //         });
      //         _animationController.forward();
      //       });
      //     },
      //   ),
      // ],
    );
  }
}