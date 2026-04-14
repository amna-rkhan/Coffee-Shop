import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/core/providers/coffee_provider.dart';
import 'package:finalboss/core/features/presentation/pages/size_ext.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();
    final orders = provider.orderHistory;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4B3732), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Order History",
          style: TextStyle(
            color: const Color(0xFF4B3732), 
            fontWeight: FontWeight.bold, 
            fontSize: 5.w(context),
            fontFamily: 'Sora'
          ),
        ),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 6.w(context), vertical: 2.h(context)),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(context, orders[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 20.w(context), color: Colors.grey.withOpacity(0.3)),
          SizedBox(height: 2.h(context)),
          Text(
            "No orders yet",
            style: TextStyle(
              color: Colors.grey, 
              fontSize: 4.5.w(context), 
              fontFamily: 'Sora'
            ),
          ),
          SizedBox(height: 1.h(context)),
          Text(
            "Time to brew some magic!",
            style: TextStyle(
              color: Colors.grey.withOpacity(0.6), 
              fontSize: 3.5.w(context), 
              fontFamily: 'Sora'
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    // Safe date formatting
    String formattedDate;
    try {
      formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(order.date);
    } catch (e) {
      formattedDate = order.date.toString();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 2.h(context)),
      padding: EdgeInsets.all(5.w(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #${order.id}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.8.w(context), fontFamily: 'Sora', color: const Color(0xFF2F2D2C)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0E6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: const TextStyle(color: Color(0xFFC67C4E), fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h(context)),
          Text(
            formattedDate,
            style: TextStyle(color: Colors.grey, fontSize: 3.w(context), fontFamily: 'Sora'),
          ),
          const Divider(height: 30),
          ...order.items.map((item) {
            final coffee = item['coffee'];
            if (coffee == null) return const SizedBox();
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      coffee.imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(width: 50, height: 50, color: Colors.grey.shade100),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coffee.name ?? "Coffee",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sora'),
                        ),
                        Text(
                          "${item['quantity'] ?? 1}x ${coffee.description ?? ""}",
                          style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Sora'),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$ ${((coffee.price ?? 0) * (item['quantity'] ?? 1)).toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sora'),
                  ),
                ],
              ),
            );
          }).toList(),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Sora'),
              ),
              Text(
                "\$ ${order.total.toStringAsFixed(2)}",
                style: const TextStyle(color: Color(0xFFC67C4E), fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Sora'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
