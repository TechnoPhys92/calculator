import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color colour= Colors.white;
  var userInput = '';
  var answer = '';

  //Array of button
  final List<String> buttons =[
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '.',
    '0',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Padding(
        padding: const EdgeInsets.only(top: 64),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              indent: 8,
              endIndent: 8,
              thickness: 1,
              color: Colors.white,
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear button
                  if(index == 0){
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: MyButton(
                        buttontapped: (){
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        textColor: Colors.green[600],
                      ),
                    ) ;
                  }
                  // +/- button
                  else if(index == 1) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: MyButton(
                        buttonText: buttons[index],
                        textColor: Colors.blueAccent,
                      ),
                    );
                  }
                  // % Button
                  else if(index == 2) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: MyButton(
                        buttontapped: (){
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        textColor: Colors.blueAccent,
                      ),
                    );
                  }
                  //Delete button
                  else if(index == 3) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        textColor: Colors.red[600],
                      ),
                    );
                  }
                  // Equal_to Button
                  else if(index == 18){
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: MyButton(
                        buttontapped: (){
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        textColor: Colors.orange[600],
                      ),
                    );
                  }
                  //other buttons
                  else{
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: MyButton(
                        buttontapped: (){
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        textColor: isOperator(buttons[index])
                          ? Colors.blueAccent
                          : Colors.black,
                      ),
                    );
                  }
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if(x == '/' || x == 'x' || x =='-' || x =='+' || x =='='){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
