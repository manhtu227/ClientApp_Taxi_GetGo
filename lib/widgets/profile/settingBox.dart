import 'package:flutter/material.dart';


class SettingBox extends StatelessWidget {
  const SettingBox({
    super.key,
    required this.title,
    required this.icon,
    required this.navigate,
  });
  final String title;
  final IconData icon;
  final String navigate;
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, navigate),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    // padding: const EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width - 40 * 2) * 0.2,
                    child: Icon(
                      icon,
                      size: 30,
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  width: (MediaQuery.of(context).size.width - 40 * 2) * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                width: (MediaQuery.of(context).size.width - 20 * 2) * 0.1,
                child: Icon(
                  Icons.arrow_forward_ios,
                  // color: themedata.primaryColor,
                ))
          ],
        ),
      ),
    );
  }
}
