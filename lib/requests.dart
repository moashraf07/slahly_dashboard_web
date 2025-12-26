import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class RequestsPage extends StatefulWidget {
  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filterStatus = 'All';
  String? _selectedRequestId;

  final List<Map<String, dynamic>> requests = [
    {
      'id': 'REQ-001',
      'user': 'Ahmed Hassan',
      'worker': 'Ali Mohamed',
      'service': 'Cleaning',
      'status': 'Completed',
      'amount': '\$150.00',
      'date': '2025-12-20',
      'location': 'Riyadh, Saudi Arabia',
      'rating': 4.8,
      'description': 'House cleaning service - 3 hours',
      'startTime': '10:00 AM',
      'endTime': '1:00 PM',
    },
    {
      'id': 'REQ-002',
      'user': 'Fatima Ali',
      'worker': 'Sara Ahmed',
      'service': 'Plumbing',
      'status': 'In Progress',
      'amount': '\$200.00',
      'date': '2025-12-26',
      'location': 'Jeddah, Saudi Arabia',
      'rating': null,
      'description': 'Pipe repair and replacement',
      'startTime': '2:00 PM',
      'endTime': '5:00 PM',
    },
    {
      'id': 'REQ-003',
      'user': 'Mohammed Salem',
      'worker': 'Karim Hassan',
      'service': 'Electrical',
      'status': 'Pending',
      'amount': '\$250.00',
      'date': '2025-12-27',
      'location': 'Dammam, Saudi Arabia',
      'rating': null,
      'description': 'Electrical wiring installation',
      'startTime': '9:00 AM',
      'endTime': '3:00 PM',
    },
    {
      'id': 'REQ-004',
      'user': 'Layla Karim',
      'worker': 'Fatima Al-Rashid',
      'service': 'Painting',
      'status': 'Accepted',
      'amount': '\$180.00',
      'date': '2025-12-28',
      'location': 'Medina, Saudi Arabia',
      'rating': null,
      'description': 'Room painting - 2 bedrooms',
      'startTime': '8:00 AM',
      'endTime': '4:00 PM',
    },
    {
      'id': 'REQ-005',
      'user': 'Omar Saleh',
      'worker': null,
      'service': 'Repair',
      'status': 'Cancelled',
      'amount': '\$120.00',
      'date': '2025-12-15',
      'location': 'Mecca, Saudi Arabia',
      'rating': null,
      'description': 'Door lock repair',
      'startTime': '11:00 AM',
      'endTime': '12:00 PM',
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    return requests.where((req) {
      final matchesSearch = req['id'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          req['user'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          req['service'].toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesStatus = _filterStatus == 'All' || req['status'] == _filterStatus;
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
        selectedRoute: '/requests',
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
      body: _selectedRequestId == null ? _buildRequestsList() : _buildRequestDetail(),
    );
  }

  Widget _buildRequestsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Requests Management ', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36, color: Colors.black)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search by Request ID, User, or Service...',
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
                  items: ['All', 'Pending', 'Accepted', 'In Progress', 'Completed', 'Cancelled']
                      .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (val) => setState(() => _filterStatus = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
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
                      Expanded(child: Text('Request ID', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('User', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('Worker', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('Service', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                ...filteredRequests.map((req) => _buildRequestRow(req)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestRow(Map<String, dynamic> req) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
      child: Row(
        children: [
          Expanded(child: Text(req['id'], style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(req['user'], style: TextStyle(fontSize: 13))),
          Expanded(child: Text(req['worker'] ?? 'Unassigned', style: TextStyle(fontSize: 13, color: req['worker'] == null ? Colors.red : Colors.black))),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
              child: Text(req['service'], style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 12)),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(req['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(req['status'], style: TextStyle(color: _getStatusColor(req['status']), fontWeight: FontWeight.w500, fontSize: 12)),
            ),
          ),
          Expanded(child: Text(req['amount'], style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _selectedRequestId = req['id']),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4), backgroundColor: Colors.blue),
              child: Text('View', style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestDetail() {
    final req = requests.firstWhere((r) => r['id'] == _selectedRequestId);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: () => setState(() => _selectedRequestId = null), icon: Icon(Icons.arrow_back)),
              Text('Request Details', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(req['id'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _getStatusColor(req['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(req['status'], style: TextStyle(color: _getStatusColor(req['status']), fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      _buildDetailSection('Basic Information', [
                        {'label': 'Request ID', 'value': req['id']},
                        {'label': 'Service', 'value': req['service']},
                        {'label': 'Amount', 'value': req['amount']},
                        {'label': 'Date', 'value': req['date']},
                      ]),
                      SizedBox(height: 20),
                      _buildDetailSection('Location & Timing', [
                        {'label': 'Location', 'value': req['location']},
                        {'label': 'Start Time', 'value': req['startTime']},
                        {'label': 'End Time', 'value': req['endTime']},
                        {'label': 'Description', 'value': req['description']},
                      ]),
                      SizedBox(height: 20),
                      _buildDetailSection('Participants', [
                        {'label': 'User', 'value': req['user']},
                        {'label': 'Worker', 'value': req['worker'] ?? 'Not Assigned'},
                      ]),
                      if (req['rating'] != null) ...[
                        SizedBox(height: 20),
                        _buildDetailSection('Rating', [
                          {'label': 'Rating', 'value': '${req['rating']} ⭐'},
                        ]),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 300,
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 16),
                      if (req['status'] == 'Pending')
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request accepted'))),
                                icon: Icon(Icons.check),
                                label: Text('Accept Request'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              ),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request cancelled'))),
                                icon: Icon(Icons.close),
                                label: Text('Cancel Request'),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      if (req['status'] == 'Accepted')
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request marked as in progress'))),
                            icon: Icon(Icons.start),
                            label: Text('Start Work'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          ),
                        ),
                      if (req['status'] == 'In Progress')
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request marked as completed'))),
                            icon: Icon(Icons.done),
                            label: Text('Complete Request'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54)),
        SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['label']!, style: TextStyle(color: Colors.black54)),
                  Text(item['value']!, style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            )),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.blue;
      case 'Accepted':
        return Colors.orange;
      case 'Pending':
        return Colors.amber;
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
