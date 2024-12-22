import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:income_expenses/screens/TransactionHistoryWidget.dart';
import 'package:income_expenses/screens/user_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "Хэрэглэгч";
  double balance = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
        DocumentSnapshot doc = await userRef.get();
        if (doc.exists) {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.setUserName(doc['userName'] ?? "Хэрэглэгч");
          userProvider.setUserID(doc['uid'] ?? "");
          userProvider.setBalance((doc['balance'] ?? 0).toDouble());
          fetchTransaction(currentUser.uid);
        } else {
          print("No user data found for UID: ${currentUser.uid}");
        }
      } else {
        print("No authenticated user found.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchTransaction(String userID) async {
    print("user" + userID);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      QuerySnapshot transactionSnapshot = await FirebaseFirestore.instance
          .collection('transactionHistory')
          .where("uid", isEqualTo: userID)
          .get();

      double income = 0.0;
      double expense = 0.0;

      for (QueryDocumentSnapshot doc in transactionSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        double amount = (data['amount'] ?? 0.0).toDouble();
        bool isIncome = data['isIncome'] ?? false;

        if (isIncome) {
          income += amount;
        } else {
          expense += amount;
        }
      }

      // Update the provider
      userProvider.setIncome(income);
      userProvider.setExpense(expense);
    } catch (e) {
      print("Error fetching transactions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: 0,
            child: Image.asset(
              'images/hangingBackground.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            child: Image.asset(
              'images/Group 6.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: RefreshIndicator(
              onRefresh: fetchData,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Өглөөний мэнд?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              userProvider.userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const Image(
                          image: AssetImage('images/jingle.png'),
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      color: const Color(0xff2F7E79),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Нийт үлдэгдэл',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$${userProvider.balance.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.arrow_upward,
                                              color: Colors.white),
                                          Text("Орлого",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Text(
                                          "\$${userProvider.income.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.arrow_downward,
                                              color: Colors.white),
                                          Text("Зарлага",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Text(
                                        "\$${userProvider.expense.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TransactionHistoryWidget(userID: userProvider.uid),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
