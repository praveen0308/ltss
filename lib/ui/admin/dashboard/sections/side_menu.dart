import 'package:flutter/material.dart';
import 'package:ltss/generated/assets.dart';

class SideMenu extends StatefulWidget {
  final List<Widget> navItems;
  const SideMenu({super.key, required this.navItems});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(Assets.assetsIcLogo),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children:widget.navItems,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
