import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/core/providers/coffee_provider.dart';
import 'package:finalboss/core/features/presentation/pages/size_ext.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CoffeeProvider>().markAllAsRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();
    final notifications = provider.notifications;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFA), // Light background like Homepage bottom
      body: Column(
        children: [
          _buildHeader(context, provider.newNotificationCount),
          Expanded(
            child: notifications.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 6.w(context), vertical: 3.h(context)),
                    itemCount: notifications.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) return _buildStayUpdatedBanner(context);
                      final notification = notifications[index - 1];
                      return _buildNotificationCard(context, notification);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int newCount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 2.h(context),
        bottom: 3.h(context),
        left: 6.w(context),
        right: 6.w(context),
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF131313), // Match Homepage Dark Header
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
          Column(
            children: [
              Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 5.w(context),
                  fontFamily: 'Sora',
                ),
              ),
              if (newCount > 0)
                Text(
                  "$newCount unread updates",
                  style: TextStyle(
                    color: const Color(0xFFC67C4E),
                    fontSize: 3.w(context),
                    fontFamily: 'Sora',
                  ),
                ),
            ],
          ),
          const SizedBox(width: 40), // Spacing for symmetry
        ],
      ),
    );
  }

  Widget _buildStayUpdatedBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h(context)),
      padding: EdgeInsets.all(5.w(context)),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0E6), // Light Orange theme from Homepage
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "LATEST UPDATES",
                  style: TextStyle(
                    color: Color(0xFFC67C4E),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 1.h(context)),
                Text(
                  "Get the best out\nof your coffee.",
                  style: TextStyle(
                    fontSize: 4.5.w(context),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sora',
                    color: const Color(0xFF2F2D2C),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.notifications_active, color: Color(0xFFC67C4E), size: 28),
          )
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, AppNotification notification) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h(context)),
      padding: EdgeInsets.all(4.w(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: notification.isNew
            ? Border.all(color: const Color(0xFFC67C4E).withOpacity(0.3), width: 1.5)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(notification.icon, color: const Color(0xFFC67C4E), size: 22),
              ),
              SizedBox(width: 4.w(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3.8.w(context),
                            color: const Color(0xFF2F2D2C),
                            fontFamily: 'Sora',
                          ),
                        ),
                        Text(
                          notification.time,
                          style: TextStyle(color: Colors.grey, fontSize: 2.5.w(context)),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h(context)),
                    Text(
                      notification.message,
                      style: TextStyle(
                        color: const Color(0xFF9B9B9B),
                        fontSize: 3.2.w(context),
                        height: 1.4,
                        fontFamily: 'Sora',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (notification.imagePath != null) ...[
            SizedBox(height: 2.h(context)),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                notification.imagePath!,
                height: 15.h(context),
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 15.h(context),
                  color: const Color(0xFFF9F9F9),
                  child: const Icon(Icons.coffee_rounded, color: Colors.grey),
                ),
              ),
            ),
          ],
          if (notification.actionLabel != null) ...[
            SizedBox(height: 1.5.h(context)),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC67C4E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(
                  notification.actionLabel!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 15.w(context), color: Colors.grey.shade300),
          SizedBox(height: 2.h(context)),
          Text(
            "Nothing to see here",
            style: TextStyle(color: Colors.grey, fontSize: 4.w(context), fontFamily: 'Sora'),
          ),
        ],
      ),
    );
  }
}
