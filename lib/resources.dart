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
                    """If you have any questions or concerns at all about anything, please don't hesitate to contact us at one of these places:\n\nEmail: snappestimatorapp@gmail.com\nPhone: (516) 268-1933 """),
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
                  """We don’t make any guarantees to the accuracy of this information. We try and will continue to try our best to keep it updated and on par with policies-- but they change and we aren’t always the fastest. To be real, we’re just some broke kids who have no idea whether or not any of the disclaimers in this app are legit or will ever protect us from everything, we just want to make an app that might help a few people. Don’t sue us please and if you have any problems with anything here, come to us first and we’ll be really understanding. 

Thanks and stay safe! """),
            ],
          )
        ],
      ),
    );
  }
}
