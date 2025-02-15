import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  int _tipPercentage = 0;
  int _noOfPersons = 1;
  double _billAmount = 0;

  @override
  Widget build(BuildContext context) {
    // Compute the tip (service charge) and the total per person.
    final double tip = calculateServiceCharge(_billAmount, _tipPercentage);
    final double totalPerPerson = (_billAmount + tip) / _noOfPersons;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // Display the total per person
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              width: 100.0,
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: BorderRadius.circular(20.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bill Amount",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    totalPerPerson.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Input and controls container
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.lightBlue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.blue.shade300,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  // Bill Amount Input
                  TextField(
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.monetization_on_rounded,
                        color: Colors.blue,
                      ),
                      labelText: "Bill Amount",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20.0,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (String value) {
                      setState(() {
                        try {
                          _billAmount = double.parse(value);
                        } catch (exception) {
                          _billAmount = 0.0;
                        }
                      });
                    },
                  ),
                  // Number of Persons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Number of Persons",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          // Decrement
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_noOfPersons > 1) {
                                  _noOfPersons--;
                                }
                              });
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Text(
                            "$_noOfPersons",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          // Increment
                          InkWell(
                            onTap: () {
                              setState(() {
                                _noOfPersons++;
                              });
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  // Display Service Charge (Tip)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Service Charge",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Text(
                        tip.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  // Tip Percentage Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tip: $_tipPercentage%",
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Slider(
                        value: _tipPercentage.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue.shade200,
                        label: "$_tipPercentage",
                        onChanged: (double newVal) {
                          setState(() {
                            _tipPercentage = newVal.round();
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the service charge (tip) based on the bill amount and tip percentage.
  double calculateServiceCharge(double bill, int percentage) {
    if (bill <= 0) return 0.0;
    return bill * percentage / 100;
  }
}
