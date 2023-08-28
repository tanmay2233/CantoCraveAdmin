import 'package:cantocraveadmin/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Theme/themes.dart';
import '../routes/routes.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});
  final User? user = Auth().currentUser;

  // Future<void> signOut() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.signOut();
  //   await GoogleSignIn().signOut();
  // }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User Email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: Text("Sign Out"));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Admin Page",
            style: TextStyle(color: MyTheme.fontColor),
          ),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            MyTheme.canvasLightColor,
            MyTheme.canvasDarkColor
          ])))),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyTheme.canvasLightColor, MyTheme.canvasDarkColor])),
        child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: size.width * 0.5,
                    height: size.height * 0.05,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.adminOrdersPageRoute);
                        },
                        child: Text(
                          "Orders",
                          style: TextStyle(color: MyTheme.canvasDarkColor),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: MyTheme.cardColor))),
                Container(
                    width: size.width * 0.5,
                    height: size.height * 0.05,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.adminSearchPageRoute);
                        },
                        child: Text(
                          "Search an Item",
                          style: TextStyle(color: MyTheme.canvasDarkColor),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: MyTheme.cardColor))),
                Container(
                  width: size.width * 0.5,
                  height: size.height * 0.05,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, MyRoutes.editItemPageRoute);
                      },
                      child: Text(
                        "Edit Item(s)",
                        style: TextStyle(color: MyTheme.canvasDarkColor),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: MyTheme.cardColor)),
                ),
                Container(
                    width: size.width * 0.5,
                    height: size.height * 0.05,
                    child: ElevatedButton(
                        onPressed: () async {
                          await Auth().signOut();
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, MyRoutes.loginPageRoute);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: MyTheme.canvasDarkColor),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: MyTheme.fontColor)))
              ],
            )),
      ),
    );
  }
}
