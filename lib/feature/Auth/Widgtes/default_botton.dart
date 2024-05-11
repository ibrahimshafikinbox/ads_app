import 'package:ads_app/feature/resources/styles/app_sized_box.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final double height;
  // final Color background;
  final VoidCallback function;
  final String text;
  final bool isUpperCase;
  final double radius;
  final Color textColor;
  final Color bottonColor;

  const DefaultButton({
    Key? key,
    this.height = 50,
    // this.background = Colors.blue,
    required this.function,
    required this.text,
    this.isUpperCase = false,
    this.radius = 10.0,
    required this.textColor,
    required this.bottonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: bottonColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: function,
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultButtonwithIcon extends StatelessWidget {
  final double height;
  // final Color background;
  final VoidCallback function;
  final String text;
  final bool isUpperCase;
  final double radius;
  final Color textColor;
  final Color bottonColor;
  final String image;

  const DefaultButtonwithIcon({
    Key? key,
    this.height = 50,
    // this.background = Colors.blue,
    required this.function,
    required this.text,
    this.isUpperCase = false,
    this.radius = 10.0,
    required this.textColor,
    required this.bottonColor,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: bottonColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: function,
            child: Row(
              children: [
                Image.asset(image),
                AppSizedBox.sizedW10,
                Text(
                  isUpperCase ? text.toUpperCase() : text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
