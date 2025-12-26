import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Commission Settings
  double _commissionPercentage = 10.0;
  
  // App Settings
  bool _maintenanceMode = false;
  bool _enableNotifications = true;
  bool _enableAutoPayment = true;
  String _defaultCurrency = 'SAR';
  
  // Payment Settings
  String _paymentGateway = 'Stripe';
  bool _paypalEnabled = true;
  bool _bankTransferEnabled = true;

  final adminProfile = {
    'name': 'Mohamed Ashraf',
    'email': 'admin@salhly.com',
    'phone': '+966 50 000 0000',
    'avatar': '👨‍💼',
    'joinDate': '2024-01-15',
    'role': 'Super Admin',
    'lastLogin': '2025-12-26 10:30 AM',
  };

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
        selectedRoute: '/settings',
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
            const Text('الإعدادات', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36, color: Colors.black)),
            const SizedBox(height: 32),
            // Admin Profile Section
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🔐 Admin Profile & Auth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Text(adminProfile['avatar']!, style: TextStyle(fontSize: 64)),
                      SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(adminProfile['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(adminProfile['role']!, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
                            SizedBox(height: 12),
                            Text(adminProfile['email']!, style: TextStyle(color: Colors.black54, fontSize: 13)),
                            Text(adminProfile['phone']!, style: TextStyle(color: Colors.black54, fontSize: 13)),
                            SizedBox(height: 8),
                            Text('Last Login: ${adminProfile['lastLogin']}', style: TextStyle(color: Colors.black54, fontSize: 12)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _showChangePasswordDialog(),
                            icon: Icon(Icons.lock),
                            label: Text('Change Password'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: () => _showLogoutDialog(),
                            icon: Icon(Icons.logout),
                            label: Text('Logout'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Commission Settings
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('💰 Commission Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 24),
                  _buildSettingItem(
                    'Commission Percentage',
                    'Percentage charged on each transaction',
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                value: _commissionPercentage,
                                min: 0,
                                max: 50,
                                divisions: 50,
                                onChanged: (value) => setState(() => _commissionPercentage = value),
                              ),
                            ),
                            SizedBox(width: 16),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                              child: Text('${_commissionPercentage.toStringAsFixed(1)}%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16)),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text('Example: If a service costs \$100, the platform will earn \$${(_commissionPercentage).toStringAsFixed(2)}', style: TextStyle(color: Colors.black54, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // App Settings
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('⚙️ App Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 24),
                  _buildToggleSetting('Maintenance Mode', 'Take the app offline for maintenance', _maintenanceMode, (value) {
                    setState(() => _maintenanceMode = value);
                  }),
                  Divider(),
                  _buildToggleSetting('Enable Notifications', 'Send push notifications to users', _enableNotifications, (value) {
                    setState(() => _enableNotifications = value);
                  }),
                  Divider(),
                  _buildToggleSetting('Enable Auto Payment', 'Automatically pay workers weekly', _enableAutoPayment, (value) {
                    setState(() => _enableAutoPayment = value);
                  }),
                  Divider(),
                  _buildDropdownSetting('Default Currency', 'Select default currency', _defaultCurrency, ['SAR', 'AED', 'KWD', 'QAR', 'USD'], (value) {
                    setState(() => _defaultCurrency = value);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Payment Settings
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('💳 Payment Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 24),
                  _buildDropdownSetting('Primary Payment Gateway', 'Select payment gateway', _paymentGateway, ['Stripe', 'PayPal', 'Bank Transfer'], (value) {
                    setState(() => _paymentGateway = value);
                  }),
                  Divider(),
                  _buildToggleSetting('Enable PayPal', 'Allow PayPal payments', _paypalEnabled, (value) {
                    setState(() => _paypalEnabled = value);
                  }),
                  Divider(),
                  _buildToggleSetting('Enable Bank Transfer', 'Allow bank transfer payments', _bankTransferEnabled, (value) {
                    setState(() => _bankTransferEnabled = value);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Save Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Settings saved successfully!'))),
                  icon: Icon(Icons.save),
                  label: Text('Save Settings'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String label, String description, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 4),
        Text(description, style: TextStyle(color: Colors.black54, fontSize: 12)),
        SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildToggleSetting(String label, String description, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 4),
            Text(description, style: TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _buildDropdownSetting(String label, String description, String value, List<String> items, Function(String) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 4),
            Text(description, style: TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
          child: DropdownButton<String>(
            value: value,
            underline: SizedBox(),
            items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: (val) => onChanged(val!),
          ),
        ),
      ],
    );
  }

  void _showChangePasswordDialog() {
    final currentPassword = TextEditingController();
    final newPassword = TextEditingController();
    final confirmPassword = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: currentPassword, obscureText: true, decoration: InputDecoration(labelText: 'Current Password')),
            SizedBox(height: 12),
            TextField(controller: newPassword, obscureText: true, decoration: InputDecoration(labelText: 'New Password')),
            SizedBox(height: 12),
            TextField(controller: confirmPassword, obscureText: true, decoration: InputDecoration(labelText: 'Confirm Password')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password changed successfully!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text('Change Password'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out successfully!')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
