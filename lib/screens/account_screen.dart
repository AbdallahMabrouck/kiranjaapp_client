import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            // Replace with the user's profile picture
            backgroundImage: AssetImage('assets/profile_picture.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            'John Doe', // Replace with the user's name
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Phone Number: +1 123-456-7890', // Replace with the user's phone number
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          const Text(
            'Email: john.doe@example.com', // Replace with the user's email address
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    // Navigate to Home page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.favorite,
                  title: 'My Favorites',
                  onTap: () {
                    // Navigate to My Favorites page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.shopping_cart,
                  title: 'My Orders',
                  onTap: () {
                    // Navigate to My Orders page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.account_balance_wallet,
                  title: 'My Wallet',
                  onTap: () {
                    // Navigate to My Wallet page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.store,
                  title: 'My Following Stores',
                  onTap: () {
                    // Navigate to My Following Stores page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.info,
                  title: 'About Us',
                  onTap: () {
                    // Navigate to About Us page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy',
                  onTap: () {
                    // Navigate to Privacy Policy page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    // Navigate to Settings page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    // Perform logout action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
