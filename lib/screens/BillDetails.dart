import 'package:flutter/material.dart';

class BillDetails extends StatefulWidget {
  final Map<String, dynamic> transaction;

  const BillDetails({super.key, required this.transaction});

  @override
  State<BillDetails> createState() => _BillDetailsState();
}

int? _selectedValue = null;

class _BillDetailsState extends State<BillDetails> {
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
                    // Display the name of the transaction (e.g., "Youtube")
                    Text(
                      '${widget.transaction['name']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(height: 4),
                    // Display the balance from the transaction or other details
                    Text(
                      'Date: ${widget.transaction['date'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
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
                    Text("Төлбөрийн хэрэгсэлээ сонго",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _selectedValue == 1
                                ? Color(0xffECF9F8)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Radio<int>(
                              value: 1,
                              groupValue: _selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },
                              activeColor: Color(0xff03E7C78),
                            ),
                            title: Text(
                              'Дебит карт',
                              style: TextStyle(color: Color(0xff03E7C78)),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: _selectedValue == 2
                                ? Color(0xffECF9F8)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Radio<int>(
                              value: 2,
                              groupValue: _selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },
                              activeColor: Color(0xff03E7C78),
                            ),
                            title: Text(
                              'Paypal',
                              style: TextStyle(color: Color(0xff03E7C78)),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Color(0xFF3E7C78),
                      ),
                      child: Text(
                        'Төлөх',
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
