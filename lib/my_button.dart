import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  //declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  const MyButton({super.key, this.textColor, required this.buttonText, this.buttontapped, this.color});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool pressing = false;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTapDown: (details) => setState(() => pressing = true),
      onTapUp: (value) => setState(() => pressing = false),
      onTapCancel: () => setState(() => pressing = false),
      onTap: widget.buttontapped,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: pressing ? Colors.grey[350] : Colors.grey[300],
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: pressing ? Colors.grey[800]! : Colors.grey[500]!,
              blurRadius: 4,
              offset: const Offset(2, 2),
              spreadRadius: 1,
            ),
             BoxShadow(
                color: pressing ? Colors.white60 : Colors.white,
                blurRadius: 4,
                offset: const Offset(-2, -2),
                spreadRadius: 1,
            )
          ],
        ),
        child: Center(child: Text(widget.buttonText, style: TextStyle(color: widget.textColor, fontWeight: FontWeight.bold, fontSize: 20),)),
      ),
    );
  }
}
