import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SubscriptionsPage extends StatefulWidget {
  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  String _filterStatus = 'All';
  String? _selectedPlanId;

  final List<Map<String, dynamic>> subscriptionPlans = [
    {
      'id': 'PLAN-001',
      'name': 'Basic',
      'price': 9.99,
      'duration': 'Monthly',
      'features': [
        'List up to 5 services',
        'Customer messaging',
        'Basic analytics',
        'Mobile app access'
      ],
      'active': 124,
      'expired': 12,
    },
    {
      'id': 'PLAN-002',
      'name': 'Professional',
      'price': 29.99,
      'duration': 'Monthly',
      'features': [
        'Unlimited service listings',
        'Priority messaging',
        'Advanced analytics',
        'Premium support',
        'Featured listings'
      ],
      'active': 287,
      'expired': 45,
    },
    {
      'id': 'PLAN-003',
      'name': 'Premium',
      'price': 99.99,
      'duration': 'Monthly',
      'features': [
        'Unlimited everything',
        '24/7 dedicated support',
        'Custom branding',
        'Advanced AI tools',
        'Marketing campaigns',
        'Revenue share benefits'
      ],
      'active': 56,
      'expired': 8,
    },
  ];

  final List<Map<String, dynamic>> activeSubscriptions = [
    {'worker': 'Ali Mohamed', 'plan': 'Professional', 'status': 'Active', 'expiryDate': '2026-03-20', 'amount': 29.99},
    {'worker': 'Sara Ahmed', 'plan': 'Basic', 'status': 'Active', 'expiryDate': '2026-01-10', 'amount': 9.99},
    {'worker': 'Fatima Al-Rashid', 'plan': 'Premium', 'status': 'Active', 'expiryDate': '2026-06-20', 'amount': 99.99},
    {'worker': 'Karim Hassan', 'plan': 'Basic', 'status': 'Expired', 'expiryDate': '2025-12-15', 'amount': 9.99},
    {'worker': 'Omar Saleh', 'plan': 'Professional', 'status': 'Expiring Soon', 'expiryDate': '2025-12-30', 'amount': 29.99},
  ];

  List<Map<String, dynamic>> get filteredSubscriptions {
    if (_filterStatus == 'All') return activeSubscriptions;
    return activeSubscriptions.where((sub) => sub['status'] == _filterStatus).toList();
  }

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
        selectedRoute: '/subscriptions',
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
            const Text('اشتراكات العمال', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36, color: Colors.black)),
            const SizedBox(height: 24),
            // Subscription Plans
            Text('Subscription Plans', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: NeverScrollableScrollPhysics(),
              children: subscriptionPlans.map((plan) => _buildPlanCard(plan)).toList(),
            ),
            const SizedBox(height: 32),
            // Active Subscriptions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active Subscriptions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton<String>(
                    value: _filterStatus,
                    underline: SizedBox(),
                    items: ['All', 'Active', 'Expired', 'Expiring Soon']
                        .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                        .toList(),
                    onChanged: (val) => setState(() => _filterStatus = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                        Expanded(child: Text('Worker', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Plan', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Expiry Date', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  ...filteredSubscriptions.map((sub) => Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
                        child: Row(
                          children: [
                            Expanded(child: Text(sub['worker'], style: TextStyle(fontWeight: FontWeight.w500))),
                            Expanded(child: Text(sub['plan'], style: TextStyle(fontSize: 13))),
                            Expanded(child: Text('\$${sub['amount']}', style: TextStyle(fontWeight: FontWeight.w500))),
                            Expanded(child: Text(sub['expiryDate'], style: TextStyle(fontSize: 13))),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getSubscriptionStatusColor(sub['status']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(sub['status'], style: TextStyle(color: _getSubscriptionStatusColor(sub['status']), fontSize: 10, fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Expanded(
                              child: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(child: Text('Renew'), value: 'renew'),
                                  PopupMenuItem(child: Text('Cancel'), value: 'cancel'),
                                  PopupMenuItem(child: Text('Upgrade'), value: 'upgrade'),
                                ],
                                onSelected: (value) => ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${value} action applied')),
                                ),
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

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(plan['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '\$${plan['price']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                TextSpan(text: '/${plan['duration']}', style: TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: plan['features'].length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.check, size: 16, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(child: Text(plan['features'][index], style: TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${plan['active']} Active', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 12)),
              Text('${plan['expired']} Expired', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 12)),
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Edit plan'))),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Edit Plan', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Color _getSubscriptionStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Expired':
        return Colors.red;
      case 'Expiring Soon':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
