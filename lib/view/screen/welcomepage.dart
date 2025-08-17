import 'package:flutter/material.dart';
import 'package:whats_app/common/theme/extention.dart';
import 'package:whats_app/common/utils/colors.dart';
import 'package:whats_app/view/screen/homepage.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                child: Image.asset(
                  'assets/images/circle.png',
                  color: context.theme.circleImageColor ?? Coloors.greenDark,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Welcome to WhatsApp',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: context.theme.greyColor,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Read our ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: context.theme.blueColor,
                          ),
                        ),
                        const TextSpan(
                          text: '. Tap "Agree and continue" to accept the ',
                        ),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: context.theme.blueColor,
                          ),
                        ),
                        const TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 42,
                  width: MediaQuery.of(context).size.width - 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.theme.circleImageColor ?? Coloors.greenDark,
                      foregroundColor: Colors.white,
                      splashFactory: NoSplash.splashFactory,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'AGREE AND CONTINUE',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}