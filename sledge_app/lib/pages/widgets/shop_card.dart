import 'package:flutter/material.dart';

class ShopCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onDelete;
  final VoidCallback onAccept;
  final Function(String) onPaymentSelected;
  final String section;

  ShopCard({
    required this.product,
    required this.onDelete,
    required this.onAccept,
    required this.onPaymentSelected,
    required this.section,
  });

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    items = List.from(widget.product['items'] ?? []);
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
      widget.product['items'] = items;
    });
  }

  double get totalAmount {
    return items.fold(0, (sum, item) => sum + item['price']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Customer Name and Delete Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.product['name'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: widget.onDelete,
                ),
              ],
            ),

            Divider(thickness: 1, color: Colors.grey[400]),

            // Items List
            ...items.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: item['name'],
                        onChanged: (value) => item['name'] = value,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Text('₹${item['price']}', style: TextStyle(fontSize: 16)),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () => deleteItem(index),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: 14),

            // Total
            Align(
              alignment: Alignment.centerRight,
              child: Text('Total: ₹$totalAmount',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 14),

            // Action Buttons based on section
            // Action Buttons based on section
if (widget.section == 'Orders')
  Align(
    alignment: Alignment.centerRight,
    child: IconButton(
      icon: Icon(Icons.check_circle, color: Colors.green, size: 32),
      onPressed: widget.onAccept,
    ),
  ),

if (widget.section == 'Payments')
  Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('Select Payment Method:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['UPI', 'CREDIT', 'CASH'].map((method) {
          return ElevatedButton(
            onPressed: () => widget.onPaymentSelected(method),
            child: Text(method),
          );
        }).toList(),
      ),
    ],
  ),

if (widget.section == 'Transactions')
  Center(
    child: Text(
      'Transaction Completed via ${widget.product['paymentMethod']}',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
    ),
  ),

          ],
        ),
      ),
    );
  }
}
