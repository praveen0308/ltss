import 'package:flutter/material.dart';
import 'package:ltss/generated/assets.dart';

class SideMenu extends StatefulWidget {
  final Function(int index) onDashboardItemClick;

  const SideMenu({super.key, required this.onDashboardItemClick});

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
                children: [
                  ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.dashboard_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(0);
                    },
                  ),

                  ListTile(
                    title: Text("Fund Requests"),
                    leading: Icon(Icons.message),
                    onTap: () {
                      widget.onDashboardItemClick(1);
                    },
                  ),
                  ListTile(
                    title: Text("DMT"),
                    leading: Icon(Icons.list_alt_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(10);
                    },
                  ),
                  ListTile(
                    title: Text("Distributors"),
                    leading: Icon(Icons.account_tree_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(2);
                    },
                  ),
                  ListTile(
                    title: Text("Retailers"),
                    leading: Icon(Icons.photo_camera_front_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(3);
                    },
                  ),
                  ListTile(
                    title: Text("Vendors"),
                    leading: Icon(Icons.perm_contact_calendar_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(4);
                    },
                  ),
                  ListTile(
                    title: Text("Customers"),
                    leading: Icon(Icons.people),
                    onTap: () {
                      widget.onDashboardItemClick(5);
                    },
                  ),
                  ListTile(
                    title: Text("Wallet"),
                    leading: Icon(Icons.wallet_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(6);
                    },
                  ),
                  ListTile(
                    title: Text("Services"),
                    leading: Icon(Icons.miscellaneous_services_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(7);
                    },
                  ),
                  ListTile(
                    title: Text("Banks"),
                    leading: Icon(Icons.account_balance),
                    onTap: () {
                      widget.onDashboardItemClick(8);
                    },
                  ),
                  ListTile(
                    title: Text("Report"),
                    leading: Icon(Icons.list_alt_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(9);
                    },
                  ),
                  ListTile(
                    title: Text("Log Out"),
                    leading: Icon(Icons.logout_rounded),
                    onTap: () {
                      widget.onDashboardItemClick(10);
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
