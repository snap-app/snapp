import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class Calculator {
  int yourHouseholdSize;
  double yourMax;
  double monthlyIncome;
  double yourBenefit;
  double yourDeduction;
  double yourStandardDeduction;
  bool yourHomelessnessStatus;
  double yourChildSupport;
  double yourDependentCareCosts;
  int yourDependentAge;
  double yourMedicalExpenses;
  double yourUnearnedIncome;
  double yourEarnedIncome;
  double yourRentOrMortgage;
  String yourArea;
  double yourAdjustedIncome;
  double yourStandardUtilityAllowance;
  int yourStandardUtilityAllowanceLevel;
  double yourOtherShelterCosts;
  bool disabledOrElderly;
  double yourShelterExcess;
  double yourNetIncome;
  double yourNYBenefit;

  Calculator() {
    yourHouseholdSize = 0;
    yourMax = 0;
    monthlyIncome = 0;
    yourChildSupport = 0;
    yourBenefit = 0;
    yourDeduction = 0;
    yourStandardDeduction = 0;
    yourHomelessnessStatus = false;
    yourDependentCareCosts = 0;
    yourDependentAge = 18;
    yourMedicalExpenses = 0;
    yourUnearnedIncome = 0;
    yourEarnedIncome = 0;
    yourRentOrMortgage = 0;
    yourArea = '';
    yourAdjustedIncome = 0;
    yourStandardUtilityAllowance = 0;
    yourStandardUtilityAllowanceLevel = 3;
    yourOtherShelterCosts = 0;
    disabledOrElderly = false;
    yourShelterExcess = 0;
    yourNetIncome = 0;
    yourNYBenefit = 0;
  }

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
    } else if (householdSize == 1) {
      return 194;
    } else
      return 0;
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

  static double getAdjustedMedicalDeduction(double medicalExpenses) {
    if (medicalExpenses > 35.0)
      return medicalExpenses;
    else
      return 0;
  }

  static double getStandardUtilityAllowanacesNewYork(String area, int level) {
    if (area == 'newYorkCity') {
      if (level == 1) {
        return 800;
      }
      if (level == 2) {
        return 316;
      }
      if (level == 3) {
        return 30;
      }
    }
    if (area == 'nassauAndSuffolk') {
      if (level == 1) {
        return 744;
      }
      if (level == 2) {
        return 292;
      }
      if (level == 3) {
        return 30;
      }
    }
    if (area == 'restOfState') {
      if (level == 1) {
        return 661;
      }
      if (level == 2) {
        return 268;
      }
      if (level == 3) {
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
        getAdjustedMedicalDeduction(medicalExpenses);
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
    if (totalShelterExpenses - adjustedIncome / 2 > 569 && disabledOrElderly)
      return totalShelterExpenses - adjustedIncome / 2;
    else if (totalShelterExpenses - adjustedIncome / 2 > 569 &&
        !disabledOrElderly)
      return 569;
    else if ((totalShelterExpenses - adjustedIncome / 2) <= 0)
      return 0;
    else
      return totalShelterExpenses - adjustedIncome / 2;
  }

  static double newYorkCalculation(double maxBenefit, double grossIncome,
      double totalDeductions, double shelterExcess) {
    return threeInputCalc(
        maxBenefit, grossIncome, totalDeductions + shelterExcess);
  }

  static List<double> advancedDeductionCalculation(
      double unearnedIncome,
      double earnedIncome,
      double childSupport,
      int householdSize,
      double dependentCare,
      int dependentAge,
      bool homelessnessStatus,
      double medicalExpenses,
      double rentOrMortgage,
      String location,
      int utilityAllowanceLevel,
      double otherShelter,
      bool disabledOrElderly) {
    double grossIncome = unearnedIncome + earnedIncome;
    double adjustedGrossIncome = grossIncome - childSupport;
    double earnedIncomeDeduction = earnedIncome * .2;
    double standardDeduction = getStandardDeduction(householdSize);
    double dependentCareDeduction = dependentCare;
    if (dependentAge < 2 && dependentCareDeduction > 200)
      dependentCareDeduction = 200;
    if (dependentAge >= 2 && dependentCareDeduction > 175)
      dependentCareDeduction = 175;
    double homelessDeduction = getHomelessDeduction(homelessnessStatus);
    double medicalDeduction = getAdjustedMedicalDeduction(medicalExpenses);
    double totalDeduction = earnedIncomeDeduction +
        standardDeduction +
        dependentCareDeduction +
        homelessDeduction +
        medicalDeduction;
    double adjustedIncome = adjustedGrossIncome - totalDeduction;
    if (adjustedIncome <= 0) adjustedIncome = 0;
    double shelterExcess = getShelterExcessNewYork(
        adjustedIncome,
        rentOrMortgage,
        getStandardUtilityAllowanacesNewYork(location, utilityAllowanceLevel),
        otherShelter,
        disabledOrElderly);
    double netIncome = adjustedIncome - shelterExcess;
    double standardUtilityAllowance =
        getStandardUtilityAllowanacesNewYork(location, utilityAllowanceLevel);
    double absoluteBenefit = getMaxBenefit(householdSize) - netIncome * .3;
    if (absoluteBenefit <= 0) {
      return [
        0,
        adjustedIncome,
        standardDeduction,
        netIncome,
        shelterExcess,
        standardUtilityAllowance
      ];
    } else if (absoluteBenefit >= getMaxBenefit(householdSize)) {
      return [
        getMaxBenefit(householdSize),
        adjustedIncome,
        standardDeduction,
        netIncome,
        shelterExcess,
        standardUtilityAllowance
      ];
    } else
      return [
        absoluteBenefit,
        adjustedIncome,
        standardDeduction,
        netIncome,
        shelterExcess,
        standardUtilityAllowance
      ];
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
  Calculator calculator;
  int yourHouseholdSize;
  double yourMax;
  double monthlyIncome;
  double yourBenefit;
  double yourDeduction;
  double yourStandardDeduction;
  bool yourHomelessnessStatus;
  double yourChildSupport;
  double yourDependentCareCosts;
  int yourDependentAge;
  double yourMedicalExpenses;
  double yourUnearnedIncome;
  double yourEarnedIncome;
  double yourRentOrMortgage;
  String yourArea;
  double yourAdjustedIncome;
  double yourStandardUtilityAllowance;
  int yourStandardUtilityAllowanceLevel;
  double yourOtherShelterCosts;
  bool disabledOrElderly;
  double yourShelterExcess;
  double yourNetIncome;
  double yourNYBenefit;

  Model() {
    this.calculator = calculator;
    yourHouseholdSize = 0;
    yourMax = 0;
    monthlyIncome = 0;
    yourChildSupport = 0;
    yourBenefit = 0;
    yourDeduction = 0;
    yourStandardDeduction = 0;
    yourHomelessnessStatus = false;
    yourDependentCareCosts = 0;
    yourDependentAge = 18;
    yourMedicalExpenses = 0;
    yourUnearnedIncome = 0;
    yourEarnedIncome = 0;
    yourRentOrMortgage = 0;
    yourArea = '';
    yourAdjustedIncome = 0;
    yourStandardUtilityAllowance = 0;
    yourStandardUtilityAllowanceLevel = 3;
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
    List<double> yourNYData = Calculator.advancedDeductionCalculation(
        yourUnearnedIncome,
        yourEarnedIncome,
        yourChildSupport,
        yourHouseholdSize,
        yourDependentCareCosts,
        yourDependentAge,
        yourHomelessnessStatus,
        yourMedicalExpenses,
        yourRentOrMortgage,
        yourArea,
        yourStandardUtilityAllowanceLevel,
        yourOtherShelterCosts,
        disabledOrElderly);
    yourNYBenefit = yourNYData[0];
    yourAdjustedIncome = yourNYData[1];
    yourStandardDeduction = yourNYData[2];
    yourNetIncome = yourNYData[3];
    yourShelterExcess = yourNYData[4];
    yourStandardUtilityAllowance = yourNYData[5];
  }
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

  List<String> choices2 = [
    "I have heating and cooling costs. (Doesn't matter if they are partially or fully covered by HEAP)",
    "I have utility costs.",
    "I have neither."
  ];

  List<String> choices3 = [
    "My dependent is over 2 years of age.",
    "My dependent is under 2 years of age."
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Simplified Calculation:'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "First, your maximum possible benefit is calculated based on your household size.\n"),
          Text(
              "Then, you are expected to pay 30% of your adjusted income (after deductions provided for necessary expenses and other conditions). That value is subtracted from your household maximum.\n"),
          Text(
              "Equation: Household Maximum - (income - deductions) x .3 \n\nFor the calculation citations and more, look in the resource tab.")
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildAboutAdvanced(BuildContext context) {
    model.updateNYBenefit();
    return new AlertDialog(
      title: const Text('NY Full Calculation:'),
      content: new SingleChildScrollView(
        child: //StatefulBuilder(builder: (context, setState) {
            Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Your maximum is: " + model.yourMax.toString()),
            new Text(
                "Your estimated benefit is: " + model.yourNYBenefit.toString()),
            Text("\n \nFirst, your maximum possible benefit (\$" +
                model.yourMax.toString() +
                ") is calculated based on your household size.\n"),
            Text(
                "Then, you are expected to pay 30% of your adjusted income (after deductions provided for necessary expenses and other conditions). That value is subtracted from your household maximum.\n"),
            Text(
                "The deduction is calculated from a variety of factors, in this process:\n"),
            Text("1. Child support expenses (\$" +
                model.yourChildSupport.toString() +
                ") are deducted from your gross income."),
            Text("2. 20% of earned income (\$" +
                (model.yourEarnedIncome * .2).toString() +
                ") is further deducted."),
            Text("3. A standard deduction based on your household size (\$" +
                model.yourStandardDeduction.toString() +
                ") is again deducted."),
            Text("4. All dependent care costs (\$" +
                model.yourDependentCareCosts.toString() +
                "), or expenses for children under 18 years or disabled household members of any age, are deducted. The limit of this deduction is 200 for dependents under 2 years of age, and 175 for dependents above 2 years of age."),
            Text("5. If you are homeless, a deduction of \$152.06 is applied."),
            Text(
                "6. Your medical expenses over \$35 a month for household members over 60 or disabled household members (\$" +
                    model.yourMedicalExpenses.toString() +
                    ") are deducted."),
            Text("7. The deductions up to this point deducted from your gross income constitute your adjusted income (\$" +
                model.yourAdjustedIncome.toString() +
                "). A shelter excess deduction may be applied. Its size and eligibility are determined as follows:"), //TODO: Shelter excess may be calculated incorrectly. Everything else seems to work backend wise. The maximum benefit indicator does not work right now. Perhaps do away with it entirely and use the show calculation and benefit button (I think this is a very good option).
            Text("7a. Add up your rent/mortgage costs (\$" +
                model.yourRentOrMortgage.toString() +
                "), your standard utility  allowance (\$" +
                model.yourStandardUtilityAllowance.toString() +
                "), determined by your location within NY, and your other shelter expenses (\$" +
                model.yourOtherShelterCosts.toString() +
                ")"), //TODO: Add the resource section and test some other margin cases. Add the disclaimer. Add some updates section ( you should talk to haoye about this one). Finally, maybe add some other states.
            Text("7b. Take your total shelter expenses (\$" +
                (model.yourOtherShelterCosts +
                        model.yourRentOrMortgage +
                        model.yourStandardUtilityAllowance)
                    .toString() +
                ") and then subtract half your adjusted income."),
            Text(
                "7c. If this amount is greater to or equal than \$569, your shelter excess deduction is \$569. If you have elderly (age 60 and over) or disabled household members, your deduction is the full amount instead of \$569. If the amount is negative, your deduction for this section is \$0."),
            Text("8. Subtract the shelter excess calculated in step 7 (\$" +
                model.yourShelterExcess.toString() +
                ") from your adjusted income calculated."),
            Text("9. That leaves you with your net income (\$" +
                model.yourNetIncome.toString() +
                "). You are expected to put 30% of this figure towards food, which is subtracted from your maximum possible benefit of \$" +
                model.yourMax.toString() +
                ". That leaves a final estimated monthly benefit of \$" +
                model.yourNYBenefit.toString() +
                "."),
            Text(
                "\nFor the calculation and deductions citations, and more, look in the resource tab.")
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  showDisclaimer(BuildContext context, {BuildContext popupContext}) {
    Navigator.push(
        context,
        PopupLayout(
            top: 30,
            left: 30,
            right: 30,
            bottom: 50,
            child: StatefulBuilder(builder: (context, setState) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Calculator Disclaimer'),
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
                  resizeToAvoidBottomPadding: true,
                  body: Container(
                      padding: EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                            new Text(
                                "The SNAPP Benefits Calculator should be used for screening purposes only. \n\nThe laws, regulations, rules and policies the calculator is based on are subject to change. \n\nWe make no representations or warranties, express or implied, as to the accuracy of the projected results. \n\nWe are not liable for any decision made or action taken by anyone in reliance upon the information obtained from this calculator. \n\nThe calculator is not endorsed by the public entities that administer the SNAP program and individuals who want to apply for SNAP benefits should submit an application to the government agency where official determinations are made. \n\nIf you are unsure about eligibility, don't hesitate to receive an official determination. There are many deductions and ways to calculate them, and you may be eligible for other benefits."),
                            new Text(
                                "There are also other disqualifying factors like immigration status, the gross monthly income test, SNAP limits for unemployed, childless adults, and asset thresholds that aren't otherwise used to calculate your benefit, so those factors are also not taken into account by this calculator. Only a caseworker can decide eligibility and give you the exact benefit amount.")
                          ]))));
            })));
    setState(() {});
  }

  showInfo(BuildContext context, {BuildContext popupContext}) {
    Navigator.push(
        context,
        PopupLayout(
            top: 30,
            left: 30,
            right: 30,
            bottom: 50,
            child: StatefulBuilder(builder: (context, setState) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Navigation Guide'),
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
                  resizeToAvoidBottomPadding: true,
                  body: Container(
                      padding: EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                            Text(
                                "Hi, this is our SNAPP Calculator and Info app. There are some tools in this app that can help you estimate your monthly benefits, look for stores with SNAP eligibility and food availability, get official determinations and more."),
                            Text(
                                "\nFirst is the SNAP Benefits Calculator on this page. The calculator you see behind this popup is a simplified calculator that takes three inputs-- your number of dependents, or household members, your household's monthly income, and your total number of deductions."),
                            Text(
                                "\nAll information you input in this calculator is private. All calculations are done locally, and nothing is stored in any other place. Rest assured that your information is 100% safe and not used for anything else but determining your potential benefit."),
                            Text(
                                "\nIf you don't have an idea of how much your potential deductions might be, you can answer some other questions in the advanced calculator (under the + icon). Currently, the advanced calculator only supports estimates according to NY SNAP policies. We'll work to add estimates for other policies"),
                            Text(
                                "\n\nSome other resources included in this app are the ")
                          ]))));
            })));
    setState(() {});
  }

  showStateChoices(BuildContext context, {BuildContext popupContext}) {
    String dropdownValue = 'New York';
    Navigator.push(
        context,
        PopupLayout(
            top: 120,
            left: 30,
            right: 30,
            bottom: 150,
            child: StatefulBuilder(builder: (context, setState) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Advanced Calculator'),
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
                  resizeToAvoidBottomPadding: true,
                  body: Container(
                      padding: EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                            Text(
                                "This is the advanced calculator. We make no guarantees for the accuracy or timeliness of this application, nor will we be responsible for any decisions made based on the estimates provided here. Use this tool to get a general idea of your potential benefit, but if you have any questions at all you should go receive an official estimate. \n\nWe will try our best to keep the information accurate and timely. If there are any bugs please report them to us using the contact information in the resources section. \n\nSelect your state below to open our estimator tool designed around your state's policies. (Right now, we only have New York done-- more to come soon) "),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                  if (dropdownValue == 'New York')
                                    showPopup(context);
                                });
                              },
                              items: <String>[
                                'New York'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ]))));
            })));
    setState(() {});
  }

  showPopup(BuildContext context, {BuildContext popupContext}) {
    Navigator.push(
        context,
        PopupLayout(
            top: 30,
            left: 30,
            right: 30,
            bottom: 50,
            child: StatefulBuilder(builder: (context, setState) {
              //this is all the stuff going in the advanced ny deduction section in the popup. Maybe add an option to look at more states soon
              return Scaffold(
                  appBar: AppBar(
                    title: Text('NY Advanced Deduction Guide'),
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
                                      'How many people live in your household? ',
                                  labelText: 'Household size: '),
                              onChanged: (String householdSize) {
                                if (!(householdSize.contains('@') ||
                                    householdSize
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    householdSize
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (householdSize == null &&
                                        int.tryParse(householdSize) == null))) {
                                  setState(() {
                                    model.yourHouseholdSize =
                                        int.parse(householdSize);
                                    model.updateMax();
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              onSaved: (String householdSize) {
                                if (!(householdSize.contains('@') ||
                                    householdSize
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    householdSize
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (householdSize == null &&
                                        int.tryParse(householdSize) == null))) {
                                  setState(() {
                                    model.yourHouseholdSize =
                                        int.parse(householdSize);
                                    model.updateMax();
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              validator: (String householdSizeValidator) {
                                if (householdSizeValidator.contains('@') ||
                                    householdSizeValidator.contains('.') ||
                                    householdSizeValidator
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    householdSizeValidator
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (householdSizeValidator == null &&
                                        int.tryParse(householdSizeValidator) ==
                                            null)) {
                                  model.yourHouseholdSize = 0;
                                  model.updateNYBenefit();
                                }
                                return householdSizeValidator.contains('@') ||
                                        householdSizeValidator.contains('.') ||
                                        householdSizeValidator
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        householdSizeValidator
                                            .contains(new RegExp(r'[a-z]')) ||
                                        (householdSizeValidator == null &&
                                            int.tryParse(
                                                    householdSizeValidator) ==
                                                null)
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidate: true,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.child_care),
                                  border: InputBorder.none,
                                  hintText:
                                      'How much child support do you pay monthly? ',
                                  labelText:
                                      'Monthly child support payment (optional) '),
                              onChanged: (String childSupport) {
                                if (!(childSupport.contains('@') ||
                                    childSupport
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    childSupport
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (childSupport == null &&
                                        double.tryParse(childSupport) ==
                                            null))) {
                                  setState(() {
                                    model.yourChildSupport =
                                        double.parse(childSupport);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              onSaved: (String childSupport) {
                                if (!(childSupport.contains('@') ||
                                    childSupport
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    childSupport
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (childSupport == null &&
                                        double.tryParse(childSupport) ==
                                            null))) {
                                  setState(() {
                                    model.yourChildSupport =
                                        double.parse(childSupport);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              validator: (String childSupport) {
                                if (childSupport.contains('@') ||
                                    childSupport
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    childSupport
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (childSupport == null &&
                                        double.tryParse(childSupport) ==
                                            null)) {
                                  model.yourChildSupport = 0;
                                  model.updateNYBenefit();
                                }
                                return childSupport.contains('@') ||
                                        childSupport
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        childSupport
                                            .contains(new RegExp(r'[a-z]')) ||
                                        (childSupport == null &&
                                            double.tryParse(childSupport) ==
                                                null)
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
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedIncome == null &&
                                        double.tryParse(inputtedIncome) ==
                                            null))) {
                                  setState(() {
                                    model.yourUnearnedIncome =
                                        (double.parse(inputtedIncome));
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              validator: (String inputtedIncome) {
                                if (inputtedIncome
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedIncome
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedIncome == null &&
                                        double.tryParse(inputtedIncome) ==
                                            null)) {
                                  model.yourUnearnedIncome = 0;
                                  model.updateNYBenefit();
                                }
                                return (inputtedIncome
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedIncome
                                            .contains(new RegExp(r'[a-z]')) ||
                                        (inputtedIncome == null &&
                                            double.tryParse(inputtedIncome) ==
                                                null))
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
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedIncome == null &&
                                        double.tryParse(inputtedIncome) ==
                                            null))) {
                                  setState(() {
                                    model.yourEarnedIncome =
                                        (double.parse(inputtedIncome));
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              onSaved: (String inputtedIncome) {
                                if (!(inputtedIncome
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedIncome
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedIncome == null &&
                                        double.tryParse(inputtedIncome) ==
                                            null))) {
                                  setState(() {
                                    model.yourEarnedIncome =
                                        (double.parse(inputtedIncome));
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              validator: (String inputtedIncome) {
                                if (inputtedIncome
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedIncome
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedIncome == null &&
                                        double.tryParse(inputtedIncome) ==
                                            null)) {
                                  model.yourEarnedIncome = 0;
                                  model.updateNYBenefit();
                                }
                                return (inputtedIncome
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedIncome
                                            .contains(new RegExp(r'[a-z]')) ||
                                        (inputtedIncome == null &&
                                            double.tryParse(inputtedIncome) ==
                                                null))
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidate: true,
                            ),
                            new TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.child_friendly),
                                  border: InputBorder.none,
                                  hintText:
                                      'Dependent care (for children under 18 or disabled household members of any age ',
                                  labelText:
                                      'Dependent care costs (for children under 18 or disabled household members of any age)'),
                              onChanged: (String inputtedCare) {
                                if (!(inputtedCare
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedCare
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedCare == null &&
                                        double.tryParse(inputtedCare) ==
                                            null))) {
                                  setState(() {
                                    model.yourDependentCareCosts =
                                        double.parse(inputtedCare);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              onSaved: (String inputtedCare) {
                                if (!(inputtedCare
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedCare
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedCare == null &&
                                        double.tryParse(inputtedCare) ==
                                            null))) {
                                  setState(() {
                                    model.yourDependentCareCosts =
                                        double.parse(inputtedCare);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              validator: (String inputtedCare) {
                                if (inputtedCare
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedCare
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedCare == null &&
                                        double.tryParse(inputtedCare) ==
                                            null)) {
                                  model.yourDependentCareCosts = 0;
                                  model.updateNYBenefit();
                                }
                                return (inputtedCare
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedCare
                                            .contains(new RegExp(r'[a-z]')))
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidate: true,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.cake),
                                  border: InputBorder.none,
                                  hintText:
                                      'How old is the dependent you care for? (expenses from last question ',
                                  labelText: 'Dependent Age: '),
                              onChanged: (String dependentAge) {
                                if (!(dependentAge.contains('@') ||
                                        dependentAge
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        dependentAge
                                            .contains(new RegExp(r'[a-z]'))) ||
                                    (dependentAge == null &&
                                        int.tryParse(dependentAge) == null)) {
                                  setState(() {
                                    model.yourDependentAge =
                                        int.parse(dependentAge);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              onSaved: (String dependentAge) {
                                if (!(dependentAge.contains('@') ||
                                    dependentAge
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    dependentAge
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (dependentAge == null &&
                                        int.tryParse(dependentAge) == null))) {
                                  setState(() {
                                    model.yourDependentAge =
                                        int.parse(dependentAge);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              validator: (String dependentAgeValidator) {
                                if (dependentAgeValidator.contains('@') ||
                                    dependentAgeValidator.contains('.') ||
                                    dependentAgeValidator
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    dependentAgeValidator
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (dependentAgeValidator == null &&
                                        int.tryParse(dependentAgeValidator) ==
                                            null)) {
                                  model.yourDependentAge = 18;
                                  model.updateNYBenefit();
                                }
                                return dependentAgeValidator.contains('@') ||
                                        dependentAgeValidator.contains('.') ||
                                        dependentAgeValidator
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        dependentAgeValidator
                                            .contains(new RegExp(r'[a-z]')) ||
                                        (dependentAgeValidator == null &&
                                            int.tryParse(
                                                    dependentAgeValidator) ==
                                                null)
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
                                Text(
                                    "Check if you are disabled or elderly or if you have disabled or elderly household members"),
                                Checkbox(
                                  value: model.disabledOrElderly,
                                  onChanged: (bool value) {
                                    setState(() {
                                      model.disabledOrElderly = value;
                                      model.updateNYBenefit();
                                    });
                                  },
                                ),
                              ],
                            ),
                            new TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.local_hospital),
                                  border: InputBorder.none,
                                  hintText:
                                      'How much do you pay per month for medical expenses for elderly or disabled household members? (costs not reimbursed by Title XVIII (Medicare) or XIX (Medicaid))',
                                  labelText: 'Medical expenses '),
                              onChanged: (String inputtedMedical) {
                                if (!(inputtedMedical
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedMedical
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedMedical == null &&
                                        double.tryParse(inputtedMedical) ==
                                            null))) {
                                  setState(() {
                                    model.yourMedicalExpenses =
                                        double.parse(inputtedMedical);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              onSaved: (String inputtedMedical) {
                                if (!(inputtedMedical
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedMedical
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedMedical == null &&
                                        double.tryParse(inputtedMedical) ==
                                            null))) {
                                  setState(() {
                                    model.yourMedicalExpenses =
                                        double.parse(inputtedMedical);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              validator: (String inputtedMedical) {
                                if (inputtedMedical
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedMedical
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedMedical == null &&
                                        double.tryParse(inputtedMedical) ==
                                            null)) {
                                  model.yourMedicalExpenses = 0;
                                  model.updateNYBenefit();
                                }
                                return (inputtedMedical
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedMedical
                                            .contains(new RegExp(r'[a-z]')) ||
                                        inputtedMedical == null)
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidate: true,
                            ),
                            new TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.home),
                                  border: InputBorder.none,
                                  hintText:
                                      'How much do you pay for rent/mortgage each month? ',
                                  labelText: 'Rent/mortgage '),
                              onSaved: (String inputtedRent) {
                                if (!(inputtedRent
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedRent
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedRent == null &&
                                        double.tryParse(inputtedRent) ==
                                            null))) {
                                  setState(() {
                                    model.yourRentOrMortgage =
                                        double.parse(inputtedRent);
                                    model.updateBenefit();
                                  });
                                }
                              },
                              onChanged: (String inputtedRent) {
                                if (!(inputtedRent
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedRent
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedRent == null &&
                                        double.tryParse(inputtedRent) ==
                                            null))) {
                                  setState(() {
                                    model.yourRentOrMortgage =
                                        double.parse(inputtedRent);
                                    model.updateNYBenefit();
                                  });
                                }
                              },
                              validator: (String inputtedRent) {
                                if (inputtedRent
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedRent
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedRent == null &&
                                        double.tryParse(inputtedRent) ==
                                            null)) {
                                  model.yourRentOrMortgage = 0;
                                  model.updateNYBenefit();
                                }
                                return (inputtedRent
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedRent
                                            .contains(new RegExp(r'[a-z]')) ||
                                        (inputtedRent == null &&
                                            double.tryParse(inputtedRent) ==
                                                null))
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidate: true,
                            ),
                            Text(
                                '\nWhere in the state do you live? (used to determine standard utility allowances\n'),
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
                            Text(
                                '\nDo you have heating or cooling costs, or utility costs? (used to determine standard utility allowances\n'),
                            Column(
                              children: choices2.map((item) {
                                //change index of choices array as you need
                                return RadioListTile(
                                  groupValue:
                                      model.yourStandardUtilityAllowanceLevel,
                                  title: Text(item),
                                  value: item,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    print(val);
                                    setState(() {
                                      if (val ==
                                          "I have heating and cooling costs. (Doesn't matter if they are partially or fully covered by HEAP)")
                                        model.yourStandardUtilityAllowanceLevel =
                                            1;
                                      else if (val == "I have utility costs.")
                                        model.yourStandardUtilityAllowanceLevel =
                                            2;
                                      else if (val == "I have neither.")
                                        model.yourStandardUtilityAllowanceLevel =
                                            3;
                                      else
                                        model.yourStandardUtilityAllowanceLevel =
                                            3;
                                      model.updateNYBenefit();
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            new TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.add),
                                  border: InputBorder.none,
                                  hintText:
                                      'How much do you pay in other (non-utility/rent/mortgage) shelter costs? ',
                                  labelText:
                                      'Other shelter expenses (non-utility/rent) '),
                              onSaved: (String inputtedShelter) {
                                if (!(inputtedShelter
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedShelter
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedShelter == null &&
                                        double.tryParse(inputtedShelter) ==
                                            null))) {
                                  setState(() {
                                    model.yourOtherShelterCosts =
                                        double.parse(inputtedShelter);
                                    model.updateBenefit();
                                  });
                                }
                              },
                              onChanged: (String inputtedShelter) {
                                if (!(inputtedShelter
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedShelter
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedShelter == null &&
                                        double.tryParse(inputtedShelter) ==
                                            null))) {
                                  setState(() {
                                    model.yourOtherShelterCosts =
                                        double.parse(inputtedShelter);
                                    model.updateBenefit();
                                  });
                                }
                              },
                              validator: (String inputtedShelter) {
                                if (inputtedShelter
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedShelter
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedShelter == null &&
                                        double.tryParse(inputtedShelter) ==
                                            null)) {
                                  model.yourOtherShelterCosts = 0;
                                  model.updateNYBenefit();
                                }
                                return (inputtedShelter
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedShelter
                                            .contains(new RegExp(r'[a-z]')) ||
                                        (inputtedShelter == null &&
                                            double.tryParse(inputtedShelter) ==
                                                null))
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidate: true,
                            ),
                            new RaisedButton(
                              child: const Text('Update Benefit'),
                              color: Theme.of(context).accentColor,
                              elevation: 4.0,
                              splashColor: Colors.amberAccent,
                              textColor: const Color(0xFFFFFFFF),
                              onPressed: () {
                                model.updateNYBenefit();
                                // Perform some action
                              },
                            ),
                            new RaisedButton(
                              child:
                                  const Text('Show Benefit and Calculations'),
                              color: Theme.of(context).accentColor,
                              elevation: 4.0,
                              splashColor: Colors.amberAccent,
                              textColor: const Color(0xFFFFFFFF),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildAboutAdvanced(context),
                                );
                                // Perform some action
                              },
                            ),
                          ]),
                    ),
                  ));
            })));
    setState(() {});
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
                          numOfPeople.contains(new RegExp(r'[a-z]')) ||
                          (numOfPeople == null &&
                              double.tryParse(numOfPeople) == null)
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
                      inputtedIncome.contains(new RegExp(r'[a-z]')) ||
                      (inputtedIncome == null) &&
                          double.tryParse(inputtedIncome) == null)) {
                    setState(() {
                      model.monthlyIncome = (double.parse(inputtedIncome));
                      model.updateBenefit();
                    });
                  }
                },
                validator: (String inputtedIncome) {
                  return (inputtedIncome.contains(new RegExp(r'[A-Z]')) ||
                          inputtedIncome.contains(new RegExp(r'[a-z]')) ||
                          (inputtedIncome == null &&
                              double.tryParse(inputtedIncome) == null))
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
                        'What is your estimated total deductions? Use the advanced tool if you\'re not sure. ',
                    labelText:
                        'Estimated total deduction (if you\'re not sure, and live in NY, click the + button '),
                onChanged: (String inputtedDeduction) {
                  setState(() {
                    model.yourDeduction = double.parse(inputtedDeduction);
                    model.updateBenefit();
                  });
                },
                validator: (String inputtedDeduction) {
                  return (inputtedDeduction.contains(new RegExp(r'[A-Z]')) ||
                          inputtedDeduction.contains(new RegExp(r'[a-z]')) ||
                          (inputtedDeduction == null &&
                              double.tryParse(inputtedDeduction) == null))
                      ? 'Only use numbers.'
                      : null;
                },
                autovalidate: true,
              ),
              new Text("Your max benefit: " + model.yourMax.toString()),
              new Text(
                  "Your estimated benefit: " + model.yourBenefit.toString()),
              new RaisedButton(
                child: const Text('Show Calculation Steps'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.amberAccent,
                textColor: const Color(0xFFFFFFFF),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildAboutDialog(context),
                  );
                  // Perform some action
                },
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      showInfo(context);
                    },
                    child: Icon(Icons.device_unknown),
                    backgroundColor: Colors.blue,
                  )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      showStateChoices(context);
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.blue,
                  )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      showDisclaimer(context);
                    },
                    child: Icon(Icons.announcement),
                    backgroundColor: Colors.blue,
                  ))
            ]),
      ),
//

      Container(
        padding: EdgeInsets.all(10.0),
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              'https://usda-fns.maps.arcgis.com/apps/webappviewer/index.html?id=e1f3028b217344d78b324193b10375e4',
        ),
      ),
      Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(children: /*<Widget>[Column(children:*/ <Widget>[
            Flexible(
                child: ExpansionTile(
                    title: Column(children: <Widget>[Text('Contact:')]),
                    children: <Widget>[
                  Text("""If you have any questions or concerns at all about anything, please don't hesitate to contact us at one of these places:\n\nEmail: snappestimatorapp@gmail.com\nPhone: (516) 268-1933 """),
                ])),
            Flexible(
              child: ExpansionTile(
                title:  Column(children: <Widget>[Text('Additional Resources:')]),
                children: <Widget>[
                  /*ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, position) {
                    return */
                  SelectableLinkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    style: TextStyle(color: Colors.black),
                    linkStyle: TextStyle(color: Colors.blueAccent),
                    text:
                        """None of the resources listed are affiliated with the SNAPP app and we make no guarantees about the accuracy of the information in them. These resources were compiled by SNAPP app from governmental and nongovernmental websites.

If you have questions, don’t hesitate to consult one of these resources or ask them at your local office.

New York SNAP application and other resources: 
https://mybenefits.ny.gov/mybenefits/begin

NY SNAP hotline: 1-800-342-3009

SNAP State Directory: 
https://www.fns.usda.gov/snap/state-directory

Find your local SNAP Center: 
https://www1.nyc.gov/site/hra/locations/snap-locations.page

Federal Nutrition Service Regional offices: 
https://www.fns.usda.gov/fns-regional-offices

Office of the Inspector General Hotline: 
https://www.usda.gov/oig/hotline

SNAP: COVID-19 Waivers by State | USDA-FNS - https://www.fns.usda.gov/disaster/pandemic/covid-19/snap-waivers-flexibilities
""",
                  ),

                  RichText(
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: "Additional food aid for new parents:",
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  SelectableLinkify(
                      onOpen: (link) async {
                        if (await canLaunch(link.url)) {
                          await launch(link.url);
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      linkStyle: TextStyle(color: Colors.blueAccent),
                      text: """WIC Program Information: 
https://www.fns.usda.gov/wic

NY WIC Information: 
https://www.health.ny.gov/prevention/nutrition/wic/

Applying for WIC in NY: 
https://www.health.ny.gov/prevention/nutrition/wic/how_to_apply.htm
"""),

                  RichText(
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                "Other benefits and discounts an EBT card qualifies you for:",
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  SelectableLinkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    style: TextStyle(color: Colors.black),
                    linkStyle: TextStyle(color: Colors.blueAccent),
                    text: """https://lowincomerelief.com/ny-food-stamps/

A very helpful list of other emergency food resources assembled by r/foodstamps: https://www.reddit.com/r/foodstamps/wiki/index/emergencyfood#wiki_emergency_food_resources

r/foodStamps is a helpful forum on reddit that also has a lot of good resources and clarification in its wiki here: 
https://old.reddit.com/r/foodstamps/wiki/index

""",
                  ),

                  RichText(
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: "Aid for other basic needs:",
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  SelectableLinkify(
                      onOpen: (link) async {
                        if (await canLaunch(link.url)) {
                          await launch(link.url);
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      linkStyle: TextStyle(color: Colors.blueAccent),
                      text:
                          """Benefit Finder Questionaire | Benefits.gov: https://www.benefits.gov/benefit-finder#benefits&qc=cat_1

Home Energy Assistance Program (HEAP)  myBenefits (ny.gov): https://mybenefits.ny.gov/mybenefits/begin


Help with managing benefits and budgeting:
Meal Planning, Shopping, and Budgeting | SNAP-Ed (usda.gov): https://snaped.fns.usda.gov/nutrition-education/nutrition-education-materials/meal-planning-shopping-and-budgeting

What Can SNAP Buy? | USDA-FNS:
 https://www.fns.usda.gov/snap/eligible-food-items

Fresh EBT | Food Stamp Balance App for Android and iPhone (freshebt.com): https://www.freshebt.com/ """)
                  //})
                ],
              ),
            ),
            ExpansionTile(
              title: Column(children: <Widget>[Text('Citations:')]),
              children: <Widget>[
                Text(
                    "These are the places we researched and sourced our estimate info and map from. If there are any inaccuracies in the calculator or these sources, please let us know at one of our contact sites listed below.\n\n"),
                SelectableLinkify(
                  onOpen: (link) async {
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  linkStyle: TextStyle(color: Colors.blueAccent),
                  text: """
    SNAP Benefits Food Program | NYC https://www1.nyc.gov/site/hra/help/snap-benefits-food-program.page
    
    SNAP: State by State Data, Fact Sheets, and Resources | Center on Budget and Policy Priorities (cbpp.org)
    https://www.cbpp.org/research/food-assistance/snap-state-by-state-data-fact-sheets-and-resources

    FSSB081706.book (ny.gov)
    https://otda.ny.gov/programs/snap/SNAPSB.pdf

    Supplemental Nutrition Assistance Program (SNAP) | OTDA (ny.gov)
    https://otda.ny.gov/programs/snap/

    Supplemental Nutrition Assistance Program (SNAP) | USDA-FNS
    https://www.fns.usda.gov/snap/supplemental-nutrition-assistance-program

    SNAP Benefits - HRA (nyc.gov)
    https://www1.nyc.gov/site/hra/help/snap-benefits-food-program.page

    SNAP Retailer Locator: https://usda-fns.maps.arcgis.com/apps/webappviewer/index.html?id=e1f3028b217344d78b324193b10375e4""",
                )
                //})
              ],
            ),
            ExpansionTile(
                title: Column(children: <Widget>[Text('Legal:')]),
                children: <Widget>[
                  Text("""We don’t make any guarantees to the accuracy of this information. We try and will continue to try our best to keep it updated and on par with policies-- but they change and we aren’t always the fastest. To be real, we’re just some broke kids who have no idea whether or not any of the disclaimers in this app are legit or will ever protect us from everything, we just want to make an app that might help a few people. Don’t sue us please and if you have any problems with anything here, come to us first and we’ll be really understanding. 

Thanks and stay safe! """),
                ])
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
