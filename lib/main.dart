import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Calculator {
  static double getMaxBenefit(int householdSize) {
    if (householdSize >= 8) {
      return (1164 + (householdSize - 8.0) * 146);
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
    if (monthlyIncome - totalDeductions > 0) {
      adjustedIncome = monthlyIncome - totalDeductions;
    }
    double calculatedBenefit = maxBenefit - (adjustedIncome) * .3;
    if (calculatedBenefit < 0) return 0;
    if (calculatedBenefit > maxBenefit)
      return maxBenefit;
    else
      return calculatedBenefit;
  }

  static double getStandardDeduction(int familySize) {
    if (familySize <= 3) return 167;
    if (familySize == 4) return 178;
    if (familySize == 5) return 209;
    if (familySize >= 6)
      return 240;
    else
      return 0;
  }

  static double getHomelessDeduction(bool homelessness) {
    if (homelessness) {
      return 152.06;
    } else {
      return 0;
    }
  }

  static double getAdjustsedMedicalDeduction(double medicalExpenses) {
    if (medicalExpenses > 35.0)
      return medicalExpenses;
    else
      return 0;
  }

  static double getStandardUtilityAllowanacesNewYork(
      String area, String level) {
    if (area == 'newYorkCity') {
      if (level == 'heatingAndCooling') {
        return 800;
      }
      if (level == 'utilities') {
        return 316;
      }
      if (level == 'telephone') {
        return 30;
      }
    }
    if (area == 'nassauAndSuffolk') {
      if (level == 'heatingAndCooling') {
        return 744;
      }
      if (level == 'utilities') {
        return 292;
      }
      if (level == 'telephone') {
        return 30;
      }
    }
    if (area == 'restOfState') {
      if (level == 'heatingAndCooling') {
        return 661;
      }
      if (level == 'utilities') {
        return 268;
      }
      if (level == 'telephone') {
        return 30;
      }
    }
    return 0;
  }

  static double getStandardUtilityAllowanacesNewYorkArea(String area) {
    if (area == 'New York City') {
      return 800.0 + 316 + 30;
    }
    if (area == 'Nassau & Suffolk Counties') {
      return 744.0 + 292 + 30;
    }
    if (area == 'Rest of State') {
      return 661.0 + 268 + 30;
    }
    return 0;
  }

  static double deductionNewYorkCalc(
      double monthlyChildSupport,
      double earnedIncome,
      int householdSize,
      double dependentCare,
      bool homelessness,
      double medicalExpenses) {
    return monthlyChildSupport +
        earnedIncome * .2 +
        getStandardDeduction(householdSize) +
        dependentCare +
        getHomelessDeduction(homelessness) +
        getAdjustsedMedicalDeduction(medicalExpenses);
  }

  static double getMonthlyGrossIncomeTestNY(
    int householdSize,
    double dependentCare,
    double earnedIncome,
  ) {
    //TODO: Put all the values in. Read the literature to know what it means/what bearing it has on the calculator.
    if (householdSize == 1) return 0;
    return 0;
  }

  static double getShelterExcessNewYork(
      double adjustedIncome,
      double rentOrMortgage,
      double standardUtilityAllowance,
      double otherShelterExpenses,
      bool disabledOrElderly) {
    double totalShelterExpenses =
        rentOrMortgage + standardUtilityAllowance + otherShelterExpenses;
    if (adjustedIncome / 2 - totalShelterExpenses > 569 && disabledOrElderly)
      return adjustedIncome / 2 - totalShelterExpenses;
    else if (adjustedIncome / 2 - totalShelterExpenses > 569 &&
        !disabledOrElderly)
      return 569;
    else if (adjustedIncome / 2 - totalShelterExpenses <= 0)
      return 0;
    else
      return adjustedIncome / 2 - totalShelterExpenses;
  }

  static double newYorkCalculation(double maxBenefit, double grossIncome,
      double totalDeductions, double shelterExcess) {
    return threeInputCalc(
        maxBenefit, grossIncome, totalDeductions + shelterExcess);
  }

  static double advancedDeductionCalculation(
      double unearnedIncome,
      double earnedIncome,
      double childSupport,
      int householdSize,
      double dependentCare,
      bool homelessnessStatus,
      double medicalExpenses,
      double rentOrMortgage,
      String location,
      double otherShelter,
      bool disabledOrElderly) {
    double grossIncome = unearnedIncome + earnedIncome;
    double adjustedGrossIncome = grossIncome - childSupport;
    double earnedIncomeDeduction = earnedIncome * .2;
    double standardDeduction = getStandardDeduction(householdSize);
    double dependentCareDeduction = dependentCare;
    double homelessDeduction = getHomelessDeduction(homelessnessStatus);
    double medicalDeduction = getAdjustsedMedicalDeduction(medicalExpenses);
    double totalDeduction = earnedIncomeDeduction +
        standardDeduction +
        dependentCareDeduction +
        homelessDeduction +
        medicalDeduction;
    double adjustedIncome = adjustedGrossIncome - totalDeduction;
    if (adjustedIncome <= 0) adjustedIncome = 0;
    double shelterExcess = getShelterExcessNewYork(
        adjustedGrossIncome,
        rentOrMortgage,
        getStandardUtilityAllowanacesNewYorkArea(location),
        otherShelter,
        disabledOrElderly);
    double netIncome = adjustedIncome - shelterExcess;
    return getMaxBenefit(householdSize) - netIncome * .3;
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
  int yourHouseholdSize;
  double yourMax;
  double monthlyIncome;
  double yourBenefit;
  double yourDeduction;
  double yourStandardDeduction;
  bool yourHomelessnessStatus;
  double yourChildSupport;
  double yourDependentCareCosts;
  double yourMedicalExpenses;
  double yourUnearnedIncome;
  double yourEarnedIncome;
  double yourRentOrMortgage;
  String yourArea;
  double yourStandardUtilityAllowance;
  double yourOtherShelterCosts;
  bool disabledOrElderly;
  double yourShelterExcess;
  double yourNetIncome;
  double yourNYBenefit;

  Model() {
    yourHouseholdSize = 0;
    yourMax = 0;
    monthlyIncome = 0;
    yourChildSupport = 0;
    yourBenefit = 0;
    yourDeduction = 0;
    yourStandardDeduction = 0;
    yourHomelessnessStatus = false;
    yourDependentCareCosts = 0;
    yourMedicalExpenses = 0;
    yourUnearnedIncome = 0;
    yourEarnedIncome = 0;
    yourRentOrMortgage = 0;
    yourArea = '';
    yourStandardUtilityAllowance = 0;
    yourOtherShelterCosts = 0;
    disabledOrElderly = false;
    yourShelterExcess = 0;
    yourNetIncome = 0;
    yourNYBenefit = 0;
  }
  updateBenefit() {
    yourBenefit =
        Calculator.threeInputCalc(yourMax, monthlyIncome, yourDeduction);
  }

  updateMax() {
    yourMax = Calculator.getMaxBenefit(yourHouseholdSize);
  }

  updateNYBenefit() {
    yourNYBenefit = Calculator.advancedDeductionCalculation(
        yourUnearnedIncome,
        yourEarnedIncome,
        yourChildSupport,
        yourHouseholdSize,
        yourDependentCareCosts,
        yourHomelessnessStatus,
        yourMedicalExpenses,
        yourRentOrMortgage,
        yourArea,
        yourOtherShelterCosts,
        disabledOrElderly);
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
  List<String> choices = [
    "Nassau & Suffolk Counties",
    "New York City",
    "Rest of State"
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

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
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              border: InputBorder.none,
                              hintText:
                                  'How many members live in your household? ',
                              labelText: 'Household size: '),
                          onChanged: (String householdSize) {
                            if (!(householdSize.contains('@') ||
                                householdSize.contains(new RegExp(r'[A-Z]')) ||
                                householdSize.contains(new RegExp(r'[a-z]')))) {
                              setState(() {
                                model.yourHouseholdSize =
                                    int.parse(householdSize);
                                model.updateMax();
                                model.updateNYBenefit();
                              });
                            }
                          },
                          validator: (String childSupport) {
                            return childSupport.contains('@') ||
                                    childSupport.contains('.') ||
                                    childSupport
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    childSupport.contains(new RegExp(r'[a-z]'))
                                ? 'Only use numbers.'
                                : null;
                          },
                          autovalidate: true,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              border: InputBorder.none,
                              hintText:
                                  'How much child support do you pay monthly? ',
                              labelText:
                                  'Monthly child support payment (optional) '),
                          onChanged: (String childSupport) {
                            if (!(childSupport.contains('@') ||
                                childSupport.contains(new RegExp(r'[A-Z]')) ||
                                childSupport.contains(new RegExp(r'[a-z]')))) {
                              setState(() {
                                model.yourChildSupport =
                                    double.parse(childSupport);
                                model.updateNYBenefit();
                              });
                            }
                          },
                          validator: (String childSupport) {
                            return childSupport.contains('@') ||
                                    childSupport.contains('.') ||
                                    childSupport
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    childSupport.contains(new RegExp(r'[a-z]'))
                                ? 'Only use numbers.'
                                : null;
                          },
                          autovalidate: true,
                        ),
                        new TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.attach_money),
                              border: InputBorder.none,
                              hintText:
                                  'How much of your monthly income is unearned? (income gained passively from savings, rent, benefits, etc.)',
                              labelText: 'Unearned monthly income '),
                          onChanged: (String inputtedIncome) {
                            if (!(inputtedIncome
                                    .contains(new RegExp(r'[A-Z]')) ||
                                inputtedIncome
                                    .contains(new RegExp(r'[a-z]')))) {
                              setState(() {
                                model.yourUnearnedIncome =
                                    (double.parse(inputtedIncome));
                                model.updateNYBenefit();
                              });
                            }
                          },
                          validator: (String inputtedIncome) {
                            return (inputtedIncome
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedIncome
                                        .contains(new RegExp(r'[a-z]')))
                                ? 'Only use numbers.'
                                : null;
                          },
                          autovalidate: true,
                        ),
                        new TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.attach_money),
                              border: InputBorder.none,
                              hintText:
                                  'How much of your monthly income is earned? (income from work, not gained passively from savings, rent, or benefits)',
                              labelText: 'Earned monthly income '),
                          onChanged: (String inputtedIncome) {
                            if (!(inputtedIncome
                                    .contains(new RegExp(r'[A-Z]')) ||
                                inputtedIncome
                                    .contains(new RegExp(r'[a-z]')))) {
                              setState(() {
                                model.yourEarnedIncome =
                                    (double.parse(inputtedIncome));
                                model.updateNYBenefit();
                              });
                            }
                          },
                          validator: (String inputtedIncome) {
                            return (inputtedIncome
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedIncome
                                        .contains(new RegExp(r'[a-z]')))
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
                                  'How much do you pay in dependent care costs monthly? (care for children under 18 or disabled household members of any age) ',
                              labelText: 'Dependent care costs '),
                          onChanged: (String inputtedCare) {
                            setState(() {
                              model.yourDependentCareCosts =
                                  double.parse(inputtedCare);
                              model.updateNYBenefit();
                            });
                          },
                          validator: (String inputtedCare) {
                            return (inputtedCare
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedCare.contains(new RegExp(r'[a-z]')))
                                ? 'Only use numbers.'
                                : null;
                          },
                          autovalidate: true,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Check if you are homeless"),
                            Checkbox(
                              value: model.yourHomelessnessStatus,
                              onChanged: (bool value) {
                                setState(() {
                                  model.yourHomelessnessStatus = value;
                                  model.updateNYBenefit();
                                });
                              },
                            ),
                          ],
                        ),
                        new TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.arrow_downward),
                              border: InputBorder.none,
                              hintText:
                                  'How much do you pay in medical expenses monthly? ',
                              labelText: 'Medical expenses '),
                          onChanged: (String inputtedMedical) {
                            setState(() {
                              model.yourMedicalExpenses =
                                  double.parse(inputtedMedical);
                              model.updateNYBenefit();
                            });
                          },
                          validator: (String inputtedMedical) {
                            return (inputtedMedical
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedMedical
                                        .contains(new RegExp(r'[a-z]')))
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
                                  'How much do you pay for rent/mortgage each month? ',
                              labelText: 'Rent/mortgage '),
                          onChanged: (String inputtedRent) {
                            setState(() {
                              model.yourRentOrMortgage =
                                  double.parse(inputtedRent);
                              model.updateNYBenefit();
                            });
                          },
                          validator: (String inputtedRent) {
                            return (inputtedRent
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedRent.contains(new RegExp(r'[a-z]')))
                                ? 'Only use numbers.'
                                : null;
                          },
                          autovalidate: true,
                        ),
                        Text(
                            'Where in the state do you live? (used to determine standard utility allowances'),
                        Column(
                          children: choices.map((item) {
                            //change index of choices array as you need
                            return RadioListTile(
                              groupValue: model.yourArea,
                              title: Text(item),
                              value: item,
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                print(val);
                                setState(() {
                                  model.yourArea = val;
                                  model.updateNYBenefit();
                                });
                              },
                            );
                          }).toList(),
                        ),
                        new TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.arrow_downward),
                              border: InputBorder.none,
                              hintText:
                                  'How much do you pay in other (non-utility/rent/mortgage) shelter costs? ',
                              labelText:
                                  'Other shelter expenses (non-utility/rent) '),
                          onChanged: (String inputtedShelter) {
                            setState(() {
                              model.yourOtherShelterCosts =
                                  double.parse(inputtedShelter);
                              model.updateBenefit();
                            });
                          },
                          validator: (String inputtedShelter) {
                            return (inputtedShelter
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedShelter
                                        .contains(new RegExp(r'[a-z]')))
                                ? 'Only use numbers.'
                                : null;
                          },
                          autovalidate: true,
                        ),
                        new Text(model.yourMax.toString()),
                        new Text(model.yourNYBenefit.toString()),
                      ]),
                ),
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
                      model.yourHouseholdSize = int.parse(numOfPeople);
                      model.updateMax();
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
