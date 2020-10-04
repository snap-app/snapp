import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class Resources extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ResourcesState();
  }
}

class ResourcesState extends State<Resources> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: /*<Widget>[Column(children:*/ <Widget>[
          Flexible(
            child: ExpansionTile(
              title: Column(children: <Widget>[Text('Contact:')]),
              children: <Widget>[
                Text(
                    """Disclaimer: we're not experts or anything, we're just some kids with a lot of time on our hands and a bit of research. \n But if you have any questions or concerns at all about anything, please don't hesitate to contact us at one of these places:\n\nEmail: snappestimatorapp@gmail.com\nPhone: (516) 268-1933  """),
              ],
            ),
          ),
          Flexible(
            child: ExpansionTile(
              title:
              Column(children: <Widget>[Text('Additional Resources:')]),
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
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                    
                    Benefits Plus Learning Center: https://bplc.cssny.org/

Home Energy Assistance Program (HEAP)  myBenefits (ny.gov): https://mybenefits.ny.gov/mybenefits/begin


Help with managing benefits and budgeting:
Meal Planning, Shopping, and Budgeting | SNAP-Ed (usda.gov): https://snaped.fns.usda.gov/nutrition-education/nutrition-education-materials/meal-planning-shopping-and-budgeting

What Can SNAP Buy? | USDA-FNS:
 https://www.fns.usda.gov/snap/eligible-food-items

Fresh EBT | Food Stamp Balance App for Android and iPhone (freshebt.com): 
https://www.freshebt.com/ 

Benefits Plus Learning Center - SNAP Calculator (cssny.org)
https://bplc.cssny.org/benefit_tools/snap_calculator
""")
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
    
    SNAP: State by State Data, Fact Sheets, and Resources | Center on Budget and Policy Priorities (cbpp.org) Contains information about other eligibility factors our estimator doesn't take into account, like asset limits and the gross income test. 
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
              Text(
                  "The SNAPP Benefits Calculator should be used for screening purposes only. \n\nThe laws, regulations, rules and policies the calculator is based on are subject to change. \n\nWe make no representations or warranties, express or implied, as to the accuracy of the projected results. \n\nWe are not liable for any decision made or action taken by anyone in reliance upon the information obtained from this calculator. \n\nThe calculator is not endorsed by the public entities that administer the SNAP program and individuals who want to apply for SNAP benefits should submit an application to the government agency where official determinations are made. \n\nIf you are unsure about eligibility, don't hesitate to receive an official determination. There are many deductions and ways to calculate them, and you may be eligible for other benefits."),
              Text(
                  """\nWe don’t make any guarantees to the accuracy of this information. We aren't paid or experts, we're just some kids with some time and some research doing a project. We try and will continue to try our best to keep it updated and on par with policies-- but they change and we aren’t always the fastest. To be real, we’re just some broke kids who have no idea whether or not any of the disclaimers in this app are legit or will ever protect us from everything, we just want to make an app that might help a few people. Don’t sue us please and if you have any problems with anything here, come to us first and we’ll be really understanding. 

Thanks and stay safe! """),
            ],
          ),
          ExpansionTile(
            title: Column(children: <Widget>[Text('r/foodstamps FAQ')]),
            children: <Widget>[
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
This is a bunch of parts ported entirely from the r/foodstamps wiki here: https://www.reddit.com/r/foodstamps/wiki/faq. 

We're not affiliated with r/foodstamps, but we've proofread it and think it's a really good writeup and we don't have enough experience with the program to possibly do it as well as u/thesongofstorms and the rest of the r/foodstamps team, so we've pasted it here

(Also we're not sure if we're allowed to link it here so please tell us if you want to take it off):
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
    text: "I’ve been contacted by my state’s agency about an overpayment/fraud investigation. What do I do/what can I expect? Am I going to jail? Should I just close everything? Are my kids going to get taken away?\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """\n
Take a deep breath, and try to relax, first. This process can be scary and unnerving, and your feelings are valid. Here are some things to keep in mind as things unfold:

1) - The chance that this is going to end with criminal charges is minor.
Seriously. Agency rules that govern how the SNAP program are set up, intentionally, to handle overpayment of benefits . Overpayments happen despite agencies working very hard to make sure that your benefits are accurate, but they do happen. Whether it’s a worker error, your error, or something you or your household did intentionally will shape what the process looks like from this point forward. Criminal referrals are rare, and with good reason - the courts are full of criminal matters that are (most of the time) far more serious than punishing someone struggling with poverty for poor decision making. Unless you’re involved in benefit trafficking (like selling your benefits for guns or drugs), or have lied to get thousands of dollars in benefits over many years, it’s unlikely it will go to court. However, the chance of criminal charges IS NOT 0%, so do take it seriously and respond accordingly.

2) - Most overpayments result from a simple error in how eligibility was determined, and nothing \"illegal\" has actually occurred.
Whether you forgot to report something you should have, the worker incorrectly read or entered paystubs, or another mistake, most of the time if you’re overpaid, it’s because something that was supposed to get processed, wasn’t. This isn’t necessarily a reflection on you. Presumably, you’re receiving assistance because you need the help, so don’t panic and ask your local office to just close everything - doing that won’t affect the outcome, and will probably only result in inconvenience for you. You may actually benefit from keeping your case open since the repayment can be taken out of your ongoing benefits. See below:

3) - Repayment of an overpayment is typically garnished out of your ongoing benefits.
You can still be eligible and receive help while you’re paying back benefits you received that you weren’t supposed to. Generally, the amount is about 10% of your new total monthly amount, so, if you would otherwise get \$300 a month, then you’d actually receive \$270 with the other \$30 going towards the overpayment.

