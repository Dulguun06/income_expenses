import 'package:flutter/material.dart';
import 'package:income_expenses/screens/Payment.dart';
import 'package:income_expenses/screens/PendingTransactionsList.dart';
import 'package:income_expenses/screens/TransactionHistoryWidget.dart';
import 'package:income_expenses/screens/user_provider.dart';
import 'package:provider/provider.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  // bool isLoading = false;
  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  // Future<void> fetchData() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background images with positioned widgets to prevent overlap
          Positioned(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/hangingBackground.png',
            ),
          ),
          Positioned(
            top: 0,
            child: Image.asset(
              'images/Group 6.png',
              fit: BoxFit.fill,
            ),
          ),
          // Main column layout for Wallet content
          Column(
            children: [
              SizedBox(height: 50), // Padding from the top
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Түрийвч',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    // Total balance section
                    SizedBox(height: 20),
                    Text(
                      'Нийт үлдэгдэл',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${userProvider.balance.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    // Buttons for Payment, QR, and Send actions
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildIconButton(Icons.add, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Payment()),
                            );
                          }),
                          buildIconButton(Icons.qr_code, () {}),
                          buildIconButton(Icons.send, () {}),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // TabBar for Transaction tabs
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F6F6),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TabBar(
                        controller: tabController,
                        isScrollable: true,
                        tabs: [
                          Tab(text: 'Гүйлгээнүүд'),
                          Tab(text: 'Хүлээгдэж буй гүйлгээнүүд'),
                        ],
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFFFFFFF),
                        ),
                        labelColor: Color(0xFF666666),
                      ),
                    ),
                    // TabBarView for Transaction details
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          // Transaction History Tab
                          TransactionHistoryWidget(userID: userProvider.uid),
                          // Pending Transactions Tab
                          PendingTransactionsList(userID: userProvider.uid),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff408782)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Color(0xff408782),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
