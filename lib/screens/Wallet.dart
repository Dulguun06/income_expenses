import 'package:flutter/material.dart';
import 'package:income_expenses/screens/user_provider.dart';
import 'package:provider/provider.dart';
class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  List<bool> isSelected = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Image(
              image: AssetImage('images/hangingBackground.png'),
            ),
            Image(
              image: AssetImage('images/Group 6.png'),
            ),
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Text(
                      'Түрийвч',
                      style: TextStyle(color: Colors.white),
                    ),
                    Image(image: AssetImage('images/jingle.png'))
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                       Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Нийт үлдэгдэл',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '\$${userProvider.balance.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff408782),
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Color(0xff408782),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff408782),
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                icon: Icon(
                                  Icons.qr_code,
                                  color: Color(0xff408782),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff408782),
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Color(0xff408782),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Container(
                          
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 55,
                            color:Color(0xFFF4F6F6),
                            child: TabBar(
                            controller: tabController,
                            isScrollable: true,
                            tabs: [
                              Tab(
                                text: 'Гүйлгээнүүд',
                              ),
                              Tab(
                                text: 'Хүлээгдэж буй гүйлгээнүүд',
                              ),
                            ],
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xFFFFFFFF)),
                                labelColor: Color(0xFF666666),
                          ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (contex, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                image:
                                                    AssetImage('images/up.png'),
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Upwork'),
                                                  Text('Өнөөдөр')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '+ \$850.00',
                                                style: TextStyle(
                                                    color: Color(0xff25A969)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'images/Frame 9.png'),
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Шилжүүлэг'),
                                                  Text('Өчигдөр')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '- \$85.00',
                                                style: TextStyle(
                                                    color: Color(0xffF95B51)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'images/paypal.png'),
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Paypal'),
                                                  Text('Jan 30, 2022')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '+ \$1406.00',
                                                style: TextStyle(
                                                    color: Color(0xff25A969)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'images/ytube.png'),
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Youtube'),
                                                  Text('Jan 16, 2022')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '- \$11.99',
                                                style: TextStyle(
                                                    color: Color(0xffF95B51)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            //123456543

                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (contex, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'images/ytube.png'),
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Youtube'),
                                                  Text('Feb 28, 2022')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //     MaterialPageRoute(
                                                  //         builder: (_) =>
                                                  //             const PaymentScreen()));
                                                },
                                                child: Text('Төлөх'),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'images/Frame 9-5.png'),
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Electricity'),
                                                  Text('Mar 28, 2022')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                child: Text('Төлөх'),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'images/Frame 9-6.png'),
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('House Rent'),
                                                  Text('Mar 31, 2022')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                child: Text('Төлөх'),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'images/Frame 9-7.png'),
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Spotify'),
                                                  Text('Feb 26, 2022')
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                child: Text('Төлөх'),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
