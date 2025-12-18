import 'package:amazon_clone/features/account/widgets/account_screen_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Row(
          children: [
            AccountScreenButton(text: "Your Orders", onTap: () {}),
            AccountScreenButton(text: "Turn Seller", onTap: () {}),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            AccountScreenButton(text: "Logout", onTap: () {}),
            AccountScreenButton(text: "Your Wishlist", onTap: () {}),
          ],
        ),
      ],
    );
  }
}
