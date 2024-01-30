import 'package:flutter/material.dart';

final class ProjectBorders extends BorderRadius {
  const ProjectBorders.onlyCircularLeftRight()
      : super.only(
            topLeft: const Radius.circular(30),
            topRight: const Radius.circular(30));

  const ProjectBorders.onlyCirculartopLeft()
      : super.only(topLeft: const Radius.circular(24));

  const ProjectBorders.onlyCirculartopRight()
      : super.only(topRight: const Radius.circular(24));
      
  ProjectBorders.circularSmall() : super.circular(10);
}
