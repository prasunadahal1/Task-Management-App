import 'package:flutter/material.dart';
import 'package:task_app/colors/colors.dart';
import 'package:task_app/resources/main_screen.dart';
import 'package:task_app/resources/custom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:CustomColors.backgroundColor(context),
      body: Container(
        child: Column(
          // mainAxisAlignment:.center,
          // crossAxisAlignment: .center,
          spacing: 5,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.75,
              margin: EdgeInsets.only(left: 75, top: 140),
              child: Image.asset("assets/home2.png", fit: BoxFit.cover),
            ),
            Text(
              "Keep It All In\nOne Place",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CustomColors.blacktext(context),
                fontSize: 30,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: [
                  Center(child: _page1(context)),
                  Center(child: _page2(context)),
                  Center(child: _page3(context)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: currentPage == 0 ? 25 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF84C5A5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  width: currentPage == 1 ? 25 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF84C5A5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // width: currentPage==1?25:8,
                  // child: CircleAvatar(
                  //   radius: 4,
                  //   backgroundColor: Colors.grey.shade300,
                  // ),
                ),
                SizedBox(width: 6),
                Container(
                  width: currentPage == 2 ? 25 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF84C5A5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 90),
            Row(
              mainAxisAlignment: .center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return MainScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFF84C5A5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          'Get Start',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _page1(BuildContext context) {
    return Column(
      children: [
        Text(
          "Organize your tasks and boost \n your productivity every day.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: CustomColors.greytext(context),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _page2(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(color:CustomColors.backgroundColor(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "50+",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.greytext(context),
                    height: 1.6,
                  ),
                ),
                Text(
                  "Tasks",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.greytext(context),
                    height: 1.6,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "24/7",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.greytext(context),
                    height: 1.6,
                  ),
                ),
                Text(
                  "Access",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.greytext(context),
                    height: 1.6,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "100%",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.greytext(context),
                    height: 1.6,
                  ),
                ),
                Text(
                  "Free",
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.greytext(context),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _page3(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color:CustomColors.backgroundColor(context)),
      child: Column(
        children: [
          Icon(Icons.trending_up_rounded, size: 35, color: Color(0xFF84C5A5)),
          SizedBox(height: 3),
          Text(
            "Boost Productivity",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: CustomColors.greytext(context),
              
            ),
          ),
          SizedBox(height: 3),
          // Container(
          //   // padding: EdgeInsets.symmetric(
          //   //   horizontal:5,
          //   //   vertical:5,
          //   // ),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child:  Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(
          //         Icons.check_circle,
          //         color: Color(0xFFA8E6C1),
          //       ),
          //       SizedBox(width:5),
          //       Text(
          //         "Stay Focused",
          //         style: TextStyle(
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
