import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => InputScreen(),
    },
  ));
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final amountController = TextEditingController();
  final termController = TextEditingController();
  final rateController = TextEditingController();

  void clearFields() {
    amountController.clear();
    termController.clear();
    rateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Calculator'),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Loan Amount (RM)'),
            ),

            TextField(
              controller: termController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Term (in years)'),
            ),

            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    clearFields();
                  },
                  child: Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    double amount = double.parse(amountController.text);
                    int term = int.parse(termController.text);
                    double rate = double.parse(rateController.text);

                    double monthlyPayment = calculateMonthlyPayment(amount, term, rate);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(term, monthlyPayment,amount),
                      ),
                    );
                  },
                  child: Text('Calculate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double calculateMonthlyPayment(double amount, int term, double rate) {
    // Calculation for monthly payment
    rate = rate / 1200;
    int n = term * 12;
    double monthlyPayment = (amount * rate) / (1 - pow(1 + rate, -n));
    return monthlyPayment;
  }
}

class ResultScreen extends StatelessWidget {
  final int years;
  final double monthlyPayment;
  final double amount;

  ResultScreen(this.years, this.monthlyPayment,this.amount);

  @override
  Widget build(BuildContext context) {
    int termYears = years;
    int totalPayments = termYears * 12;

    double loanAmount = amount;

    double totalInterest = (totalPayments * monthlyPayment) - loanAmount;

     double totalPaymentAmount = loanAmount + totalInterest;

    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(21.0),
              color: Colors.green,
              child: Text(
                'Monthly Payment: RM ${monthlyPayment.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You will need to pay RM ${monthlyPayment.toStringAsFixed(2)} every month for $termYears years to pay off the debt.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 201, 193, 193)), 
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Total Payment Times'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('$totalPayments'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Total Interest'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('RM ${totalInterest.toStringAsFixed(2)}'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 201, 193, 193)),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Total Payment'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('RM ${totalPaymentAmount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}