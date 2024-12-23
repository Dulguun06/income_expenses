import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:income_expenses/screens/VerifyPayment.dart';

class BillPayment extends StatefulWidget {
  final Map<String, dynamic> transaction;

  const BillPayment({super.key, required this.transaction});

  @override
  State<BillPayment> createState() => _BillPaymentState();
}

int? _selectedValue = null;

class _BillPaymentState extends State<BillPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background images with positioned widgets to prevent overlap
          const Image(
            image: AssetImage('images/hangingBackground.png'),
          ),
          const Image(
            image: AssetImage('images/Group 6.png'),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Төлбөрийн мэдээлэл',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "You will pay ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: "${widget.transaction['name']}",
                              style: TextStyle(
                                color: Color(0xff3E7C78),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " for one month with BCA OneKlik",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Display other transaction details like date and note
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Үнэ',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  '\$${(widget.transaction['amount'] * 0.85).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ]),
                          SizedBox(height: 8),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Хураамж',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  '\$${(widget.transaction['amount'] * 0.15).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Нийт',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  '\$${widget.transaction['amount'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection(
                                'payment') // Replace with your actual collection name
                            .doc(widget.transaction[
                                'docID']) // Document ID from widget.transaction
                            .update({'state': false});
                        await FirebaseFirestore.instance
                            .collection('transactionHistory')
                            .add({
                          'amount': widget.transaction['amount'],
                          'uid': widget.transaction['uid'],
                          'transactionDate': DateTime.now(),
                          'isIncome': false,
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.transaction['uid'])
                            .update({
                          'balance': FieldValue.increment(
                              widget.transaction['amount']*(-1)),
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyPayment(
                                    transaction: widget.transaction)));
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Color(0xFF3E7C78),
                      ),
                      child: Text(
                        'Баталгаажуулах',
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
}
