import 'package:flutter/material.dart';

final class ProjectBorders extends BorderRadius  {
  const ProjectBorders.onlyCircularLeftRight() : super.only(topLeft: const Radius.circular(30),topRight: const Radius.circular(30));

   ProjectBorders.circularSmall() : super.circular(10);
}

