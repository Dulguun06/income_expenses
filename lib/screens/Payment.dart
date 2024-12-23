import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:income_expenses/screens/BottomNavBarScreen.dart';
import 'package:income_expenses/screens/user_provider.dart';
import 'package:provider/provider.dart'; // Add Firestore dependency

void main() => runApp(const Payment());

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<StatefulWidget> createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  bool isLightTheme = true;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final TextEditingController _chargeAmountController =
      TextEditingController(); // Charge Amount Controller
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
    return MaterialApp(
      title: 'Credit Card',
      debugShowCheckedModeBanner: false,
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.black, fontSize: 18),
        ),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.white,
          background: Colors.black,
          primary: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: border,
          enabledBorder: border,
        ),
      ),
      darkTheme: ThemeData(
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.white, fontSize: 18),
        ),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.black,
          background: Colors.white,
          primary: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.white),
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: border,
          enabledBorder: border,
        ),
      ),
      home: Scaffold(
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
            Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'Түрийвч цэнэглэх',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Image(image: AssetImage('images/jingle.png'))
                  ],
                ),
              ],
            ),
            Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.only(top: 100),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        CreditCardWidget(
                          enableFloatingCard: useFloatingAnimation,
                          glassmorphismConfig: _getGlassmorphismConfig(),
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          bankName: 'Khan Bank',
                          frontCardBorder: useGlassMorphism
                              ? null
                              : Border.all(color: Colors.grey),
                          backCardBorder: useGlassMorphism
                              ? null
                              : Border.all(color: Colors.grey),
                          showBackView: isCvvFocused,
                          obscureCardNumber: true,
                          obscureCardCvv: true,
                          isHolderNameVisible: true,
                          cardBgColor: isLightTheme
                              ? const Color(0xFF408782)
                              : const Color(0xFF408782),
                          backgroundImage:
                              useBackgroundImage ? 'images/card_bg.png' : null,
                          isSwipeGestureEnabled: true,
                          onCreditCardWidgetChange:
                              (CreditCardBrand creditCardBrand) {
                            // Properly handle the detected card brand
                          },
                          customCardTypeIcons: <CustomCardTypeIcon>[
                            CustomCardTypeIcon(
                              cardType: CardType.mastercard,
                              cardImage: Image.asset(
                                'images/mastercard.png',
                                height: 48,
                                width: 48,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                CreditCardForm(
                                  formKey: formKey,
                                  obscureCvv: true,
                                  obscureNumber: true,
                                  cardNumber: cardNumber,
                                  cvvCode: cvvCode,
                                  isHolderNameVisible: true,
                                  isCardNumberVisible: true,
                                  isExpiryDateVisible: true,
                                  cardHolderName: cardHolderName,
                                  expiryDate: expiryDate,
                                  inputConfiguration: InputConfiguration(
                                    cardNumberDecoration: _buildInputDecoration(
                                      label: 'Картын дугаар',
                                      hint: 'XXXX XXXX XXXX XXXX',
                                    ),
                                    expiryDateDecoration: _buildInputDecoration(
                                      label: 'Дуусах хугацаа',
                                      hint: 'MM/YY',
                                    ),
                                    cvvCodeDecoration: _buildInputDecoration(
                                      label: 'CVV',
                                      hint: 'XXX',
                                    ),
                                    cardHolderDecoration: _buildInputDecoration(
                                      label: 'Карт дээрх нэр',
                                    ),
                                  ),
                                  onCreditCardModelChange:
                                      onCreditCardModelChange,
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextFormField(
                                    controller: _chargeAmountController,
                                    keyboardType: TextInputType.number,
                                    decoration: _buildInputDecoration(
                                      label: 'Цэнэглэх дүн',
                                      hint: '0.00',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Дүн оруулна уу';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'Буруу дүн';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () => _onValidate(userProvider.uid),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFFFFF),
                                      border: Border.all(
                                        color: const Color(0xFF408782),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Цэнэглэх',
                                      style: TextStyle(
                                        color: Color(0xff408782),
                                        fontFamily: 'halter',
                                        fontSize: 14,
                                        package: 'flutter_credit_card',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onValidate(String userID) async {
    if (formKey.currentState?.validate() ?? false) {
      double chargeAmount = double.parse(_chargeAmountController.text);

      await FirebaseFirestore.instance.collection('transactionHistory').add({
        'isIncome': true,
        'uid': userID,
        'amount': chargeAmount,
        'transactionDate': DateTime.now(),
      });
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
        'balance': FieldValue.increment(chargeAmount),
      });

      _showSuccessDialog(context);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
        );
      });
    } else {
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Амжилттай'),
          content: const Text('Таны цэнэглэлт амжилттай боллоо.'),
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

  Glassmorphism? _getGlassmorphismConfig() {
    if (!useGlassMorphism) return null;

    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
      stops: const <double>[0.3, 0],
    );

    return Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient);
  }

  InputDecoration _buildInputDecoration({required String label, String? hint}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFF408782),
          width: 2.0,
        ),
      ),
      labelText: label,
      hintText: hint,
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel?.cardNumber ?? '';
      expiryDate = creditCardModel?.expiryDate ?? '';
      cardHolderName = creditCardModel?.cardHolderName ?? '';
      cvvCode = creditCardModel?.cvvCode ?? '';
      isCvvFocused = creditCardModel?.isCvvFocused ?? false;
    });
  }
}
