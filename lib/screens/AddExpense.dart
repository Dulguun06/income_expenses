import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:income_expenses/screens/BottomNavBarScreen.dart';
import 'package:income_expenses/screens/user_provider.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _submitData(String userID) async {
    if (_formKey.currentState!.validate()) {
      try {
        DocumentReference docRef =await FirebaseFirestore.instance.collection('payment').add({
          'name': _nameController.text,
          'amount': double.parse(_amountController.text),
          'date': _dateController.text,
          'note': _noteController.text,
          'uid': userID,
          'state': true,
          'docID':""
        });
        await docRef.update({
        'docID': docRef.id,
      });
        _showSuccessDialog(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
        );
      } catch (e) {
        print("Error adding data to Firestore: $e");
      }
    }
  }
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Амжилттай'),
          content: const Text('Төлбөр амжилттай үүслээ.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final userProvider =
              Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Image(
            image: AssetImage('images/hangingBackground.png'),
          ),
          const Image(
            image: AssetImage('images/Group 6.png'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
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
                      'Зарлага нэмэх',
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            _buildTextField(
                              label: 'Гүйлгээний утга',
                              controller: _nameController,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              label: 'Үнийн дүн',
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: _selectDate,
                              child: AbsorbPointer(
                                child: _buildTextField(
                                  label: 'Огноо',
                                  controller: _dateController,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: GestureDetector(
                                onTap: () => _submitData(userProvider.uid),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xFF438883),
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Төлбөр нэмэх',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF438883),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label оруулна уу.';
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF438883)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
