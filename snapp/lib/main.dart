import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Calculator {
  static double getMaxBenefit(double householdSize) {
    if (householdSize >= 8) {
      return (1164 + (householdSize - 8) * 146);
    } else if (householdSize == 7) {
      return 1018;
    } else if (householdSize == 6) {
      return 921;
    } else if (householdSize == 5) {
      return 768;
    } else if (householdSize == 4) {
      return 646;
    } else if (householdSize == 3) {
      return 509;
    } else if (householdSize == 2) {
      return 355;
    }
    return 194;
  }

  static double threeInputCalc(
      double maxBenefit, double monthlyIncome, double totalDeductions) {
    double adjustedIncome = 0;
    if (monthlyIncome > 0) {
      adjustedIncome = monthlyIncome;
    }
    double calculatedBenefit =
        maxBenefit - (adjustedIncome - totalDeductions) * .3;
    if (calculatedBenefit < 0) return 0;
    if (calculatedBenefit > maxBenefit)
      return maxBenefit;
    else
      return calculatedBenefit;
  }

  static double deductionNewYorkCalc() {
    return 1.0;
  }
}

class MyApp extends StatelessWidget {
  static const String _title = "SNAPP Calculator and Resources";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class Model {
  double yourMax;
  double monthlyIncome;
  double yourBenefit;
  double yourDeduction;
  Model() {
    yourMax = 0;
    monthlyIncome = 0;
    yourBenefit = 0;
    yourDeduction = 0;
  }
  updateBenefit() {
    yourBenefit =
        Calculator.threeInputCalc(yourMax, monthlyIncome, yourDeduction);
  }

//  double getYourMax() {
//    return yourMax;
//  }
//  double getYourBenefit() {
//    return yourBenefit;
//  }
//  double getMonthlyIncome() {
//    return monthlyIncome;
//  }
//  void setMonthlyIncome(double newIncome) {
//    monthlyIncome = newIncome;
//  }
//  void setYourBenefit(double newYourBenefit) {
//    yourBenefit = newYourBenefit;
//  }
//  void setYourMax(double newYourMax) {
//    yourMax = newYourMax;
//  }
}

class PopupLayout extends ModalRoute {
  //ToDo...
  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => false;
  @override
  String get barrierLabel => null;
  @override
  bool get maintainState => false;
  @override
  Color get barrierColor =>
      bgColor == null ? Colors.black.withOpacity(0.5) : bgColor;

  double top;
  double bottom;
  double left;
  double right;
  Color bgColor;
  final Widget child;

  PopupLayout(
      {Key key,
      this.bgColor,
      @required this.child,
      this.top,
      this.bottom,
      this.left,
      this.right});

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    if (top == null) this.top = 10;
    if (bottom == null) this.bottom = 20;
    if (left == null) this.left = 20;
    if (right == null) this.right = 20;

    return GestureDetector(
      child: Material(
        // This makes sure that text and other content follows the material style
        type: MaterialType.transparency,
        //type: MaterialType.canvas,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          bottom: true,
          child: _buildOverlayContent(context),
        ),
      ),
    );
  }

  //the dynamic content pass by parameter
  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: this.bottom,
          left: this.left,
          right: this.right,
          top: this.top),
      child: child,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class PopupContent extends StatefulWidget {
  final Widget content;
  PopupContent({
    Key key,
    this.content,
  }) : super(key: key);
  _PopupContentState createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.content,
    );
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static Model model = new Model();
  String yourMaximumTextHolder =
      'Your household\'s maximum benefit would be: ' + model.yourMax.toString();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
