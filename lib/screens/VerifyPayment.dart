import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VerifyPayment extends StatefulWidget {
  final Map<String, dynamic> transaction;

  const VerifyPayment({super.key, required this.transaction});

  @override
  State<VerifyPayment> createState() => _VerifyPaymentState();
}

int? _selectedValue = null;
bool isExpanded = false;

class _VerifyPaymentState extends State<VerifyPayment> {
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
                        child: Text(
                          "Амжилттай Төлөгдлөө",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff3E7C78)),
                          textAlign: TextAlign.center,
                        )),
                    Text("${widget.transaction['name']}"),
                    SizedBox(height: 20),
                    // Display other transaction details like date and note
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded =
                                    !isExpanded; // Toggle the expanded state
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Гүйлгээний Дэлгэрэнгүй', // This is the "Expand" button
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: isExpanded
                                ? 80.0
                                : 0.0, // Adjust the height based on the expansion state
                            child: isExpanded
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Төлөв"),
                                            Text("Хийгдсэн",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff3E7C78)))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Огноо"),
                                            Text(
                                                "${widget.transaction['date']}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Гүйлгээний Дугаар"),
                                            Text(
                                                "${widget.transaction['docID']}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                      ],
                                    ))
                                : Container(), // Empty container when collapsed
                          ),
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
                    QrImageView(
                        data:
                            "https://youtu.be/dQw4w9WgXcQ?si=7xNFcsQuXOjIP5bX",
                        version: QrVersions.auto,
                        size: 200),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: Color(0xff3E7C78), // Set border color here
                            width: 2.0, // Set border width
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Нүүр',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff3E7C78)),
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
