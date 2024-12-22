import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:income_expenses/screens/BillDetails.dart';

class PendingTransactionsList extends StatelessWidget {
  final String userID;
  const PendingTransactionsList({Key? key, required this.userID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('payment')
          .where('uid', isEqualTo: userID)
          .where('state', isEqualTo: true)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Хүлээгдэж буй гүйлгээ алга.'));
        }
        var transactions = snapshot.data!.docs;

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            var transaction =
                transactions[index].data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Row(
                  children: [
                    SizedBox(width: 9),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction['name'] ??
                            'No name'),
                        Text(transaction['date'] ??
                            'No date'), 
                      ],
                    ),
                  ],
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffECF9F8)
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillDetails(
                            transaction:
                                transaction),
                      ),
                    );
                  },
                  child: Text('Төлөх', style: TextStyle(color: Color(0xff03E7C78)),),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
