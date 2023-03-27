// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  const CustomButton({
    Key? key,
    required this.ontap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            blurRadius: 5,
            spreadRadius: 0
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: ontap,
        child: Text(text,style: TextStyle(fontSize: 17),),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size.width, 50)
        ),
      ),
    );
  }
}
