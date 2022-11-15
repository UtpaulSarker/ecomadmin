import 'package:ecomadmin/pages/add_product_page.dart';
import 'package:ecomadmin/pages/category_page.dart';
import 'package:ecomadmin/pages/dashboard_page.dart';
import 'package:ecomadmin/pages/launcher_page.dart';
import 'package:ecomadmin/pages/login_page.dart';
import 'package:ecomadmin/pages/order_page.dart';
import 'package:ecomadmin/pages/product_details_page.dart';
import 'package:ecomadmin/pages/product_repurchase_page.dart';
import 'package:ecomadmin/pages/report_page.dart';
import 'package:ecomadmin/pages/settings_page.dart';
import 'package:ecomadmin/pages/user_list_page.dart';
import 'package:ecomadmin/pages/view_product_page.dart';
import 'package:ecomadmin/providers/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ProductProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName:(_) => const LauncherPage(),
        LoginPage.routeName:(_) => const LoginPage(),
        DashboardPage.routeName:(_) => const DashboardPage(),
        AddProductPage.routeName:(_) => const AddProductPage(),
        ViewProductPage.routeName:(_) => const ViewProductPage(),
        ProductDetailsPage.routeName:(_) => const ProductDetailsPage(),
        CategoryPage.routeName:(_) => const CategoryPage(),
        OrderPage.routeName:(_) => const OrderPage(),
        ReportPage.routeName:(_) => const ReportPage(),
        SettingsPage.routeName:(_) => const SettingsPage(),
        ProductRepurchasePage.routeName:(_) => const ProductRepurchasePage(),
        UserListPage.routeName:(_) => const UserListPage(),
      },
    );
  }
}