import 'package:flutter/material.dart';


class BankAppConstant {

  static int cardLength = cardNumber.length;

  static List<String> cardNumber = [
    "2546     8756     9621     5462",
    "5646     2147     9641     3641",
    "7854     2453     7864     3145",
  ];

  static List<String> budget = [
    "25,614",
    "5,964",
    "100,000",
  ];

  static List<String> cardHolder = [
    "John Doe",
    "Jane Doe",
    "Jennifer Swan",
  ];

  static List<String> cvc = [
    "342",
    "116",
    "645",
  ];

  static List<String> expiresDate = [
    "04/21",
    "06/23",
    "08/22",
  ];

  static List<String> transactionTitle = [
    "Entertainment",
    "Shopping",
    "Gym",
    "Food-Drinks",
    "Communicating",
    "Grocery",
    "Snacks",
    "Game",
  ];

  static List<String> transactionImages = [
    "entertainment",
    "shopping",
    "gym",
    "food",
    "communication",
    "grocery",
    "snacks",
    "game",
  ];

  static List<int> transactionDescription = [
    12,
    8,
    2,
    24,
    5,
    3,
    15,
    1,
  ];

  static List<double> transactionExpenditure = [
    224.99,
    517.5,
    300.0,
    825.34,
    120.6,
    89.20,
    174.3,
    75.0
  ];

  static final TextStyle bigStyle = TextStyle(
      fontSize: 25,
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontFamily: "Mulish");

  static final TextStyle lowerStyle = TextStyle(
      fontSize: 12,
      color: const Color(0xff62688e),
      fontWeight: FontWeight.bold,
      fontFamily: "Mulish");

  static final List<String> cardImages = ["assets/cards/card1.svg", "assets/cards/card2.svg", "assets/cards/card3.svg"];
  static final List<String> bottomCardImages = ["assets/cards/bottom_card1.svg", "assets/cards/bottom_card2.svg", "assets/cards/bottom_card3.svg"];
}