// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:cantocraveadmin/admin/adminOrdersPage.dart';
import 'package:cantocraveadmin/admin/loginPage.dart';
import 'package:cantocraveadmin/routes/routes.dart';
import 'package:cantocraveadmin/widgettree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'admin/adminPage.dart';
import 'admin/adminSearchPage.dart';
import 'admin/editItemPage.dart';
import 'cart_list_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String _initialRoute = '';

  String initialRoute = '';

  var user = FirebaseAuth.instance.currentUser;

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartListProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routes: {
            MyRoutes.adminPageRoute: (context) => AdminPage(),
            MyRoutes.editItemPageRoute: (context) => EditItemPage(),
            MyRoutes.adminSearchPageRoute: (context) => AdminSearchPage(),
            MyRoutes.adminOrdersPageRoute: (context) => AdminOrdersPage(),
            MyRoutes.loginPageRoute: (context) => LoginPage()
          },
          home: const WidgetTree(),)
    );
  }
}
