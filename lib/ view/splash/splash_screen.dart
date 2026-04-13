import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:football_scoreboared/%20view/auth/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:new_loading_indicator/new_loading_indicator.dart';import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import 'auth_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goLogin();
  }

  Future<void> goLogin() async {
    await Future.delayed(Duration(seconds: 6));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  final List<String> images = [
    'assets/images/neymar.jpg',
    'assets/images/messi.png',
    'assets/images/ronaldo.jpg',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            items: images.map((images) {
              return Image.asset(
                images,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColor.black20, AppColor.black70],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 80),

                    Text('FSB', style: AppFontFamily.heading),

                    SizedBox(height: 15),

                    Text(
                      'FOOTBALL SCOREBOARD',
                      style: GoogleFonts.playpenSans(
                        fontSize: 19,
                        color: AppColor.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Loading....',
                      style: GoogleFonts.montserrat(
                        color: AppColor.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(
                      height: 110,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballClipRotatePulse,
                        colors: [AppColor.accentGreen, AppColor.white],
                      ),
                    ),

                    SizedBox(height: 60),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}