//  static List<Widget> _widgetOptions = [
//       Container(
//         padding: EdgeInsets.all(10.0),
//         child: Column(
//           children: <Widget>[
//           TextFormField(
//             decoration: InputDecoration(
//                 icon: Icon(Icons.person),
//                 border: InputBorder.none,
//                 hintText: 'What is your household size?',
//                 labelText: 'Number of dependents (not necessarily family)'
//             ),
//             onSaved: (String numOfPeople) {
//               model.yourMax = Calculator.getMaxBenefit(double.parse(numOfPeople));
//             },
//             validator: (String numOfPeople) {
//               return numOfPeople.contains('@') || numOfPeople.contains('.') || numOfPeople.contains(new RegExp(r'[A-Z]')) || numOfPeople.contains(new RegExp(r'[a-z]')) ? 'Only use whole numbers.' : null;
//             },
//             autovalidate: true,
//
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//                 icon: Icon(Icons.attach_money),
//                 border: InputBorder.none,
//                 hintText: 'What is your monthly income?',
//                 labelText: 'Monthly income '
//             ),
//             onSaved: (String inputtedIncome) {
//               model.monthlyIncome = (double.parse(inputtedIncome));
//             },
//             validator: (String inputtedIncome) {
//               return (inputtedIncome.contains(new RegExp(r'[A-Z]')) || inputtedIncome.contains(new RegExp(r'[a-z]'))) ? 'Only use numbers.' : null;
//             },
//             autovalidate: true,
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//                 icon: Icon(Icons.arrow_downward),
//                 border: InputBorder.none,
//                 hintText: 'What is your total deduction? Use the advanced tool if you\'re not sure. ',
//                 labelText: 'Total deduction (tool in advanced) '
//             ),
//             onSaved: (String inputtedDeduction) {
//               model.yourBenefit = (Calculator.threeInputCalc(model.yourMax, model.monthlyIncome, double.parse(inputtedDeduction)));
//               setState()
//             },
//             validator: (String inputtedDeduction) {
//               return (inputtedDeduction.contains(new RegExp(r'[A-Z]')) || inputtedDeduction.contains(new RegExp(r'[a-z]'))) ? 'Only use numbers.' : null;
//             },
//             autovalidate: true,
//           ),
//            Text('Your benefit is: ' + model.yourBenefit.toString()),
//            Text('Your household\'s maximum benefit would be: ' + model.yourMax.toString()),
//            ]
//          ),
//        ),
////
//
//       Container(
//          padding: EdgeInsets.all(10.0),
//          child: Column(
//              children: <Widget>[
//                Text('This is map stuff.'),
//               ]
//           )
//      ),
//      Container(
//          padding: EdgeInsets.all(10.0),
//          child: Column(
//              children: <Widget>[
//                Text('this is resources stuff'),
//              ]
//          )
//      ),
//
//      Container(
//          padding: EdgeInsets.all(10.0),
//          child: Column(
//            children: <Widget>[
//              Text('this is updates stuff'),
//            ]
//          )
//      ),
//];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  showPopup(BuildContext context, {BuildContext popupContext}) {
    Navigator.push(
        context,
        PopupLayout(
          top: 30,
          left: 30,
          right: 30,
          bottom: 50,
          child: PopupContent(
            //this is all the stuff going in the advanced ny deduction section in the popup. right now i've just copy pasted the same questions and stuff, i will change that later to reflect the actual deduction related thigns
            content: Scaffold(
              appBar: AppBar(
                title: Text('Deduction Guide (NY Specific)'),
                leading: new Builder(builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      try {
                        Navigator.pop(context); //close the popup
                      } catch (e) {}
                    },
                  );
                }),
                brightness: Brightness.light,
              ),
              resizeToAvoidBottomPadding: false,
              body: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            border: InputBorder.none,
                            hintText:
                                'How much child support do you pay monthly? ',
                            labelText:
                                'Monthly child support payment (optional) '),
                        onChanged: (String numOfPeople) {
                          if (!(numOfPeople.contains('@') ||
                              numOfPeople.contains(new RegExp(r'[A-Z]')) ||
                              numOfPeople.contains(new RegExp(r'[a-z]')))) {
                            setState(() {
                              model.yourMax = Calculator.getMaxBenefit(
                                  double.parse(numOfPeople));
                              model.updateBenefit();
                            });
                          }
                        },
                        validator: (String numOfPeople) {
                          return numOfPeople.contains('@') ||
                                  numOfPeople.contains('.') ||
                                  numOfPeople.contains(new RegExp(r'[A-Z]')) ||
                                  numOfPeople.contains(new RegExp(r'[a-z]'))
                              ? 'Only use whole numbers.'
                              : null;
                        },
                        autovalidate: true,
                      ),
                      new TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.attach_money),
                            border: InputBorder.none,
                            hintText: 'What is your monthly income?',
                            labelText: 'Monthly income '),
                        onChanged: (String inputtedIncome) {
                          if (!(inputtedIncome.contains(new RegExp(r'[A-Z]')) ||
                              inputtedIncome.contains(new RegExp(r'[a-z]')))) {
                            setState(() {
                              model.monthlyIncome =
                                  (double.parse(inputtedIncome));
                              model.updateBenefit();
                            });
                          }
                        },
                        validator: (String inputtedIncome) {
                          return (inputtedIncome
                                      .contains(new RegExp(r'[A-Z]')) ||
                                  inputtedIncome.contains(new RegExp(r'[a-z]')))
                              ? 'Only use numbers.'
                              : null;
                        },
                        autovalidate: true,
                      ),
                      new TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.arrow_downward),
                            border: InputBorder.none,
                            hintText:
                                'What is your total deduction? Use the advanced tool if you\'re not sure. ',
                            labelText: 'Total deduction (tool in advanced) '),
                        onChanged: (String inputtedDeduction) {
                          setState(() {
                            model.yourDeduction =
                                double.parse(inputtedDeduction);
                            model.updateBenefit();
                          });
                        },
                        validator: (String inputtedDeduction) {
                          return (inputtedDeduction
                                      .contains(new RegExp(r'[A-Z]')) ||
                                  inputtedDeduction
                                      .contains(new RegExp(r'[a-z]')))
                              ? 'Only use numbers.'
                              : null;
                        },
                        autovalidate: true,
                      ),
                      new Text(model.yourMax.toString()),
                      new Text(model.yourBenefit.toString()),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            onPressed: () {
                              showPopup(context);
                            },
                            child: Icon(Icons.add),
                            backgroundColor: Colors.blue,
                          ))
                    ]),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: InputBorder.none,
                    hintText: 'What is your household size?',
                    labelText: 'Number of dependents (not necessarily family)'),
                onChanged: (String numOfPeople) {
                  if (!(numOfPeople.contains('@') ||
                      numOfPeople.contains('.') ||
                      numOfPeople.contains(new RegExp(r'[A-Z]')) ||
                      numOfPeople.contains(new RegExp(r'[a-z]')))) {
                    setState(() {
                      model.yourMax =
                          Calculator.getMaxBenefit(double.parse(numOfPeople));
                      model.updateBenefit();
                    });
                  }
                },
                validator: (String numOfPeople) {
                  return numOfPeople.contains('@') ||
                          numOfPeople.contains('.') ||
                          numOfPeople.contains(new RegExp(r'[A-Z]')) ||
                          numOfPeople.contains(new RegExp(r'[a-z]'))
                      ? 'Only use whole numbers.'
                      : null;
                },
                autovalidate: true,
              ),
              new TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    border: InputBorder.none,
                    hintText: 'What is your monthly income?',
                    labelText: 'Monthly income '),
                onChanged: (String inputtedIncome) {
                  if (!(inputtedIncome.contains(new RegExp(r'[A-Z]')) ||
                      inputtedIncome.contains(new RegExp(r'[a-z]')))) {
                    setState(() {
                      model.monthlyIncome = (double.parse(inputtedIncome));
                      model.updateBenefit();
                    });
                  }
                },
                validator: (String inputtedIncome) {
                  return (inputtedIncome.contains(new RegExp(r'[A-Z]')) ||
                          inputtedIncome.contains(new RegExp(r'[a-z]')))
                      ? 'Only use numbers.'
                      : null;
                },
                autovalidate: true,
              ),
              new TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.arrow_downward),
                    border: InputBorder.none,
                    hintText:
                        'What is your total deduction? Use the advanced tool if you\'re not sure. ',
                    labelText: 'Total deduction (tool in advanced) '),
                onChanged: (String inputtedDeduction) {
                  setState(() {
                    model.yourDeduction = double.parse(inputtedDeduction);
                    model.updateBenefit();
                  });
                },
                validator: (String inputtedDeduction) {
                  return (inputtedDeduction.contains(new RegExp(r'[A-Z]')) ||
                          inputtedDeduction.contains(new RegExp(r'[a-z]')))
                      ? 'Only use numbers.'
                      : null;
                },
                autovalidate: true,
              ),
              new Text(model.yourMax.toString()),
              new Text(model.yourBenefit.toString()),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      showPopup(context);
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.blue,
                  ))
            ]),
      ),
//

      Container(
          padding: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Text('This is map stuff.'),
          ])),
      Container(
          padding: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Text('this is resources stuff'),
          ])),

      Container(
          padding: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Text('this is updates stuff'),
          ])),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text('SnAP Calculator'),
          centerTitle: true,
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              title: Text('SNAPMAP'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text('Resources'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye),
              title: Text('Updates'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
