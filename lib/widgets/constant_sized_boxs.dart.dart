import 'package:flutter/material.dart';

final class ConstantSizedBoxs {


 static SizedBox lowHeightSizedBox() => const SizedBox(height: 10);
 static SizedBox normalHeightSizedBox() => const SizedBox(height: 20);
 static SizedBox largeHeightSizedBox() => const SizedBox(height: 30);

 static SizedBox lowWidthSizedBox() => const SizedBox(width: 10);
 static SizedBox normalWidthSizedBox() => const SizedBox(width: 20);
 static SizedBox largeWidthSizedBox() => const SizedBox(width: 30);
}