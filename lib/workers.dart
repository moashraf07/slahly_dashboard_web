import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WorkersPage extends StatefulWidget {
  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filterStatus = 'All';
  String? _selectedWorkerId;
  String? _selectedTab;

  // Sample workers data
  final List<Map<String, dynamic>> workers = [
    {
      'id': 'W001',
      'name': 'Ali Mohamed',
      'email': 'ali.mohamed@example.com',
      'phone': '+966 50 111 2222',
      'specialization': 'Cleaning',
      'verificationStatus': 'Verified',
      'subscriptionStatus': 'Active',
      'totalEarnings': '\$4,250.50',
      'monthlyEarnings': '\$850.75',
      'rating': 4.8,
      'totalJobs': 58,
      'completedJobs': 56,
      'avatar': '👨‍🔧',
      'joinDate': '2024-06-15',
      'approvalStatus': 'Approved',
      'bankAccount': '****1234',
      'completionRate': '96.5%',
    },
    {
      'id': 'W002',
      'name': 'Sara Ahmed',
      'email': 'sara.ahmed@example.com',
      'phone': '+966 55 333 4444',
      'specialization': 'Plumbing',
      'verificationStatus': 'Pending',
      'subscriptionStatus': 'Active',
      'totalEarnings': '\$1,800.00',
      'monthlyEarnings': '\$600.00',
      'rating': 4.5,
      'totalJobs': 18,
      'completedJobs': 17,
      'avatar': '👩‍🔧',
      'joinDate': '2025-01-10',
      'approvalStatus': 'Pending',
      'bankAccount': '****5678',
      'completionRate': '94.4%',
    },
    {
      'id': 'W003',
      'name': 'Karim Hassan',
      'email': 'karim.hassan@example.com',
      'phone': '+966 51 555 6666',
      'specialization': 'Electrical',
      'verificationStatus': 'Rejected',
      'subscriptionStatus': 'Inactive',
      'totalEarnings': '\$500.00',
      'monthlyEarnings': '\$0.00',
      'rating': 2.5,
      'totalJobs': 5,
      'completedJobs': 2,
      'avatar': '👨‍💻',
      'joinDate': '2025-02-01',
      'approvalStatus': 'Rejected',
      'bankAccount': '****9012',
      'completionRate': '40%',
    },
    {
      'id': 'W004',
      'name': 'Fatima Al-Rashid',
      'email': 'fatima.rashid@example.com',
      'phone': '+966 54 777 8888',
      'specialization': 'Painting',
      'verificationStatus': 'Verified',
      'subscriptionStatus': 'Active',
      'totalEarnings': '\$3,150.75',
      'monthlyEarnings': '\$750.25',
      'rating': 4.7,
      'totalJobs': 42,
      'completedJobs': 41,
      'avatar': '👩‍🎨',
      'joinDate': '2024-08-20',
      'approvalStatus': 'Approved',
      'bankAccount': '****3456',
      'completionRate': '97.6%',
    },
    {
      'id': 'W005',
      'name': 'Omar Saleh',
      'email': 'omar.saleh@example.com',
      'phone': '+966 50 999 0000',
      'specialization': 'Repair',
      'verificationStatus': 'Verified',
      'subscriptionStatus': 'Inactive',
      'totalEarnings': '\$2,300.00',
      'monthlyEarnings': '\$0.00',
      'rating': 4.2,
      'totalJobs': 31,
      'completedJobs': 29,
      'avatar': '👨‍🔨',
      'joinDate': '2024-11-05',
      'approvalStatus': 'Approved',
      'bankAccount': '****7890',
      'completionRate': '93.5%',
    },
  ];

  List<Map<String, dynamic>> get filteredWorkers {
    return workers.where((worker) {
      final matchesSearch = worker['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          worker['email'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          worker['specialization'].toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesStatus = _filterStatus == 'All' || worker['verificationStatus'] == _filterStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      sideBar: SideBar(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(color: Color.fromARGB(255, 102, 100, 100)),
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: '/',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Sections',
            icon: Icons.file_copy,
            children: [
              AdminMenuItem(
                title: 'Users',
                route: '/users',
              ),
              AdminMenuItem(
                title: 'Workers',
                route: '/workers',
              ),
              AdminMenuItem(
                title: 'Requests',
                route: '/requests',
              ),
              AdminMenuItem(
                title: 'Financials',
                route: '/financials',
              ),
              AdminMenuItem(
                title: 'Settings',
                route: '/settings',
              ),
            ],
          ),
        ],
        selectedRoute: '/workers',
        onSelected: (item) {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Service Admin',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Mohamed Ashraf © 2026',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: _selectedWorkerId == null ? _buildWorkersList() : _buildWorkerDetail(),
    );
  }

  Widget _buildWorkersList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ' Worker Management',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36, color: Colors.black),
          ),
          const SizedBox(height: 24),
          // Search and Filter Section
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search by name, email or specialization...',
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
                  value: _filterStatus,
                  underline: SizedBox(),
                  items: ['All', 'Verified', 'Pending', 'Rejected']
                      .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (val) => setState(() => _filterStatus = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Workers List
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text('Avatar', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text('Specialization', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Verification', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Rating', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text('Subscription', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Earnings', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                // Workers Rows
                ...filteredWorkers.map((worker) => _buildWorkerRow(worker)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerRow(Map<String, dynamic> worker) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(worker['avatar'], style: TextStyle(fontSize: 24)),
          ),
          Expanded(
            flex: 2,
            child: Text(worker['name'], style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                worker['specialization'],
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getVerificationColor(worker['verificationStatus']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                worker['verificationStatus'],
                style: TextStyle(
                  color: _getVerificationColor(worker['verificationStatus']),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text('${worker['rating']}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                SizedBox(width: 2),
                Text('⭐', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: worker['subscriptionStatus'] == 'Active' ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                worker['subscriptionStatus'],
                style: TextStyle(
                  color: worker['subscriptionStatus'] == 'Active' ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(worker['monthlyEarnings'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () => setState(() {
                _selectedWorkerId = worker['id'];
                _selectedTab = 'profile';
              }),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                backgroundColor: Colors.blue,
              ),
              child: Text('View', style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerDetail() {
    final worker = workers.firstWhere((w) => w['id'] == _selectedWorkerId);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() => _selectedWorkerId = null),
                icon: Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 8),
              Text('Worker Profile', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28)),
            ],
          ),
          const SizedBox(height: 24),
          // Tabs
          Row(
            children: [
              _buildTabButton('Profile', 'profile'),
              SizedBox(width: 8),
              _buildTabButton('Earnings', 'earnings'),
              SizedBox(width: 8),
              _buildTabButton('Approval', 'approval'),
            ],
          ),
          const SizedBox(height: 24),
          if (_selectedTab == 'profile') _buildProfileTab(worker),
          if (_selectedTab == 'earnings') _buildEarningsTab(worker),
          if (_selectedTab == 'approval') _buildApprovalTab(worker),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, String tab) {
    final isActive = _selectedTab == tab;
    return ElevatedButton(
      onPressed: () => setState(() => _selectedTab = tab),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.grey.withOpacity(0.2),
      ),
      child: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.black)),
    );
  }

  Widget _buildProfileTab(Map<String, dynamic> worker) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(worker['avatar'], style: TextStyle(fontSize: 64)),
              SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(worker['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(worker['specialization'], style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text(worker['email'], style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 4),
                    Text(worker['phone'], style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _getVerificationColor(worker['verificationStatus']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  worker['verificationStatus'],
                  style: TextStyle(
                    color: _getVerificationColor(worker['verificationStatus']),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildStatBox('Total Jobs', '${worker['totalJobs']}', Colors.blue),
              _buildStatBox('Completed', '${worker['completedJobs']}', Colors.green),
              _buildStatBox('Rating', '${worker['rating']}', Colors.orange),
              _buildStatBox('Completion Rate', worker['completionRate'], Colors.purple),
              _buildStatBox('Subscription', worker['subscriptionStatus'], Colors.teal),
              _buildStatBox('Join Date', worker['joinDate'], Colors.indigo),
              _buildStatBox('Bank Account', worker['bankAccount'], Colors.red),
              _buildStatBox('Approval', worker['approvalStatus'], Colors.cyan),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: Colors.black54, fontSize: 12)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildEarningsTab(Map<String, dynamic> worker) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Earnings Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildEarningsCard('Total Earnings', worker['totalEarnings'], Colors.green),
              _buildEarningsCard('Monthly Earnings', worker['monthlyEarnings'], Colors.blue),
              _buildEarningsCard('Completion Rate', worker['completionRate'], Colors.orange),
            ],
          ),
          SizedBox(height: 24),
          Text('Earnings Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildEarningsItem('Completed Jobs (${worker['completedJobs']})', '${double.parse(worker['totalEarnings'].replaceAll('\$', '').replaceAll(',', '')) * 0.7}'),
                Divider(),
                _buildEarningsItem('Pending Payments', '${double.parse(worker['monthlyEarnings'].replaceAll('\$', '').replaceAll(',', ''))}'),
                Divider(),
                _buildEarningsItem('Total Commission (10%)', '${double.parse(worker['totalEarnings'].replaceAll('\$', '').replaceAll(',', '')) * 0.1}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: Colors.black54, fontSize: 12)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildEarningsItem(String label, String amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text('\$${amount}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }

  Widget _buildApprovalTab(Map<String, dynamic> worker) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Worker Approval Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getApprovalBgColor(worker['approvalStatus']),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Status', style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 8),
                    Text(worker['approvalStatus'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Icon(
                  _getApprovalIcon(worker['approvalStatus']),
                  size: 40,
                  color: _getApprovalColor(worker['approvalStatus']),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          if (worker['approvalStatus'] == 'Pending')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showApprovalDialog(worker, 'Approved'),
                    icon: Icon(Icons.check),
                    label: Text('Approve Worker'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showApprovalDialog(worker, 'Rejected'),
                    icon: Icon(Icons.close),
                    label: Text('Reject Worker'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          if (worker['approvalStatus'] != 'Pending')
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This worker has already been ${worker['approvalStatus'].toLowerCase()}. Status cannot be changed.',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 24),
          Text('Verification Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildVerificationItem('Identity Verified', true),
                Divider(),
                _buildVerificationItem('Bank Account Verified', worker['approvalStatus'] == 'Approved'),
                Divider(),
                _buildVerificationItem('Background Check', worker['verificationStatus'] == 'Verified'),
                Divider(),
                _buildVerificationItem('Insurance Valid', worker['subscriptionStatus'] == 'Active'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationItem(String label, bool verified) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: verified ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(verified ? Icons.check : Icons.close, color: verified ? Colors.green : Colors.red, size: 16),
                SizedBox(width: 4),
                Text(verified ? 'Verified' : 'Not Verified', style: TextStyle(color: verified ? Colors.green : Colors.red, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showApprovalDialog(Map<String, dynamic> worker, String status) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${status == 'Approved' ? 'Approve' : 'Reject'} Worker'),
        content: Text('Are you sure you want to ${status.toLowerCase()} ${worker['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Worker ${status == 'Approved' ? 'approved' : 'rejected'} successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: status == 'Approved' ? Colors.green : Colors.red,
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Color _getVerificationColor(String status) {
    switch (status) {
      case 'Verified':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getApprovalColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getApprovalIcon(String status) {
    switch (status) {
      case 'Approved':
        return Icons.verified;
      case 'Pending':
        return Icons.hourglass_empty;
      case 'Rejected':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Color _getApprovalBgColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green.withOpacity(0.1);
      case 'Pending':
        return Colors.orange.withOpacity(0.1);
      case 'Rejected':
        return Colors.red.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
