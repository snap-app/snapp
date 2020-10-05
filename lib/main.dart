import 'package:flutter/material.dart';
import 'package:snapp/resources.dart';
//import 'package:snapp/updates.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home.dart';

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
  String yourStandardUtilityAllowanceLevel;
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
    yourArea = "Rest of State";
    yourAdjustedIncome = 0;
    yourStandardUtilityAllowance = 30;
    yourStandardUtilityAllowanceLevel = "I have neither.";
    yourOtherShelterCosts = 0;
    disabledOrElderly = false;
    yourShelterExcess = 0;
    yourNetIncome = 0;
    yourNYBenefit = 0;
  }

  static double getMaxBenefit(int householdSize) {
    if (householdSize >= 8) {
      return (1224 + (householdSize - 8.0) * 153);
    } else if (householdSize == 7) {
      return 1071;
    } else if (householdSize == 6) {
      return 969;
    } else if (householdSize == 5) {
      return 807;
    } else if (householdSize == 4) {
      return 680;
    } else if (householdSize == 3) {
      return 535;
    } else if (householdSize == 2) {
      return 374;
    } else if (householdSize == 1) {
      return 204;
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
    if (familySize == 4) return 181;
    if (familySize == 5) return 212;
    if (familySize >= 6)
      return 243;
    else
      return 0;
  }

  static double getHomelessDeduction(bool homelessness) {
    if (homelessness) {
      return 156.74;
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

  static double getStandardUtilityAllowancesNewYork(String area, String level) {
    if (area == "New York City") {
      if (level ==
          "I have heating and cooling costs. (Doesn't matter if they are partially or fully covered by HEAP)") {
        return 800;
      }
      if (level == "I have utility costs.") {
        return 316;
      }
      if (level == "I have neither.") {
        return 30;
      }
    }
    if (area == "Nassau & Suffolk Counties") {
      if (level ==
          "I have heating and cooling costs. (Doesn't matter if they are partially or fully covered by HEAP)") {
        return 744;
      }
      if (level == "I have utility costs.") {
        return 292;
      }
      if (level == "I have neither.") {
        return 30;
      }
    }
    if (area == "Rest of State") {
      if (level ==
          "I have heating and cooling costs. (Doesn't matter if they are partially or fully covered by HEAP)") {
        return 661;
      }
      if (level == "I have utility costs.") {
        return 268;
      }
      if (level == "I have neither.") {
        return 30;
      }
    }
    return 30;
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
      String utilityAllowanceLevel,
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

    double standardUtilityAllowance =
        getStandardUtilityAllowancesNewYork(location, utilityAllowanceLevel);

    double shelterExcess = getShelterExcessNewYork(
        adjustedIncome,
        rentOrMortgage,
        getStandardUtilityAllowancesNewYork(location, utilityAllowanceLevel),
        otherShelter,
        disabledOrElderly);

    if (homelessnessStatus) shelterExcess = 0;

    double netIncome = adjustedIncome - shelterExcess;

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
  static const String _title = "SNAP Estimator and Resources";
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
  String yourStandardUtilityAllowanceLevel;
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
    yourArea = "Rest of State";
    yourAdjustedIncome = 0;
    yourStandardUtilityAllowance = 30;
    yourStandardUtilityAllowanceLevel = "I have neither.";
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      Home(
        model: model,
        choices: choices,
        choices2: choices2,
      ),
      Container(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              'https://usda-fns.maps.arcgis.com/apps/webappviewer/index.html?id=e1f3028b217344d78b324193b10375e4',
        ),
      ),
      Resources(),
      // Updates(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('SNAP ToolCenter NY'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'SNAPMAP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Resources',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.remove_red_eye),
          //   label: 'Updates',
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
