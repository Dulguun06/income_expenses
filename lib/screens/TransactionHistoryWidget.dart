import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionHistoryWidget extends StatelessWidget {
  final String userID; 
  const TransactionHistoryWidget({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('transactionHistory')
          .where('uid', isEqualTo: userID)
          .orderBy('transactionDate', descending: true) 
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading transactions'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No transactions found.'));
        } else {
          var transactions = snapshot.data!.docs;
          return SingleChildScrollView(  // Ensure entire area is scrollable
            child: Column(
              children: [

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), 
                  shrinkWrap: true, // Allow ListView to shrink and fit inside the parent
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    var transaction = transactions[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: ListTile(
                        title: Text('Дүн: ${transaction['amount']}'),
                        subtitle: Text('Огноо: ${transaction['transactionDate'].toDate()}'),
                        trailing: transaction['isIncome']
                            ? const Icon(Icons.arrow_upward, color: Colors.green)
                            : const Icon(Icons.arrow_downward, color: Colors.red),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
