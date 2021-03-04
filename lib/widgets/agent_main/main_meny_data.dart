import 'package:flutter/material.dart';
import 'package:evnet_agents/screens/object/add_objects_screen.dart';
import '../../models/mainMeny.dart';
import '../../screens/category_meals_screen.dart';
import '../../screens/customer/add_customer_screen.dart';
import '../../screens/customer/your_customers_screen.dart';
import 'package:evnet_agents/screens/object/your_objects_screen.dart';

// import './models/meal.dart';

const MAIN_MENY_DATA = const [
  MainMeny(
    id: 'c1',
    title: 'Your Properties',
    color: Color(0xFF18873D),
    nextPage: YourObjectsScreen.routeName,
    imagePath: 'assets/images/mainMeny/y-prop.png',
  ),
  MainMeny(
    id: 'c3',
    title: 'Add Property',
    color: Color(0xFF18873D),
    nextPage: AddObjectScreen.routeName,
    imagePath: 'assets/images/mainMeny/add-prop.png',
  ),
  MainMeny(
    id: 'c2',
    title: 'Your customers',
    color: Color(0xFF18873D),
    nextPage: YourCusromerScreen.routeName,
    imagePath: 'assets/images/mainMeny/y-cust.png',
  ),

  MainMeny(
    id: 'c4',
    title: 'Add Customer',
    color: Color(0xFF18873D),
    nextPage: AddCustomerScreen.routeName,
    imagePath: 'assets/images/mainMeny/add-cust.png',
  ),
  MainMeny(
    id: 'c5',
    title: 'Your Co-Agents',
    color: Color(0xFF18873D),
    nextPage: CategoryMealsScreen.routeName,
    imagePath: 'assets/images/mainMeny/y-co-ag.png',
  ),
  MainMeny(
    id: 'c6',
    title: 'Add Co-Agents',
    color: Color(0xFF18873D),
    nextPage: CategoryMealsScreen.routeName,
    imagePath: 'assets/images/mainMeny/add-co-ag.png',
  ),
  MainMeny(
    id: 'c7',
    title: 'Reports',
    color: Color(0xFF18873D),
    nextPage: CategoryMealsScreen.routeName,
    imagePath: 'assets/images/mainMeny/report.png',
  ),

  // MainMeny(
  //     id: 'c8',
  //     title: 'Reports',
  //     color: Color(0xFF18873D),
  //     nextPage: CategoryMealsScreen.routeName,
  //     imagePath: 'assets/images/mainMeny/add-prop.png'),
  // MainMeny(
  //   id: 'c7',
  //   title: 'Breakfast',
  //   color: Colors.lightBlue,
  // ),
  // MainMeny(
  //   id: 'c8',
  //   title: 'Asian',
  //   color: Colors.lightGreen,
  // ),
  // MainMeny(
  //   id: 'c9',
  //   title: 'French',
  //   color: Colors.pink,
  // ),
  // MainMeny(
  //   id: 'c10',
  //   title: 'Summer',
  //   color: Colors.teal,
  // ),
];
