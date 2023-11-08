import 'package:flutter/material.dart';

enum UserAction {
  serviceDMT(id: 1, title: "DMT", icon: Icons.receipt_outlined),
  addCustomer(id: 2, title: "Add Customer", icon: Icons.person_add),
  searchUser(id: 3, title: "Search User", icon: Icons.person_search),
  transactions(id: 4, title: "Transactions", icon: Icons.library_books_rounded),
  requestFund(id: 5, title: "Request Fund", icon: Icons.call_made_rounded);

  final int id;
  final String title;
  final IconData icon;

  const UserAction({required this.id, required this.title, required this.icon});
}
