import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filterStatus = 'All';
  String? _selectedUserId;
  String? _selectedTab;

  // Sample users data
  final List<Map<String, dynamic>> users = [
    {
      'id': 'U001',
      'name': 'Ahmed Hassan',
      'email': 'ahmed.hassan@example.com',
      'phone': '+966 50 123 4567',
      'status': 'Active',
      'joinDate': '2025-01-15',
      'totalRequests': 12,
      'completedRequests': 10,
      'rating': 4.8,
      'avatar': '👨‍💼',
      'requests': [
        {'id': 'REQ-001', 'service': 'Cleaning', 'status': 'Completed', 'date': '2025-12-20', 'amount': '\$150'},
        {'id': 'REQ-002', 'service': 'Repair', 'status': 'Completed', 'date': '2025-12-18', 'amount': '\$200'},
        {'id': 'REQ-003', 'service': 'Cleaning', 'status': 'Pending', 'date': '2025-12-26', 'amount': '\$100'},
      ],
    },
    {
      'id': 'U002',
      'name': 'Fatima Ali',
      'email': 'fatima.ali@example.com',
      'phone': '+966 55 987 6543',
      'status': 'Active',
      'joinDate': '2025-02-10',
      'totalRequests': 8,
      'completedRequests': 7,
      'rating': 4.5,
      'avatar': '👩‍💼',
      'requests': [
        {'id': 'REQ-004', 'service': 'Plumbing', 'status': 'Completed', 'date': '2025-12-22', 'amount': '\$180'},
        {'id': 'REQ-005', 'service': 'Electrical', 'status': 'In Progress', 'date': '2025-12-26', 'amount': '\$220'},
      ],
    },
    {
      'id': 'U003',
      'name': 'Mohammed Salem',
      'email': 'salem.mohammed@example.com',
      'phone': '+966 51 456 7890',
      'status': 'Blocked',
      'joinDate': '2025-03-05',
      'totalRequests': 15,
      'completedRequests': 12,
      'rating': 3.2,
      'avatar': '👨‍💻',
      'requests': [
        {'id': 'REQ-006', 'service': 'Cleaning', 'status': 'Cancelled', 'date': '2025-12-15', 'amount': '\$120'},
      ],
    },
    {
      'id': 'U004',
      'name': 'Layla Karim',
      'email': 'layla.karim@example.com',
      'phone': '+966 54 321 0987',
      'status': 'Active',
      'joinDate': '2025-04-20',
      'totalRequests': 5,
      'completedRequests': 5,
      'rating': 4.9,
      'avatar': '👩‍🔬',
      'requests': [
        {'id': 'REQ-007', 'service': 'Repair', 'status': 'Completed', 'date': '2025-12-25', 'amount': '\$175'},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredUsers {
    return users.where((user) {
      final matchesSearch = user['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          user['email'].toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesStatus = _filterStatus == 'All' || user['status'] == _filterStatus;
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
        selectedRoute: '/users',
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
      body: _selectedUserId == null ? _buildUsersList() : _buildUserDetail(),
    );
  }

  Widget _buildUsersList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Management',
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
                    hintText: 'Search by name or email...',
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
                  items: ['All', 'Active', 'Blocked']
                      .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (val) => setState(() => _filterStatus = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Users List
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
                      Expanded(flex: 2, child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Requests', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Rating', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                // Users Rows
                ...filteredUsers.map((user) => _buildUserRow(user)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRow(Map<String, dynamic> user) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(user['avatar'], style: TextStyle(fontSize: 24)),
          ),
          Expanded(
            flex: 2,
            child: Text(user['name'], style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 2,
            child: Text(user['email'], style: TextStyle(color: Colors.black54, fontSize: 13)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: user['status'] == 'Active' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                user['status'],
                style: TextStyle(
                  color: user['status'] == 'Active' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('${user['totalRequests']}', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text('${user['rating']}', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(width: 4),
                Text('⭐', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    _selectedUserId = user['id'];
                    _selectedTab = 'profile';
                  }),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('View', style: TextStyle(fontSize: 11, color: Colors.white)),
                ),
                SizedBox(width: 4),
                IconButton(
                  onPressed: () => setState(() {
                    _selectedUserId = user['id'];
                    _selectedTab = 'history';
                  }),
                  icon: Icon(Icons.history, size: 18),
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetail() {
    final user = users.firstWhere((u) => u['id'] == _selectedUserId);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() => _selectedUserId = null),
                icon: Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 8),
              Text('User Profile', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28)),
            ],
          ),
          const SizedBox(height: 24),
          // Tabs
          Row(
            children: [
              _buildTabButton('Profile', 'profile'),
              SizedBox(width: 8),
              _buildTabButton('Request History', 'history'),
            ],
          ),
          const SizedBox(height: 24),
          _selectedTab == 'profile' ? _buildProfileTab(user) : _buildHistoryTab(user),
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

  Widget _buildProfileTab(Map<String, dynamic> user) {
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
              Text(user['avatar'], style: TextStyle(fontSize: 64)),
              SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(user['email'], style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 4),
                    Text(user['phone'], style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: user['status'] == 'Active' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  user['status'],
                  style: TextStyle(
                    color: user['status'] == 'Active' ? Colors.green : Colors.red,
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
              _buildStatBox('Total Requests', '${user['totalRequests']}', Colors.blue),
              _buildStatBox('Completed', '${user['completedRequests']}', Colors.green),
              _buildStatBox('Rating', '${user['rating']}', Colors.orange),
              _buildStatBox('Join Date', user['joinDate'], Colors.purple),
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
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildHistoryTab(Map<String, dynamic> user) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Request History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Request ID')),
                DataColumn(label: Text('Service')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Amount')),
              ],
              rows: (user['requests'] as List).map<DataRow>((req) {
                return DataRow(cells: [
                  DataCell(Text(req['id'])),
                  DataCell(Text(req['service'])),
                  DataCell(Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(req['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(req['status'], style: TextStyle(color: _getStatusColor(req['status']), fontSize: 12)),
                  )),
                  DataCell(Text(req['date'])),
                  DataCell(Text(req['amount'], style: TextStyle(fontWeight: FontWeight.bold))),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.blue;
      case 'Pending':
        return Colors.orange;
      case 'Cancelled':
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
