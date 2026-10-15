import 'package:flutter/material.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedMethod;
  String? selectedBank;
  final TextEditingController amountController = TextEditingController();

  final List<String> banks = [
    'VietinBank',
    'Vietcombank',
    'Techcombank',
    'BIDV',
    'MB Bank',
    'Agribank',
    'ACB',
    'TPBank',
  ];

  final List<String> eWallets = [
    'MoMo',
    'ZaloPay',
    'ViettelMoney',
    'ShopeePay',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rút tiền'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              
              // Chọn Phương thức (Ngân hàng hay Ví điện tử)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Chọn phương thức rút tiền',
                  border: OutlineInputBorder(),
                  filled: true,
                ),
                initialValue: selectedMethod,
                items: const [
                  DropdownMenuItem(value: 'Bank', child: Text('Tài khoản Ngân hàng')),
                  DropdownMenuItem(value: 'Wallet', child: Text('Ví điện tử')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value;
                    selectedBank = null; // Reset khi chuyển phương thức
                  });
                },
              ),
              const SizedBox(height: 16),

              // Nếu chọn Ngân hàng
              if (selectedMethod == 'Bank') ...[
                const Text(
                  'Chọn Ngân hàng thụ hưởng:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                  hint: const Text('Chọn Ngân hàng'),
                  initialValue: selectedBank,
                  items: banks.map((bank) {
                    return DropdownMenuItem<String>(
                      value: bank,
                      child: Text(
                        bank,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
setState(() {
                      selectedBank = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],

              // Nếu chọn Ví điện tử
              if (selectedMethod == 'Wallet') ...[
                const Text(
                  'Chọn Ví điện tử:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                  hint: const Text('Chọn Ví điện tử'),
                  initialValue: selectedBank,
                  items: eWallets.map((wallet) {
                    return DropdownMenuItem<String>(
                      value: wallet,
                      child: Text(
                        wallet,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBank = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],

              // Nhập số tiền rút (Hạn mức 100đ - 500k)
              const Text(
                'Nhập số tiền rút (Mốc 100đ - 500.000đ):',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintText: 'Nhập số tiền (VD: 50000)',
                  suffixText: 'VNĐ',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số tiền cần rút';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount < 100 || amount > 500000) {
                    return 'Số tiền rút phải từ 100đ đến 500.000đ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Nút xác nhận
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Xác nhận rút tiền thành công!')),
                    );
                  }
                },
                child: const Text('Xác nhận', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}