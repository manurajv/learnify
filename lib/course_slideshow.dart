import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:learnify/course_model.dart';
import 'package:learnify/course_card.dart';

class CourseSlideshow extends StatelessWidget {
  // Dummy data for course cards. Replace this with your actual data.
  final List<Course> courses = [
    Course(title: 'Flutter Crash Course', instructor: 'John Doe', imageUrl: 'https://subzfresh.com/wp-content/uploads/2022/04/apple_158989157.jpg', rating: 6.8),
    Course(title: 'Dart Fundamentals', instructor: 'Jane Smith', imageUrl: 'https://subzfresh.com/wp-content/uploads/2022/04/apple_158989157.jpg', rating: 8.9),
    // Add more courses here
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Swiper(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: courses[index]);
        },
        pagination: SwiperPagination(), // Show dots at the bottom
        autoplay: true, // Auto-rotate slides
        autoplayDelay: 3000, // 3 seconds per slide
      ),
    );
  }
}
