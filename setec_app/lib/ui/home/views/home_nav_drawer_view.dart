import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/ui/home/widgets/app_bar_widget.dart';
import 'package:setec_app/ui/home/widgets/bottom_nav_bar_widget.dart';
import 'package:setec_app/ui/home/widgets/drawer_widget.dart';
import 'package:setec_app/ui/home/widgets/floating_buttom_widget.dart';

class HomeNavDrawer extends ConsumerWidget {
  const HomeNavDrawer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: DrawerWidget(parentContext: context),
      bottomNavigationBar: BottomNavBarWidget(
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: const FloatingButtomWidget(),
      body: child, // Usa o child do RouterOutlet
    );
  }
}