4) - You should any overpayment recoupments seriously: keep your records together, and review and understand your rights. NEVER sign a document that you do not understand.
It is the office's responsibility to demonstrate that you were overpaid, and the evidence that you purposefully committed fraud must be "clear and convincing". The fraud investigator may call you or invite you to the office for a conversation, but it's up to your discretion whether you want to respond. If they give you a Waiver of Administrative Disqualification Hearing to sign, DO NOT SIGN IT unless you are guilty and want to abandon your right to hearing. If you are innocent, and want to go before a hearing official to defend yourself, then do not sign this document, and instead prepare to go to a formal review hearing. The fraud investigator should not illegally pressure or coerce you to sign this document.

You have the absolute right (within the rules and appropriate time frame) to insist upon a hearing for any decision the Agency makes that affects you. You have the right to insist that they explain their decisions to you and show you how they make any determination about your status. Those rights exist for good reason as they are there to protect you. Making use of your rights is not only appropriate, it is the right and legal thing to do to protect both yourself and the next person in a similar situation.

5) - Overpayment determination is not by itself a factor in involving your state’s Childrens’ Services or its equivalent.
Even if you have defrauded the program intentionally, you are not by extension an unfit parent/guardian. That being said, you are almost certainly going to be visited in your home by fraud investigators or case workers, or both. While they aren’t actively looking for evidence of neglect, the truth is that they’re mandatory reporters and cannot ignore what they do see.

If Child Services gets involved, it will not be because of the overpayment/fraud situation. Instead, it will be because there was a report made that the state is legally and morally required to investigate.

6) - Regardless of what has happened or what you are accused of, you have the right to be treated respectfully and professionally.
This should be self-explanatory. If you feel you’re being mistreated, you have the right to complain about your treatment to office leadership or even to the federal government. There is no ethical reason for abusive or harsh treatment at the hands of government representatives, and you can and should report unethical behavior.
"""
    ),
    new TextSpan(
    text: "\nI can’t get hold of anyone, and I’ve been trying for ____ days/weeks. What do I do?\n\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """
Your specific state should have its own escalation process. Document your attempts and try different ways of contacting your local office. If you’re not getting a response by phone, contact the branch office online, by fax, or go in. If that doesn’t work, you can escalate by calling their administrative/district office. You can also contact the regional office of the federal Food and Nutrition Service for help.

As a last resort, you can contact your federal Representative or Senators. Generally, you’ll find that members of Congress are eager to make some inquiries on behalf of a constituent, but please use this option with caution and for things that are truly important, however, and not for minor issues, or you may burn this bridge for the future.
""",
    ),
    new TextSpan(
    text: "\nMy agency asked me for proof of _____, which I don’t have/can’t get. What do I do?\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """

