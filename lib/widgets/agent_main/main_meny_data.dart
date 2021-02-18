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
      color: Color(0xFF9C27B0),
      nextPage: YourObjectsScreen.routeName),
  MainMeny(
      id: 'c3',
      title: 'Add Property',
      color: Color(0xFF6A1B9A),
      nextPage: AddObjectScreen.routeName),
  MainMeny(
      id: 'c2',
      title: 'Your customers',
      color: Color(0xFFFF8F00),
      nextPage: YourCusromerScreen.routeName),

  MainMeny(
      id: 'c4',
      title: 'Add Customer',
      color: Color(0xFFFF6F00),
      nextPage: AddCustomerScreen.routeName),
  MainMeny(
      id: 'c5',
      title: 'Your Co-Agents',
      color: Color(0xFF03A9F4),
      nextPage: CategoryMealsScreen.routeName),
  MainMeny(
      id: 'c6',
      title: 'Add Co-Agents',
      color: Color(0xFF00BCD4),
      nextPage: CategoryMealsScreen.routeName),
  MainMeny(
      id: 'c6',
      title: 'Reports',
      color: Color(0xFFc62828),
      nextPage: CategoryMealsScreen.routeName),
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
