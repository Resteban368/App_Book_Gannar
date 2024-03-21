import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/theme/app_theme.dart';

class Main extends StatelessWidget {
  const Main(
      {super.key,
      required this.currentIndex,
      required this.widget,
      required this.navigationShell});
  final int currentIndex;
  final Widget widget;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.primary,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 9,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 9,
        ),
        selectedItemColor: MyColors.white,
        unselectedItemColor: MyColors.grisMediano,
        useLegacyColorScheme: true,
        enableFeedback: true,
        showSelectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/favorites');

            case 2:
              context.go('/profile');
              break;
          }
        },
        items: [
          _buildBottomNavigationBarItem(
              index: 0,
              normalIcon: Icons.home,
              currentIndex: currentIndex,
              label: 'Inicio'),
          _buildBottomNavigationBarItem(
              index: 1,
              normalIcon: Icons.favorite,
              currentIndex: currentIndex,
              label: 'Favorritos'),
          _buildBottomNavigationBarItem(
              index: 2,
              normalIcon: Icons.person,
              currentIndex: currentIndex,
              label: 'Perfil'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required int index,
    required int currentIndex,
    required String label,
    required IconData normalIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          //linea arriba del icono
          Container(
            margin: const EdgeInsets.only(bottom: 2, top: 5),
            width: 30,
            height: 2,
            color: currentIndex == index ? MyColors.white : MyColors.primary,
          ),

          Icon(
            normalIcon,
            size: 25,
            color:
                currentIndex == index ? MyColors.white : MyColors.grisMediano,
          )
        ],
      ),
      label: label,
    );
  }
}
