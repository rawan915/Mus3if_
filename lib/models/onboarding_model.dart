class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({required this.image, required this.title, required this.description});

}
List <OnboardingModel> content=[
  OnboardingModel(
    image: 'assets/images/onboarding1.jpg', 
    title: 'Be Prepared, Be a Hero', 
    description: 'A simple action can save a life. Basic first aid knowledge is an essential skill for everyone.'),

  OnboardingModel(
    image: 'assets/images/onboarding2.jpg', 
    title: 'Be Prepared for Any Emergency', 
    description: 'Learn essential first aid skills to handle unexpected situations with confidence.'),

  OnboardingModel(
    image: 'assets/images/onboarding3.jpg', 
    title: 'Help in Emergencies', 
    description: 'Quickly access guides and instructions to assist in critical situations.')
];