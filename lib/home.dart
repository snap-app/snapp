import 'package:flutter/material.dart';
import 'package:snapp/main.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:async';

class Home extends StatefulWidget {
  final Model model;
  final List<String> choices;
  final List<String> choices2;
  Home(
      {Key key,
      @required this.model,
      @required this.choices,
      @required this.choices2})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
} //TODO: finish the CT calculator, pack advanced explanation section for NY a little better, then look into grant stuff/some more resources

class HomeState extends State<Home> {
  Widget _buildAboutAdvancedNY(BuildContext context) {
    widget.model.updateNYBenefit();
    return new AlertDialog(
      title: const Text('NY Full Calculation:'),
      content: new SingleChildScrollView(
        child: //StatefulBuilder(builder: (context, setState) {
            Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                          "Your maximum is: " + widget.model.yourMax.toString(),
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
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
                      text: "Your estimated benefit is: " +
                          widget.model.yourNYBenefit.toString(),
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(
                "\n\nThis estimator was last updated on 10/5 to take into account the SNAP 2021 fiscal year COLA adjustments.\n\nDo your best to fill out these questions. None of your info is saved anywhere else. If you don't know the exact answer, try to estimate or you can leave the field blank."),
            Text("\n \nFirst, your maximum possible benefit (\$" +
                widget.model.yourMax.toString() +
                ") is calculated based on your household size. You can be a separate filing group even if you live with family or other people, as long as you purchase and prepare food separately. Individuals can only receive FS as a member of one household per month. \n"),
            ExpansionTile(
              title: Column(
                  children: <Widget>[Text('What is a household member?')]),
              children: <Widget>[
                Text("""From page 48 of NY SNAP Policy Handbook
HOUSEHOLD COMPOSITION - Household composition is based primarily on food units. A food unit consists of individuals customarily purchasing food and preparing meals together for home consumption. Local districts shall generally accept a household's statement as to which individuals residing with the household are members. 

NOTE: A person cannot participate as a member of more than one household at a time unless the person is a resident of a shelter for battered women and children (as defined in FSSB Section 5) and was a member of a household containing the person who has abused him or her. 

A household is composed of any of the following individuals or groups of individuals: • An individual living alone, • An individual living with others but customarily purchasing food and preparing meals for home consumption separate and apart from others, or • A group of individuals who live together and customarily purchase food and prepare meals together for home consumption

 """),
              ],
            ),
            ExpansionTile(
              title: Column(children: <Widget>[
                Text(
                    'Is one or more of my household members elderly or disabled?')
              ]),
              children: <Widget>[
                Text("""From page 56 of NY SNAP Policy Handbook
1. An elderly member is one who is 60 years of age or older. 

2. A disabled member is one who is: 

a. Receiving Supplemental Security Income (SSI) benefits under Title XVI of the Social Security Act or disability or blindness payments under Titles I, II, X, XIV, or XVI of the Social Security Act, 

b. A veteran with a service-connected or non-service connected disability rated or paid as total (100%) by the Veteran's Administration (VA) or is considered by the VA to be in need of regular aid and attendance or permanently housebound, 

c. A surviving spouse of a veteran and considered by the VA to be in need of regular aid and attendance or permanently housebound, 

d. A surviving child of a veteran and considered by the VA to be permanently incapable of self-support, 

e. A surviving spouse or child of a veteran and entitled to compensation for a service-connected death or pension benefits for a non-service connected death based on a VA determination and has a disability considered permanent under the Social Security Act. "Entitled" in this definition refers to those veterans' surviving spouses and children who are receiving the benefits stated above or have been approved for such payment. For disabilities that are considered permanent see FSSB Section 18. 

f. Receiving Federal- or State-administered supplemental benefits under section 1616(a) of the Social Security Act provided that the eligibility to receive the benefits is based upon the disability or blindness criteria used under title XVI of the Social Security Act. 

g. Receiving Federal- or State-administered supplemental benefits under section 212(a) of Public Law 93- 66, 

h. Receiving a Federal, State or Local government disability retirement pension because of a disability considered permanent under Section 221(i) of the Social Security Act. This includes individuals receiving payments under the Federal Employment Compensation Act (FECA). Individuals receiving FECA payments are considered permanently disabled under section 221(i) of the Social Security Act if the payments are made to a person in lieu of Civil Service Retirement (CSR) benefits. Persons receiving FECA payments pending a determination of eligibility for CSR may not be considered disabled under this provision. Only those who can document that they have elected to receive FECA payments in lieu of CSR benefits satisfy the requirements of this provision. NOTE: Employees injured on the job who receive temporary FECA payments while they recover are not considered permanently disabled under this provision. 

i. Receiving an annuity under: (1) Section 2(a)(1)(v) of the Railroad Retirement Act of 1974 and is determined to be disabled based upon the criteria used under Title XVI of the Social Security Act; or (2) Section 2(a)(1)(iv) of the Railroad Retirement Act of 1974 and is determined to qualify for Medicare by the Railroad Retirement Board; or 

j. Receiving authorization of Medical Assistance (MA) based upon disability or blindness. In New York State, such medical assistance recipients are those who have been certified by Medical Assistance as blind, disabled or "SSI-related", pursuant to Title XVI. The following is a link to what disabilities are classified as permanent under the Social Security Act: http://www.ssa.gov/disability/professionals/bluebook/listing-impairments.htm 

k. A recipient of interim assistance benefits pending the receipt of Supplemental Security Income (SSI),
"""),
              ],
            ),
            Text(
                """\nThen, you determine your monthly gross income, a combination of your earned and unearned income."""),
            ExpansionTile(
              title:
                  Column(children: <Widget>[Text('What is unearned income?')]),
              children: <Widget>[
                Text(
                    """Unearned income is passive income including, but not limited to: 

Assistance payments
Annuities, pensions, retirement, veterans’ or disability benefits, workers’ or unemployment compensation
Gross income derived from rental property 
Support or alimony payments
Military pay, except additional pay based on deployment to a combat zone
Dividends, except from insurance policies
Interest
Royalties
Government sponsored program payments

Earned and unearned income constitutes the total countable income before any deductions, such as taxes, insurance, garnishments, etc.
            \n"""),
              ],
            ),
            Text(
                "\nNext, a series of deduction and exclusions are applied, calculated from a variety of factors in this process:\n"),
            Text("1. Legally obligated child support expenses, direct and indirect, (\$" +
                widget.model.yourChildSupport.toString() +
                ") are deducted from your gross income. This does not include alimony or spousal support. Child support is an income exclusion, so this figure constitutes your adjusted gross income, which is used to perform a gross income test. The gross income test determines eligibility, but doesn't otherwise affect the calculation of your benefits.\nThis estimator does not perform the gross income test, but you can find it or ask your local officials about it using resources in the resources section.\n"),
            Text("2. 20% of earned income (\$" +
                (widget.model.yourEarnedIncome * .2).toString() +
                ") is further deducted.\n"),
            Text("3. A standard deduction based on your household size (\$" +
                widget.model.yourStandardDeduction.toString() +
                ") is again deducted.\n"),
            Text("4. All actual dependent care costs (\$" +
                widget.model.yourDependentCareCosts.toString() +
                "), or expenses for the care of children under 18 years or incapacitated of any age, are deducted. Only unreimbursed costs for the dependent care itself is deducted-- and it is only applicable if it is necessary to allow a household member to accept a job, work, attend training or education, comply with work requirements, or look for work. \n"),
            Text(
                "5. If you are homeless, a deduction of \$156.74 is applied.\n"),
            Text(
                "6. Your medical expenses over \$35 a month ONLY for household members over 60 or disabled household members, that are not reimbursed by Title XVIII (Medicare) or XIX (Medicaid), (\$" +
                    widget.model.yourMedicalExpenses.toString() +
                    ") are deducted.\n"),
            Text("7. The deductions up to this point deducted from your gross income constitute your adjusted income (\$" +
                widget.model.yourAdjustedIncome.toString() +
                "). A shelter excess deduction may be applied. Its size and eligibility are determined as follows:"),
            Text("7a. Add up your rent/mortgage costs (\$" +
                widget.model.yourRentOrMortgage.toString() +
                "), your standard utility  allowance (\$" +
                widget.model.yourStandardUtilityAllowance.toString() +
                "), determined by your location within NY (" +
                widget.model.yourArea +
                ") and your level of utility payments (" +
                widget.model.yourStandardUtilityAllowanceLevel +
                "), and your other shelter expenses (\$" +
                widget.model.yourOtherShelterCosts.toString() +
                ")"),
            Text("7b. Take your total shelter expenses (\$" +
                (widget.model.yourOtherShelterCosts +
                        widget.model.yourRentOrMortgage +
                        widget.model.yourStandardUtilityAllowance)
                    .toString() +
                ") and then subtract half your adjusted income."),
            Text(
                "7c. If this amount is greater to or equal than \$586, your shelter excess deduction is \$586. If you have elderly (age 60 and over) or disabled household members, your deduction is the full amount instead of \$586. If the amount is negative, or if you are homeless (" +
                    widget.model.yourHomelessnessStatus.toString() +
                    "), your deduction for this section is \$0."),
            Text("\n8. Subtract the shelter excess calculated in step 7 (\$" +
                widget.model.yourShelterExcess.toString() +
                ") from your adjusted income calculated."),
            Text("\n9. That leaves you with your net income (\$" +
                widget.model.yourNetIncome.toString() +
                "). You are expected to put 30% of this figure towards food, which is subtracted from your maximum possible benefit of \$" +
                widget.model.yourMax.toString() +
                ". That leaves a final estimated monthly benefit of \$" +
                widget.model.yourNYBenefit.toString() +
                "."),
            Text(
                "\n\nTo see where we researched the calculations and deductions, and more, look in the Resources tab.")
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

  Widget _buildAboutAdvancedCT(BuildContext context) {
    widget.model.updateNYBenefit();
    return new AlertDialog(
      title: const Text('CT Full Calculation:'),
      content: new SingleChildScrollView(
        child: //StatefulBuilder(builder: (context, setState) {
            Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                          "Your maximum is: " + widget.model.yourMax.toString(),
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
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
                      text: "Your estimated benefit is: " +
                          widget.model.yourCTBenefit.toString(),
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(
                "\n\nThis estimator was last updated on 10/5 to take into account the SNAP 2021 fiscal year COLA adjustments.\n\nDo your best to fill out these questions. None of your info is saved anywhere else. If you don't know the exact answer, try to estimate or you can leave the field blank."),
            Text("\n \nFirst, your maximum possible benefit (\$" +
                widget.model.yourMax.toString() +
                ") is calculated based on your household size. You can be a separate filing group even if you live with family or other people, as long as you purchase and prepare food separately. Individuals can only receive FS as a member of one household per month. \n"),
            ExpansionTile(
              title: Column(
                  children: <Widget>[Text('What is a household member?')]),
              children: <Widget>[
                Text(
                    """(From CT SNAP Policy Manual) The program asks for the size of your household filing group, or Eligibility Determination Group. Even if you live with family or other people, you can be a separate filing group if you purchase and prepare food separately. Individuals can only receive FS as a member of one household per month. Some relationship rules to EDGs extend to spouses, parents and children, minors under parent control, and foster children and adults:

Individuals legally married and living together must be in the same EDG. 

Children include natural, step and adopted children.
Parents and their children 21 years of age and younger who live together must be in the same EDG even if the children have their own spouse or child who lives in the same household.
 
If the child under joint physical custody lives with one parent more than 50% of the time, the child is included in that parent’s household.
Children under joint physical custody spending an equal amount of time in each household during a month are included in the EDG:
the parents have agreed upon, or 
the EDG that applies first.  
 
A minor is an individual under 18 years of age. A minor who lives with, and is under the parental control of an adult, must be in the adult’s EDG, even if the adult is not the minor’s parent.
 
Parental control means the minor is dependent on the adult for financial or other support. 
 
The household may choose to include or exclude a foster child or foster adult who lives with them. If excluded, the foster child or adult is not eligible as a separate EDG, and the foster care payment is not income to the household.
                 """),
              ],
            ),
            ExpansionTile(
              title: Column(children: <Widget>[
                Text(
                    'Is one or more of my household members elderly or disabled?')
              ]),
              children: <Widget>[
                Text("""(From CT SNAP Policy Manual)
Elderly - Individuals 60 years of age or older at the end of the month for which benefits are being determined.

An individual who meets one or more of the following:
Receives disability or blindness benefits from any of these programs: Social Security, Supplemental Security Income (SSI), Medicaid, or SSI-related Medicaid.
Receives a federally or state administered SSI supplement based on disability or blindness, or section 212(a) of PL 93-66.
Receives a disability retirement benefit from a government agency for a disability considered permanent by SSA.
Is a veteran the VA considers totally disabled or permanently housebound or in need of regular aid and attendance.
Is a veteran’s surviving spouse who the VA considers:
in need of regular aid and attendance,
permanently housebound, or
approved for benefits because of the veteran’s death and has a disability considered permanent by SSA.
Is a veteran’s surviving child who the VA considers:
incapable of self-support, or
approved for benefits because of the veteran’s death and has a disability considered permanent by SSA
receives interim assistance benefits pending the receipt of Supplemental Security Income, receives disability related medical assistance under title XIX of the Social Security Act, or receives disability-based State general assistance (SAGA) benefits provided that the eligibility to receive any of these benefits is based upon disability or blindness criteria established by the State agency which are at least as stringent as those used under title XVI of the Social Security Act.
"""),
              ],
            ),
            Text(
                """\nThen, you determine your monthly gross income, a combination of your earned and unearned income."""),
            ExpansionTile(
              title:
                  Column(children: <Widget>[Text('What is unearned income?')]),
              children: <Widget>[
                Text(
                    """Unearned income is passive income including, but not limited to: 

Assistance payments
Annuities, pensions, retirement, veterans’ or disability benefits, workers’ or unemployment compensation
Gross income derived from rental property 
Support or alimony payments
Military pay, except additional pay based on deployment to a combat zone
Dividends, except from insurance policies
Interest
Royalties
Government sponsored program payments

Earned and unearned income constitutes the total countable income before any deductions, such as taxes, insurance, garnishments, etc.
            \n"""),
              ],
            ),
            Text(
                "\nNext, a series of deduction and exclusions are applied, calculated from a variety of factors in this process:\n"),
            Text("1. Legally obligated child support expenses, direct and indirect, (\$" +
                widget.model.yourChildSupport.toString() +
                ") are deducted from your gross income. This does not include alimony or spousal support. Child support is an income exclusion, so this figure constitutes your adjusted gross income, which is used to perform a gross income test. The gross income test determines eligibility, but doesn't otherwise affect the calculation of your benefits.\nThis estimator does not perform the gross income test, but you can find it or ask your local officials about it using resources in the resources section.\n"),
            Text("2. 20% of earned income (\$" +
                (widget.model.yourEarnedIncome * .2).toString() +
                ") is further deducted.\n"),
            Text("3. A standard deduction based on your household size (\$" +
                widget.model.yourStandardDeduction.toString() +
                ") is again deducted.\n"),
            Text("4. All actual dependent care costs (\$" +
                widget.model.yourDependentCareCosts.toString() +
                "), or expenses for the care of children under 18 years or incapacitated of any age, are deducted. Only unreimbursed costs for the dependent care itself is deducted-- and it is only applicable if it is necessary to allow a household member to accept a job, work, attend training or education, comply with work requirements, or look for work. \n"),
            Text(
                "5. If you are homeless, a deduction of \$156.74 is applied.\n"),
            Text(
                "6. Your medical expenses over \$35 a month ONLY for household members over 60 or disabled household members, that are not reimbursed by Title XVIII (Medicare) or XIX (Medicaid), (\$" +
                    widget.model.yourMedicalExpenses.toString() +
                    ") are deducted.\n"),
            Text("7. The deductions up to this point deducted from your gross income constitute your adjusted income (\$" +
                widget.model.yourAdjustedIncome.toString() +
                "). A shelter excess deduction may be applied. Its size and eligibility are determined as follows:"),
            Text("7a. Add up your rent/mortgage costs (\$" +
                widget.model.yourRentOrMortgage.toString() +
                "), your standard utility  allowance (\$" +
                widget.model.yourStandardUtilityAllowance.toString() +
                ") determined by your level of utility payments (" +
                widget.model.yourStandardUtilityAllowanceLevel +
                "), and your other shelter expenses (\$" +
                widget.model.yourOtherShelterCosts.toString() +
                ")"),
            Text("7b. Take your total shelter expenses (\$" +
                (widget.model.yourOtherShelterCosts +
                        widget.model.yourRentOrMortgage +
                        widget.model.yourStandardUtilityAllowance)
                    .toString() +
                ") and then subtract half your adjusted income."),
            Text(
                "7c. If this amount is greater to or equal than \$586, your shelter excess deduction is \$586. If you have elderly (age 60 and over) or disabled household members, your deduction is the full amount instead of \$586. If the amount is negative, or if you are homeless (" +
                    widget.model.yourHomelessnessStatus.toString() +
                    "), your deduction for this section is \$0."),
            Text("\n8. Subtract the shelter excess calculated in step 7 (\$" +
                widget.model.yourShelterExcess.toString() +
                ") from your adjusted income calculated."),
            Text("\n9. That leaves you with your net income (\$" +
                widget.model.yourNetIncome.toString() +
                "). You are expected to put 30% of this figure towards food, which is subtracted from your maximum possible benefit of \$" +
                widget.model.yourMax.toString() +
                ". That leaves a final estimated monthly benefit of \$" +
                widget.model.yourNYBenefit.toString() +
                "."),
            Text(
                "\n\nTo see where we researched the calculations and deductions, and more, look in the Resources tab.")
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
                    title: Text('Estimator Disclaimer'),
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
                                          "\nFirst is the SNAP Benefits Calculator on this page.",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(
                                      text:
                                          " The calculator you see behind this popup is a simplified calculator that takes three inputs-- your number of dependents, or household members, your household's monthly income, and your total number of deductions.")
                                ],
                              ),
                            ),
                            Text(
                                "\nAll information you input in this calculator is private. All calculations are done locally, and nothing is stored in any other place. Rest assured that your information is 100% safe and not used for anything else but determining your potential benefit."),
                            Text(
                                "\nIf you don't have an idea of how much your potential deductions might be, you can answer some other questions in the advanced calculator (under the + icon). Currently, the advanced calculator only supports estimates according to NY SNAP policies. We'll work to add estimates for other areas."),
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
                                          "\n\nSome other resources included in this app are: \n\nThe SNAPMAP Section ",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(
                                      text:
                                          "below, which contains the USDA FNS Retail Locator, which locates retailers that accept SNAP around your location. \n\nA host of other resources and information that might be helpful under the "),
                                  new TextSpan(
                                    text: "Resources Section.",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  new TextSpan(
                                    text:
                                        "\n\nAnd, a stream of updates for SNAP policy updates and news under the",
                                  ),
                                  new TextSpan(
                                    text: " Updates Section.",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
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
                                "This is the advanced calculator. We make no guarantees for the accuracy or timeliness of this application, nor will we be responsible for any decisions made based on the estimates provided here. Use this tool to get a general idea of your potential benefit, but if you have any questions at all you should go receive an official estimate. \n\nWe will try our best to keep the information accurate and timely. If there are any bugs or inaccuracies please report them to us using the contact information in the resources section. \n\nSelect your state below to open our estimator tool designed around your state's policies. (Right now, we only have New York done-- more to come soon) "),
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
                                    showNYPopup(context);
                                  if (dropdownValue == 'Connecticut')
                                    showCTPopup(context);
                                });
                              },
                              items: <String>[
                                'New York',
                                'Connecticut'
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

  showNYPopup(BuildContext context, {BuildContext popupContext}) {
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
                            Text(
                                "Questions? \nHit show calculation at bottom for clarification and help."),
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
                                    widget.model.yourHouseholdSize =
                                        int.parse(householdSize);
                                    widget.model.updateMax();
                                    widget.model.updateNYBenefit();
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
                                    widget.model.yourHouseholdSize =
                                        int.parse(householdSize);
                                    widget.model.updateMax();
                                    widget.model.updateNYBenefit();
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
                                  widget.model.yourHouseholdSize = 0;
                                  widget.model.updateNYBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
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
                                    widget.model.yourChildSupport =
                                        double.parse(childSupport);
                                    widget.model.updateNYBenefit();
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
                                    widget.model.yourChildSupport =
                                        double.parse(childSupport);
                                    widget.model.updateNYBenefit();
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
                                  widget.model.yourChildSupport = 0;
                                  widget.model.updateNYBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
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
                                    widget.model.yourUnearnedIncome =
                                        (double.parse(inputtedIncome));
                                    widget.model.updateNYBenefit();
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
                                  widget.model.yourUnearnedIncome = 0;
                                  widget.model.updateNYBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
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
                                    widget.model.yourEarnedIncome =
                                        (double.parse(inputtedIncome));
                                    widget.model.updateNYBenefit();
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
                                    widget.model.yourEarnedIncome =
                                        (double.parse(inputtedIncome));
                                    widget.model.updateNYBenefit();
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
                                  widget.model.yourEarnedIncome = 0;
                                  widget.model.updateNYBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
                            ),
                            new TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.child_friendly),
                                border: InputBorder.none,
                                hintText:
                                    'Dependent care (for children under 18 or disabled household members of any age ',
                                labelText:
                                    'Dependent care costs (for children under 18 or disabled household members of any age)',
                                labelStyle: TextStyle(fontSize: 8),
                              ),
                              onChanged: (String inputtedCare) {
                                if (!(inputtedCare
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedCare
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedCare == null &&
                                        double.tryParse(inputtedCare) ==
                                            null))) {
                                  setState(() {
                                    widget.model.yourDependentCareCosts =
                                        double.parse(inputtedCare);
                                    widget.model.updateNYBenefit();
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
                                    widget.model.yourDependentCareCosts =
                                        double.parse(inputtedCare);
                                    widget.model.updateNYBenefit();
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
                                  widget.model.yourDependentCareCosts = 0;
                                  widget.model.updateNYBenefit();
                                }
                                return (inputtedCare
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedCare
                                            .contains(new RegExp(r'[a-z]')))
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidateMode: AutovalidateMode.always,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Check if you are homeless"),
                                Checkbox(
                                  value: widget.model.yourHomelessnessStatus,
                                  onChanged: (bool value) {
                                    setState(() {
                                      widget.model.yourHomelessnessStatus =
                                          value;
                                      widget.model.updateNYBenefit();
                                    });
                                  },
                                ),
                                Text(
                                    "Check if you are disabled or elderly or if you have disabled or elderly household members"),
                                Checkbox(
                                  value: widget.model.disabledOrElderly,
                                  onChanged: (bool value) {
                                    setState(() {
                                      widget.model.disabledOrElderly = value;
                                      widget.model.updateNYBenefit();
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
                                  labelText:
                                      'Medical expenses for elderly or disabled'),
                              onChanged: (String inputtedMedical) {
                                if (!(inputtedMedical
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedMedical
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedMedical == null &&
                                        double.tryParse(inputtedMedical) ==
                                            null))) {
                                  setState(() {
                                    widget.model.yourMedicalExpenses =
                                        double.parse(inputtedMedical);
                                    widget.model.updateNYBenefit();
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
                                    widget.model.yourMedicalExpenses =
                                        double.parse(inputtedMedical);
                                    widget.model.updateNYBenefit();
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
                                  widget.model.yourMedicalExpenses = 0;
                                  widget.model.updateNYBenefit();
                                }
                                return (inputtedMedical
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedMedical
                                            .contains(new RegExp(r'[a-z]')) ||
                                        inputtedMedical == null)
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidateMode: AutovalidateMode.always,
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
                                    widget.model.yourRentOrMortgage =
                                        double.parse(inputtedRent);
                                    widget.model.updateNYBenefit();
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
                                    widget.model.yourRentOrMortgage =
                                        double.parse(inputtedRent);
                                    widget.model.updateNYBenefit();
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
                                  widget.model.yourRentOrMortgage = 0;
                                  widget.model.updateNYBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
                            ),
                            Text(
                                '\nWhere in the state do you live? (used to determine standard utility allowances)\n'),
                            Column(
                              children: widget.choices.map((item) {
                                //change index of choices array as you need
                                return RadioListTile(
                                  groupValue: widget.model.yourArea,
                                  title: Text(item),
                                  value: item,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    print(val);
                                    setState(() {
                                      widget.model.yourArea = val;
                                      widget.model.updateNYBenefit();
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            Text(
                                '\nDo you have heating or cooling costs, or utility costs? (used to determine standard utility allowances\n'),
                            Column(
                              children: widget.choices2.map((item) {
                                //change index of choices array as you need
                                return RadioListTile(
                                  groupValue: widget
                                      .model.yourStandardUtilityAllowanceLevel,
                                  title: Text(item),
                                  value: item,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    setState(() {
                                      widget.model
                                              .yourStandardUtilityAllowanceLevel =
                                          val;
                                      widget.model.updateNYBenefit();
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
                                    widget.model.yourOtherShelterCosts =
                                        double.parse(inputtedShelter);
                                    widget.model.updateNYBenefit();
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
                                    widget.model.yourOtherShelterCosts =
                                        double.parse(inputtedShelter);
                                    widget.model.updateNYBenefit();
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
                                  widget.model.yourOtherShelterCosts = 0;
                                  widget.model.updateNYBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
                            ),
                            new RaisedButton(
                              child: const Text('Update Benefit'),
                              color: Theme.of(context).accentColor,
                              elevation: 4.0,
                              splashColor: Colors.amberAccent,
                              textColor: const Color(0xFFFFFFFF),
                              onPressed: () {
                                widget.model.updateNYBenefit();
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
                                      _buildAboutAdvancedNY(context),
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

  showCTPopup(BuildContext context, {BuildContext popupContext}) {
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
                    title: Text('CT Advanced Deduction Guide'),
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
                            Text(
                                "Questions? \nHit show calculation at bottom for clarification and help."),
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
                                    widget.model.yourHouseholdSize =
                                        int.parse(householdSize);
                                    widget.model.updateMax();
                                    widget.model.updateCTBenefit();
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
                                    widget.model.yourHouseholdSize =
                                        int.parse(householdSize);
                                    widget.model.updateMax();
                                    widget.model.updateCTBenefit();
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
                                  widget.model.yourHouseholdSize = 0;
                                  widget.model.updateCTBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
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
                                    widget.model.yourChildSupport =
                                        double.parse(childSupport);
                                    widget.model.updateCTBenefit();
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
                                    widget.model.yourChildSupport =
                                        double.parse(childSupport);
                                    widget.model.updateCTBenefit();
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
                                  widget.model.yourChildSupport = 0;
                                  widget.model.updateCTBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
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
                                    widget.model.yourUnearnedIncome =
                                        (double.parse(inputtedIncome));
                                    widget.model.updateCTBenefit();
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
                                  widget.model.yourUnearnedIncome = 0;
                                  widget.model.updateCTBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
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
                                    widget.model.yourEarnedIncome =
                                        (double.parse(inputtedIncome));
                                    widget.model.updateCTBenefit();
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
                                    widget.model.yourEarnedIncome =
                                        (double.parse(inputtedIncome));
                                    widget.model.updateCTBenefit();
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
                                  widget.model.yourEarnedIncome = 0;
                                  widget.model.updateCTBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
                            ),
                            new TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.child_friendly),
                                border: InputBorder.none,
                                hintText:
                                    'Dependent care (for children under 18 or disabled household members of any age ',
                                labelText:
                                    'Dependent care costs (for children under 18 or disabled household members of any age)',
                                labelStyle: TextStyle(fontSize: 8),
                              ),
                              onChanged: (String inputtedCare) {
                                if (!(inputtedCare
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedCare
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedCare == null &&
                                        double.tryParse(inputtedCare) ==
                                            null))) {
                                  setState(() {
                                    widget.model.yourDependentCareCosts =
                                        double.parse(inputtedCare);
                                    widget.model.updateCTBenefit();
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
                                    widget.model.yourDependentCareCosts =
                                        double.parse(inputtedCare);
                                    widget.model.updateCTBenefit();
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
                                  widget.model.yourDependentCareCosts = 0;
                                  widget.model.updateCTBenefit();
                                }
                                return (inputtedCare
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedCare
                                            .contains(new RegExp(r'[a-z]')))
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidateMode: AutovalidateMode.always,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Check if you are homeless"),
                                Checkbox(
                                  value: widget.model.yourHomelessnessStatus,
                                  onChanged: (bool value) {
                                    setState(() {
                                      widget.model.yourHomelessnessStatus =
                                          value;
                                      widget.model.updateCTBenefit();
                                    });
                                  },
                                ),
                                Text(
                                    "Check if you are disabled or elderly or if you have disabled or elderly household members"),
                                Checkbox(
                                  value: widget.model.disabledOrElderly,
                                  onChanged: (bool value) {
                                    setState(() {
                                      widget.model.disabledOrElderly = value;
                                      widget.model.updateCTBenefit();
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
                                  labelText:
                                      'Medical expenses for elderly or disabled'),
                              onChanged: (String inputtedMedical) {
                                if (!(inputtedMedical
                                        .contains(new RegExp(r'[A-Z]')) ||
                                    inputtedMedical
                                        .contains(new RegExp(r'[a-z]')) ||
                                    (inputtedMedical == null &&
                                        double.tryParse(inputtedMedical) ==
                                            null))) {
                                  setState(() {
                                    widget.model.yourMedicalExpenses =
                                        double.parse(inputtedMedical);
                                    widget.model.updateCTBenefit();
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
                                    widget.model.yourMedicalExpenses =
                                        double.parse(inputtedMedical);
                                    widget.model.updateCTBenefit();
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
                                  widget.model.yourMedicalExpenses = 0;
                                  widget.model.updateCTBenefit();
                                }
                                return (inputtedMedical
                                            .contains(new RegExp(r'[A-Z]')) ||
                                        inputtedMedical
                                            .contains(new RegExp(r'[a-z]')) ||
                                        inputtedMedical == null)
                                    ? 'Only use numbers.'
                                    : null;
                              },
                              autovalidateMode: AutovalidateMode.always,
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
                                    widget.model.yourRentOrMortgage =
                                        double.parse(inputtedRent);
                                    widget.model.updateCTBenefit();
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
                                    widget.model.yourRentOrMortgage =
                                        double.parse(inputtedRent);
                                    widget.model.updateCTBenefit();
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
                                  widget.model.yourRentOrMortgage = 0;
                                  widget.model.updateCTBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
                            ),
                            Text(
                                '\nDo you have heating or cooling costs, or utility costs? (used to determine standard utility allowances\n'),
                            Column(
                              children: widget.choices2.map((item) {
                                //change index of choices array as you need
                                return RadioListTile(
                                  groupValue: widget
                                      .model.yourStandardUtilityAllowanceLevel,
                                  title: Text(item),
                                  value: item,
                                  activeColor: Colors.blue,
                                  onChanged: (val) {
                                    setState(() {
                                      widget.model
                                              .yourStandardUtilityAllowanceLevel =
                                          val;
                                      widget.model.updateCTBenefit();
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
                                    widget.model.yourOtherShelterCosts =
                                        double.parse(inputtedShelter);
                                    widget.model.updateCTBenefit();
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
                                    widget.model.yourOtherShelterCosts =
                                        double.parse(inputtedShelter);
                                    widget.model.updateCTBenefit();
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
                                  widget.model.yourOtherShelterCosts = 0;
                                  widget.model.updateCTBenefit();
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
                              autovalidateMode: AutovalidateMode.always,
                            ),
                            new RaisedButton(
                              child: const Text('Update Benefit'),
                              color: Theme.of(context).accentColor,
                              elevation: 4.0,
                              splashColor: Colors.amberAccent,
                              textColor: const Color(0xFFFFFFFF),
                              onPressed: () {
                                widget.model.updateCTBenefit();
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
                                      _buildAboutAdvancedCT(context),
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
              "Equation: Household Maximum - (income - deductions) x .3 \n\nFor more information, and a better estimate of your state's specific benefits process, click the plus button on the right to launch the advanced calculator.\n\nFor the calculation citations and more, look in the resource tab."),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: 'What is your household filing group?',
                  labelText: 'Number of dependents (not necessarily family)'),
              onChanged: (String numOfPeople) {
                if (!(numOfPeople.contains('@') ||
                    numOfPeople.contains('.') ||
                    numOfPeople.contains(new RegExp(r'[A-Z]')) ||
                    numOfPeople.contains(new RegExp(r'[a-z]')))) {
                  setState(() {
                    widget.model.yourHouseholdSize = int.parse(numOfPeople);
                    widget.model.updateMax();
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
              autovalidateMode: AutovalidateMode.always,
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
                    widget.model.monthlyIncome = (double.parse(inputtedIncome));
                    widget.model.updateBenefit();
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
              autovalidateMode: AutovalidateMode.always,
            ),
            new TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.arrow_downward),
                  border: InputBorder.none,
                  hintText:
                      'What is your estimated total deductions? Use the advanced tool if you\'re not sure. ',
                  labelText:
                      'Estimated total deduction (if you\'re not sure, and live in a supported state, click the + button and navigate to your state\' advanced guide.'),
              onChanged: (String inputtedDeduction) {
                setState(() {
                  widget.model.yourDeduction = double.parse(inputtedDeduction);
                  widget.model.updateBenefit();
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
              autovalidateMode: AutovalidateMode.always,
            ),
            new Text("Your max benefit: " + widget.model.yourMax.toString()),
            new Text("Your estimated benefit: " +
                widget.model.yourBenefit.toString()),
            new RaisedButton(
              child: const Text('Show Calculation Steps'),
              color: Theme.of(context).accentColor,
              elevation: 4.0,
              splashColor: Colors.amberAccent,
              textColor: const Color(0xFFFFFFFF),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildAboutDialog(context),
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
    );
  }
}
