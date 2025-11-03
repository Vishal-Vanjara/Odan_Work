import 'package:flutter/material.dart';
import '../widgets/admin_navigation_drawer.dart';
import '../widgets/metric_card.dart';
import '../widgets/revenue_chart.dart';
import 'book_inventory_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String _selectedPage = "Dashboard";

  void _onItemSelected(String page) {
    setState(() {
      _selectedPage = page;
    });

    // Navigate based on selected page
    switch (page) {
      case "Books":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookInventoryPage()),
        );
        break;

      case "Dashboard":
      // Stay on dashboard (already here)
        break;

      case "Orders":
      // Example: navigate to Orders page if you have one
      // Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersPage()));
        break;

    // Add other cases (Analytics, Settings, etc.) if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // ✅ Fixed: use _selectedPage
      drawer: AdminNavigationDrawer(
        selectedPage: _selectedPage,
        onItemSelected: _onItemSelected,
      ),

      appBar: AppBar(
        title: Text(_selectedPage),
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Welcome back to Book Bazaar Admin",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // ✅ Using Wrap for responsive metric cards
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: const [
                  MetricCard(
                    title: "Total Revenue",
                    value: "₹24,580",
                    change: "12.5%",
                    isPositive: true,
                    icon: Icons.attach_money,
                    width: 170,
                  ),
                  MetricCard(
                    title: "Total Orders",
                    value: "342",
                    change: "8.2%",
                    isPositive: true,
                    icon: Icons.shopping_cart,
                    width: 170,
                  ),
                  MetricCard(
                    title: "Books in Stock",
                    value: "1,284",
                    change: "3.1%",
                    isPositive: false,
                    icon: Icons.book,
                    width: 170,
                  ),
                  MetricCard(
                    title: "Avg Order Value",
                    value: "₹71.87",
                    change: "5.4%",
                    isPositive: true,
                    icon: Icons.trending_up,
                    width: 170,
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const RevenueChart(),
              const SizedBox(height: 24),

              const Text(
                "Recent Orders",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade100,
                    child: const Icon(Icons.person, color: Colors.orange),
                  ),
                  title: const Text("John Doe"),
                  subtitle: const Text("The Great Gatsby"),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Delivered",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
