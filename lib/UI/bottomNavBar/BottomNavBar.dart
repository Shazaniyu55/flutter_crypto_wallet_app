// ignore_for_file: file_names, use_super_parameters

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:benex/UI/pages/home/dashboard.dart';
import 'package:benex/UI/pages/settings/settings.dart';
import 'package:benex/constants/colors.dart';
import 'package:benex/constants/customIcons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/appController.dart';
import '../pages/swap/swap.dart';

class BottomNavigationBar1 extends StatefulWidget {
  const BottomNavigationBar1({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBar1> createState() => _BottomNavigationBar1State();
}

class _BottomNavigationBar1State extends State<BottomNavigationBar1> {
  final appController = Get.find<AppController>();
  List<TabItem> items = [
    const TabItem(
      icon: CustomIcons.home,
      title: 'Home',
    ),
    const TabItem(
      icon: CustomIcons.swap,
      title: 'Swap',
    ),
    const TabItem(
      icon: CustomIcons.settings,
      title: 'Settings',
    ),
  ];
  int visit = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF462D81);
  Color color = const Color(0XFF462D81);
  Color color2 = const Color(0XFF462D81);
  Color bgColor = lightColor;
  List pages = [const Dashboard(), Swap(), const Settings()];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomBarInspiredInside(
          fixed: true,
          fixedIndex: 1,
          items: items,
          backgroundColor: cardColor.value,
          color: labelColor.value,
          colorSelected: cardColor.value,
          indexSelected: visit,
          onTap: (int index) => setState(() {
            visit = index;
            setState(() {});
          }),
          chipStyle: ChipStyle(
              convexBridge: true,
              color: primaryColor.value,
              background: appController.isDark.value == true
                  ? dividerColor.value
                  : primaryColor.value),
          itemStyle: ItemStyle.circle,
          animated: false,
        ),
        body: pages.elementAt(visit),
      ),
    );
  }
}
