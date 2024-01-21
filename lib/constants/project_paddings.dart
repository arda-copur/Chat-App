import 'package:flutter/material.dart';

final class ProjectPaddings extends EdgeInsets {
  
  // All Paddings

  /// [ProjectPaddings.allSmall] is 8
  const ProjectPaddings.allSmall() : super.all(8);

   /// [ProjectPaddings.allNormal] is 10
  const ProjectPaddings.allNormal() : super.all(10);

  /// [ProjectPaddings.allMedium] is 16
  const ProjectPaddings.allMedium() : super.all(16);

  /// [ProjectPaddings.allLarge] is 24
  const ProjectPaddings.allLarge() : super.all(24);

  /// [ProjectPaddings.allHigh] is 32
  const ProjectPaddings.allHigh() : super.all(32);

  // Symmetric Paddings
  
  /// [ProjectPaddings.symmetricSmall] is horizontal 10 vertical 10
  const ProjectPaddings.symmetricSmall() : super.symmetric(horizontal: 10,vertical: 10);
  
  /// [ProjectPaddings.symmetricMedium] is horizontal 20 vertical 20
  const ProjectPaddings.symmetricMedium() : super.symmetric(horizontal: 20,vertical: 20);


  //Only Paddings

  /// [ProjectPaddings.onlyLeft] is left 10
  const ProjectPaddings.onlyLeft() :  super.only(left: 10);

  /// [ProjectPaddings.onlyTop] is top 10
  const ProjectPaddings.onlyTop() :  super.only(top: 10);


  /// [ProjectPaddings.onlyLeftRight] is left 10 right 10
  const ProjectPaddings.onlyLeftRight() : super.only(left: 10,right: 10);


}