You need to make a good faith effort, and if you are truly unable to obtain the verification needed, a written and signed statement from you attesting to whatever it is you’ve been asked for can often suffice. You may be surprised and how flexible the office can be.
""",
    ),
    new TextSpan(
    text: "\nI think I make way too much money to qualify. Should I apply?\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """

You may be surprised about how much income you can have before being ineligible for assistance through the food stamp/SNAP program. You may also be surprised about what other help may be available in your area. The office can also help connect you with resources and determine what other help you’re eligible for. The worst case scenario is you are denied benefits, and nothing changes.
""",
    ),
    new TextSpan(
    text: "\nI applied and got only \$___. Is this right?\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """

Determination of your benefit amount is complex. A very superficial look at the process is:

The number of eligible people in your household.

Your countable income from jobs and other sources. Some forms of income are not countable (Pell grants, earnings from children under 18, and a few others).

In some states or situations, your assets/resources (like a car or bank account) might be counted. In most states, they are not.

Deductions like your rental cost, utilities (depending on which ones you pay), child support paid out, or medical expenses if you’re elderly or disabled may increase your overall benefit amount.

Knowing which things count for what is why people that determine eligibility have to have training. Chances are, what you were issued is probably correct since so much of the calculation is automated, but you are always welcome to request that the office explain how the determination was made.

""",
    ),
    new TextSpan(
    text: "\nBut I got \$16, \$10, or even \$0!\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """

\$16 is the minimum benefit amount for a household of 1 or 2 people. It is possible to be eligible and get less than that or even \$0 issued to you. It is the result of applying rules for categorical eligibility, which the mods can explain, or having an overpayment garnishing your monthly benefit.
""",
    ),
    new TextSpan(
    text: "\nThere was a change in my household! Do I need to report it?\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """

Possibly. Every different assistance program has different reporting requirements, which can be simultaneous. It can be aggravating and complicated.

For food stamps, you should always review your reporting requirements on your notices you receive from the office. Every single state except Maine require that households report mid-certification (before your renewal paperwork is due) in the following circumstances:

1) Your income goes above a certain threshold (130% federal poverty for your household size)

2) Your weekly work hours go below 20 hours if you're an Able-Bodied Adult Without Dependents

3) You have significant, unanticipated gambling/lottery winnings

It's important not to "guess" what you should report if you are uncertain. You are always free to call your office and ask them, hypothetically, what should be reported. Some household changes, like a new member, or a loss of income, may increase your benefit mid-certification and should be reported immediately.

""",
    ),
    new TextSpan(
    text: "I want to apply, but I’m pretty sure I won’t be eligible because of ____. I was told that I shouldn’t tell the office about it, so that I can get be eligible.",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """
This is called “fraud”, and is not only a program violation, but it’s illegal and wrong. All fraud or deliberate misreporting is discouraged as it harms the integrity of the program and may make you liable for overpayment claims or criminal charges.
""",
    ),
    new TextSpan(
    text: "\nBut the office will never know, right?\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """

The penalties for withholding information from the determining agency can be pretty harsh, including lifetime disqualification or criminal charges. Most agencies have a lot of fraud prevention tools at their disposal, including data-matching process to catch things like withholding information about income. Chances are you will get caught eventually.
""",
    ),
    new TextSpan(
    text: "\nDoes _______ income count? I don't think I should have to report that/I was told it's not income.\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """

You should report all income, even if you're unsure. There are very, very few forms of incoming money or in-kind support that are non-countable, and in every single example, you need to declare that income and let your local agency figure out what counts and what doesn't. That's their job.
""",
    ),
    new TextSpan(
    text: "\nWhat is P-EBT SNAP and how do I get it? Am I eligible for it?\n",
    style: new TextStyle(fontWeight: FontWeight.bold)),
    new TextSpan(
    text: """

This is a pandemic-related program similar to the summer lunch program or other similar partnerships. States opt-in to this, and it's something that each state has their own process for. Answers for one state will be different than another state. It is best to get those answers directly from your local agency: if you need help contacting them, we have quite a few helpers here with who can help you find contact information.""",
    ),
    ],
    ),
    ),
            ],
          )
        ],
      ),
    );
  }
}
