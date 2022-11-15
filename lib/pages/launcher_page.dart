
import 'package:flutter/material.dart';

import '../auth/authservice.dart';
import 'dashboard_page.dart';
import 'login_page.dart';

class LauncherPage extends StatelessWidget {
  static const String routeName = '/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if(AuthService.currentUser!=null){
        Navigator.popAndPushNamed(context, DashboardPage.routeName);
      }else{
        Navigator.popAndPushNamed(context,LoginPage.routeName);
      }
    });
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
