import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/ui/home/providers/home_provider.dart';
import 'package:setec_app/ui/home/widgets/app_bar_widget.dart';
import 'package:setec_app/ui/home/widgets/bottom_nav_bar_widget.dart';
import 'package:setec_app/ui/home/widgets/floating_buttom_widget.dart';
import 'package:setec_app/ui/home/widgets/drawer_widget.dart';

class HomeNavDrawer extends ConsumerWidget {
  const HomeNavDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final views = ref.watch(viewsProvider);

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(parentContext: context),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentIndexProvider.notifier).state = index;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingButtomWidget(),
      body: views[currentIndex],
    );
  }
}
