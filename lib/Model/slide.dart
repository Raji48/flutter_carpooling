import 'package:carpooling/Res/images.dart';
import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/runinglate.png',
    title: 'Running Late?',
    description: 'Register Now with Carpooling for a Safe and Comfortable ride',
  ),
  Slide(
    imageUrl: 'assets/images/ridewithus.png',
    title: 'Ride with Us!',
    description: 'We help you to connect with your Colleagues for a Comfortable ride to your Office',
  ),

];