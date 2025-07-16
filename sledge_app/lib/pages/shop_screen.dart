import 'package:flutter/material.dart';
import './widgets/shop_card.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedTab = 'Pending';

  List<Map<String, dynamic>> pendingOrders = [
    {
      'name': 'Hind Pharma',
      'items': [
        {'name': 'Aashirvaad Atta', 'price': 300},
        {'name': 'Tata Salt', 'price': 20},
      ]
    },
    {
      'name': 'Singh Store',
      'items': [
        {'name': 'Surf Excel', 'price': 150},
        {'name': 'Parle G', 'price': 10},
      ]
    }
  ];

  List<Map<String, dynamic>> payments = [];
  List<Map<String, dynamic>> transactions = [];

  void moveToPayments(Map<String, dynamic> order) {
    setState(() {
      pendingOrders.remove(order);
      payments.add(order);
    });
  }

  void moveToTransactions(Map<String, dynamic> order, String paymentMethod) {
    setState(() {
      payments.remove(order);
      transactions.add({...order, 'paymentMethod': paymentMethod});
    });
  }

  void deleteOrder(Map<String, dynamic> order) {
    setState(() {
      pendingOrders.remove(order);
      payments.remove(order);
      transactions.remove(order);
    });
  }

  List<Map<String, dynamic>> get currentOrders {
    if (selectedTab == 'Pending') return pendingOrders;
    if (selectedTab == 'Payments') return payments;
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Pending', 'Payments', 'Transactions'].map((tab) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = tab;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: selectedTab == tab ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: selectedTab == tab ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: currentOrders.length,
              itemBuilder: (context, index) {
                return ShopCard(
                  product: currentOrders[index],
                  onDelete: () => deleteOrder(currentOrders[index]),
                  onAccept: () => moveToPayments(currentOrders[index]),
                  onPaymentSelected: (method) => moveToTransactions(currentOrders[index], method),
                  section: selectedTab,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
