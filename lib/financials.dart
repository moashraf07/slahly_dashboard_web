import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class FinancialsPage extends StatefulWidget {
  @override
  State<FinancialsPage> createState() => _FinancialsPageState();
}

class _FinancialsPageState extends State<FinancialsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filterPeriod = 'All';
  String _filterWorker = 'All';

  final List<Map<String, dynamic>> transactions = [
    {'id': 'TXN-001', 'requestId': 'REQ-001', 'user': 'Ahmed Hassan', 'worker': 'Ali Mohamed', 'amount': 150.00, 'commission': 15.00, 'profit': 15.00, 'date': '2025-12-20', 'status': 'Completed'},
    {'id': 'TXN-002', 'requestId': 'REQ-002', 'user': 'Fatima Ali', 'worker': 'Sara Ahmed', 'amount': 200.00, 'commission': 20.00, 'profit': 20.00, 'date': '2025-12-21', 'status': 'Completed'},
    {'id': 'TXN-003', 'requestId': 'REQ-003', 'user': 'Mohammed Salem', 'worker': 'Karim Hassan', 'amount': 250.00, 'commission': 25.00, 'profit': 25.00, 'date': '2025-12-22', 'status': 'Completed'},
    {'id': 'TXN-004', 'requestId': 'REQ-004', 'user': 'Layla Karim', 'worker': 'Fatima Al-Rashid', 'amount': 180.00, 'commission': 18.00, 'profit': 18.00, 'date': '2025-12-23', 'status': 'Pending'},
    {'id': 'TXN-005', 'requestId': 'REQ-005', 'user': 'Omar Saleh', 'worker': null, 'amount': 120.00, 'commission': 12.00, 'profit': 12.00, 'date': '2025-12-24', 'status': 'Refunded'},
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((txn) {
      final matchesSearch = txn['id'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          txn['user'].toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  double get totalRevenue => transactions.fold(0.0, (sum, txn) => sum + (txn['amount'] as num));
  double get totalCommission => transactions.fold(0.0, (sum, txn) => sum + (txn['commission'] as num));
  double get totalProfit => transactions.fold(0.0, (sum, txn) => sum + (txn['profit'] as num));

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      sideBar: SideBar(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(color: Color.fromARGB(255, 102, 100, 100)),
        items: const [
          AdminMenuItem(title: 'Dashboard', route: '/', icon: Icons.dashboard),
          AdminMenuItem(
            title: 'Sections',
            icon: Icons.file_copy,
            children: [
              AdminMenuItem(title: 'Users', route: '/users'),
              AdminMenuItem(title: 'Workers', route: '/workers'),
              AdminMenuItem(title: 'Requests', route: '/requests'),
              AdminMenuItem(title: 'Financials', route: '/financials'),
              AdminMenuItem(title: 'Settings', route: '/settings'),
            ],
          ),
        ],
        selectedRoute: '/financials',
        onSelected: (item) {
          if (item.route != null) Navigator.of(context).pushNamed(item.route!);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(child: Text('Service Admin', style: TextStyle(color: Colors.white))),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(child: Text('Mohamed Ashraf © 2026', style: TextStyle(color: Colors.white))),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Money Management', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36, color: Colors.black)),
            const SizedBox(height: 24),
            // Summary Cards
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildSummaryCard('Total Revenue', '\$${totalRevenue.toStringAsFixed(2)}', Colors.green, Icons.trending_up),
                _buildSummaryCard('Total Commission', '\$${totalCommission.toStringAsFixed(2)}', Colors.blue, Icons.money),
                _buildSummaryCard('Platform Profit', '\$${totalProfit.toStringAsFixed(2)}', Colors.purple, Icons.account_balance),
              ],
            ),
            const SizedBox(height: 24),
            // Filters
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search by Transaction ID or User...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton<String>(
                    value: _filterPeriod,
                    underline: SizedBox(),
                    items: ['All', 'Today', 'This Week', 'This Month', 'This Year']
                        .map((period) => DropdownMenuItem(value: period, child: Text(period)))
                        .toList(),
                    onChanged: (val) => setState(() => _filterPeriod = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Transactions Table
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.05),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text('Transaction ID', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Request', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('User', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Worker', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Commission (10%)', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Profit', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  ...filteredTransactions.map((txn) => Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
                        child: Row(
                          children: [
                            Expanded(child: Text(txn['id'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
                            Expanded(child: Text(txn['requestId'], style: TextStyle(fontSize: 12))),
                            Expanded(child: Text(txn['user'], style: TextStyle(fontSize: 12))),
                            Expanded(child: Text(txn['worker'] ?? 'N/A', style: TextStyle(fontSize: 12))),
                            Expanded(child: Text('\$${txn['amount']}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
                            Expanded(child: Text('\$${txn['commission']}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.blue))),
                            Expanded(child: Text('\$${txn['profit']}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.green))),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getTransactionStatusColor(txn['status']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(txn['status'], style: TextStyle(color: _getTransactionStatusColor(txn['status']), fontSize: 10, fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.black54, fontSize: 14)),
              Icon(icon, color: color, size: 24),
            ],
          ),
          SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Color _getTransactionStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Refunded':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
