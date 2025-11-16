import 'package:flutter/material.dart';
import 'package:mus3if/screens/login_screen.dart';
import '../models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1,),
              SizedBox(
                height: screenHeight * 0.65,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: content.length,
                  onPageChanged: (int index){
                    setState(() {
                      currentIndex= index;
                    });
                  },
                  itemBuilder: (_,i){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        children: [
                          Image.asset(content[i].image,
                          height: screenHeight * 0.40,),
                          SizedBox(height: 30,),
                          Text(content[i].title,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          ),
                          SizedBox(height: 15),
                          Text(content[i].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                          ),
                        ],
                      ),
                      );
                  },
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller!,
                  count: content.length,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 4,
                    spacing: 8,
                    radius: 16,
                    dotWidth: 8,
                    dotHeight: 8,
                    dotColor: Colors.grey.shade500,
                    activeDotColor: Colors.red,
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.03,),
                Padding(
                  padding:  EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: (){
                      if (currentIndex == content.length - 1){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      } else{
                      _controller!.nextPage(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                      }
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding:  EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), 
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentIndex == content.length - 1 ? "Continue" : "Next",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(Icons.arrow_forward),
                      ],
                    ),
                      ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }, 
                  child: Text('Skip',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]
                  ),)
                  ),
                  SizedBox(height: screenHeight * 0.03,),
          
            ],
          ),
        ),
      ),
    );
  }
}