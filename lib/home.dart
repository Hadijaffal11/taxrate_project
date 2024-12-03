import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _salaryController = TextEditingController();

  double? salary;
  double? taxableIncome;
  double? taxRate;
  double? taxDeducted;
  double? insuranceTaxDeducted;
  double? totalTax;

  void calculateTaxes(double salary) {
    setState(() {
      taxableIncome = salary;

      // Calculate tax rate based on salary
      if (salary < 30000) {
        taxRate = 10;
      } else if (salary < 100000) {
        taxRate = 20;
      } else {
        taxRate = 30;
      }

      // Calculate the tax deducted based on tax rate
      taxDeducted = taxableIncome! * (taxRate! / 100);

      // Calculate insurance tax deducted (5% of salary)
      insuranceTaxDeducted = salary * 0.05;

      // Calculate the total tax (insurance tax + tax deducted)
      totalTax = taxDeducted! + insuranceTaxDeducted!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tax Information'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.purple,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Salary: ',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: _salaryController,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?$')),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Enter salary',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Salary',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.purple[700],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    double enteredSalary = double.tryParse(_salaryController.text) ?? 0;
                    if (enteredSalary > 0) {
                      salary = enteredSalary;
                      calculateTaxes(enteredSalary);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a valid salary')),
                      );
                    }
                  },
                  child: Text('Submit Salary'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                if (salary != null)
                  ...[
                    _buildTaxRow('Taxable Income', (taxableIncome ?? 0).toStringAsFixed(2)),
                    _buildTaxRow('Tax Rate', (taxRate ?? 0).toStringAsFixed(2) + '%'),
                    _buildTaxRow('Tax Deducted', (taxDeducted ?? 0).toStringAsFixed(2)),
                    _buildTaxRow('Insurance Tax Deducted (5%)', (insuranceTaxDeducted ?? 0).toStringAsFixed(2)),
                    _buildTaxRow('Total Tax', (totalTax ?? 0).toStringAsFixed(2)),
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaxRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(width: 20),
          Container(
            width: 150,
            child: TextField(
              enabled: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: value,
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.purple[700],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
