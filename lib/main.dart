import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimpleCalculator(),
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  Widget buildButtonLeft(String buttonText) {
    return Container(
      child: SizedBox(
          height: 70,
          width: 70,
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder?>(
                  CircleBorder(),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            onPressed: () {
              buttonPressed(buttonText);
            },
          )),
    );
  }

  Widget buildButtonRight(String buttonText) {
    return Container(
      child: SizedBox(
          height: 70,
          width: 70,
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder?>(
                  CircleBorder(),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.amber)),
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            onPressed: () {
              buttonPressed(buttonText);
            },
          )),
    );
  }

  Widget resultPlace(String displayText) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: EdgeInsets.all(16),
      child: Text(
        displayText,
        style: TextStyle(fontSize: 32, color: Colors.white),
      ),
    );
  }

  String evalExpression(String expression) {
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel contextModel = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, contextModel);
    return result.toString();
  }

  String displayText = '';
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        displayText = '';
      } else if (buttonText == '=') {
        try {
          // Evaluate the expression in displayText and update the result
          displayText = evalExpression(displayText);
        } catch (e) {
          // Handle any errors during evaluation
          displayText = 'Error';
        }
      } else if (buttonText == '+/') {
        displayText = 'Not Function Yet';
      } else {
        displayText += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Center(child: Text('Calculator'))),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          resultPlace(displayText),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButtonLeft('C'),
                buildButtonLeft('+/'),
                buildButtonLeft('%'),
                buildButtonRight('/')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButtonLeft('7'),
                buildButtonLeft('8'),
                buildButtonLeft('9'),
                buildButtonRight('*')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButtonLeft('4'),
                buildButtonLeft('5'),
                buildButtonLeft('6'),
                buildButtonRight('-')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButtonLeft('1'),
                buildButtonLeft('2'),
                buildButtonLeft('3'),
                buildButtonRight('+')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: SizedBox(
                      height: 70,
                      width: 165,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder?>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey)),
                          child: Text(
                            '0',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          onPressed: () {
                            buttonPressed('0');
                          },
                        ),
                      )),
                ),
                buildButtonLeft('.'),
                buildButtonRight('=')
              ],
            ),
          )
        ]),
      ),
    );
  }
}
