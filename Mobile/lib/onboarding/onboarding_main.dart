import 'package:flutter/material.dart';
import 'package:relax/my_theme.dart';

import 'package:relax/my_theme.dart';
import 'package:relax/onboarding/addinfo.dart';
import 'data.dart';
import 'dart:io';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<SliderModel> slides = <SliderModel>[];
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    slides = getSlides();
  }

  Widget pageIndexIndicatorDots(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      height: isCurrentPage ? 11.0 : 7.0,
      width: isCurrentPage ? 11.0 : 7.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? Colors.grey : Colors.grey[300],
          borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
          controller: pageController,
          itemCount: slides.length,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          itemBuilder: (context, index) {
            return SliderTile(
              imgpath: slides[index].getImagePath(),
              title: slides[index].getTitle(),
              description: slides[index].getDescription(),
            );
          }),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
              color: Colors.grey[100],
              height: Platform.isIOS ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      pageController.animateToPage(slides.length - 1,
                          duration: Duration(milliseconds: 450),
                          curve: Curves.easeInOut);
                    },
                    child: const Text(
                      "SKIP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < slides.length; i++)
                        currentIndex == i
                            ? pageIndexIndicatorDots(true)
                            : pageIndexIndicatorDots(false)
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      pageController.animateToPage(currentIndex + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.ease);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => AddInfo(showBackButton : true,title: "Add Profile Information",)));
              },
              child: Container(
                height: Platform.isIOS ? 70 : 60,
                color: MyTheme.accent_color,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Enter Information",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
    );
  }
}

class SliderTile extends StatelessWidget {
  String? imgpath, title, description;
  SliderTile({this.imgpath, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imgpath!),
          SizedBox(
            height: 60,
          ),
          Text(
            title!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(description!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          )
        ],
      ),
    );
  }
  
}
