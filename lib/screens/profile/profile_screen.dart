import 'package:clientapp_taxi_getgo/providers/userViewModel.dart';
import 'package:clientapp_taxi_getgo/routes/routes.dart';
import 'package:clientapp_taxi_getgo/widgets/profile/settingBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserViewModel>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: Row(
            children: [
              // Image.asset("assets/images/profile.png"),
              const SizedBox(width: 10),
              const Text(
                "Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.user.avatar),
                  maxRadius: 50,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.mode_edit_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              user.user.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              user.user.phone,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: Colors.black54),
            const SettingBox(
                title: "Edit Profile",
                icon: Icons.account_circle_outlined,
                navigate: Routes.home),
            const SettingBox(
                title: "Address",
                icon: Icons.location_on_outlined,
                navigate: Routes.home),
            const SettingBox(
                title: "Notifications",
                icon: Icons.notifications_outlined,
                navigate: Routes.home),
            const SettingBox(
                title: "Payment",
                icon: Icons.account_balance_wallet_outlined,
                navigate: Routes.home),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(Routes.login),
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      // width: (MediaQuery.of(context).size.width - 20 * 2) * 0.2,
                      child: const Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30,
                      )),
                  Container(
                    // margin: const EdgeInsets.only(left: 5),
                    width: (MediaQuery.of(context).size.width - 20 * 2) * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
