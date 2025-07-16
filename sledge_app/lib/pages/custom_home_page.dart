import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// Placeholder components for the different screens, reflecting e-commerce content
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width to make grid responsive
    final double screenWidth = MediaQuery.of(context).size.width;
    // Calculate crossAxisCount dynamically for product grids
    final int productCrossAxisCount = (screenWidth / 180).floor().clamp(2, 4);

    return SingleChildScrollView( // Use SingleChildScrollView for scrollable content
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 0,
      ), // Adjust vertical padding as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16), // Space from the top curved edge
          // 1. Search Bar (similar to Flipkart's prominent search)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!), // Subtle border
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search for products, brands and more',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              style: TextStyle(color: Colors.black87), // Text color for input
            ),
          ),
          const SizedBox(height: 20),

          // 2. Main Carousel/Banner Area
          // Using a PageView for a simple carousel effect
          SizedBox(
            height: screenWidth * 0.45, // Responsive height for banners
            child: PageView.builder(
              itemCount: 3, // Example: 3 banners
              itemBuilder: (context, index) {
                final banners = [
                  'https://placehold.co/600x300/ADD8E6/000000?text=Mega+Sale',
                  'https://placehold.co/600x300/FFDDC1/FF6F00?text=New+Arrivals',
                  'https://placehold.co/600x300/C1FFD1/008000?text=Exclusive+Offers',
                ];
                final bannerText = [
                  'Mega Sale - Up to 70% Off!',
                  'Discover Our Newest Collection!',
                  'Grab Exclusive Offers Now!',
                ];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ), // Small margin between pages
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(banners[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    bannerText[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.white, // Text color for visibility on banners
                      shadows: [
                        Shadow(
                          // Simple text shadow for better readability
                          blurRadius: 3.0,
                          color: Colors.black54,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // 3. Category Icons (Horizontal Scrollable List)
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.0,
            ), // No horizontal padding here as it's for the section title
            child: Text(
              'Top Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Darker text for headings
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100, // Fixed height for the horizontal category list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8, // Example categories
              itemBuilder: (context, index) {
                final categories = [
                  {'label': 'Electronics', 'icon': Icons.laptop_mac},
                  {'label': 'Fashion', 'icon': Icons.shopping_bag},
                  {'label': 'Home', 'icon': Icons.home},
                  {'label': 'Grocery', 'icon': Icons.local_grocery_store},
                  {'label': 'Mobiles', 'icon': Icons.phone_android},
                  {'label': 'Appliances', 'icon': Icons.kitchen},
                  {'label': 'Books', 'icon': Icons.book},
                  {'label': 'Beauty', 'icon': Icons.face},
                ];
                final category = categories[index];
                return GestureDetector(
                  // Make categories tappable
                  onTap: () {
                    // Handle category tap, e.g., navigate to category page
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped on ${category['label']}')),
                    );
                  },
                  child: Container(
                    width: 80, // Fixed width for each category item
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(category['icon'] as IconData,
                              color: Colors.blue.shade700, size: 30),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          category['label'] as String,
                          style: const TextStyle(fontSize: 12, color: Colors.black87),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // 4. Deals of the Day/Recommended Products Section
          const Text(
            'Deals of the Day',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: productCrossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: 4, // Example deals
            itemBuilder: (context, index) {
              final deals = [
                {
                  'name': 'Smartwatch Pro',
                  'price': '\$99',
                  'oldPrice': '\$149',
                  'discount': '33% Off',
                  'image':
                      'https://placehold.co/100x100/FFDDC1/FF6F00?text=Deal+1',
                },
                {
                  'name': 'Wireless Earbuds X',
                  'price': '\$49',
                  'oldPrice': '\$79',
                  'discount': '37% Off',
                  'image':
                      'https://placehold.co/100x100/FFDDC1/FF6F00?text=Deal+2',
                },
                {
                  'name': 'Gaming Mouse RGB',
                  'price': '\$35',
                  'oldPrice': '\$50',
                  'discount': '30% Off',
                  'image':
                      'https://placehold.co/100x100/FFDDC1/FF6F00?text=Deal+3',
                },
                {
                  'name': 'Portable Speaker Mini',
                  'price': '\$60',
                  'oldPrice': '\$85',
                  'discount': '29% Off',
                  'image':
                      'https://placehold.co/100x100/FFDDC1/FF6F00?text=Deal+4',
                },
              ];
              final deal = deals[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  // Make card tappable
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Viewed ${deal['name']}')),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Distribute space
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to start
                      children: [
                        Center(
                          child: Image.network(
                            deal['image']!,
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 96,
                              height: 96,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          deal['name']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '\$${deal['price']!}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green, // Highlight deal price
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '\$${deal['oldPrice']!}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration
                                    .lineThrough, // Strikethrough old price
                              ),
                            ),
                          ],
                        ),
                        Text(
                          deal['discount']!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.green, // Discount percentage color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // You can add more sections here, e.g., "Recommended for You", "New Arrivals" etc.
        ],
      ),
    );
  }
}

// Removed _CategoryChip as it's not directly used in the new ShopPage structure
// If you want to use it for other pages, keep it.

class ShelfScreen extends StatelessWidget {
  const ShelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Shelf / Inventory',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'This section would display items you have in your personal "shelf" or inventory, perhaps for quick re-ordering or tracking.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('• Item 1: Quantity 5',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text('• Item 2: Quantity 12',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text('• Item 3: Out of Stock',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Methods',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Manage your payment methods and view past transactions.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50], // bg-blue-50
              border: Border.all(
                color: Colors.blue.shade200,
              ), // border border-blue-200
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visa **** **** **** 1234',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[800], // text-blue-800
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Expires 12/26',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[700], // text-blue-700
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50], // bg-green-50
              border: Border.all(
                color: Colors.green.shade200,
              ), // border border-green-200
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PayPal Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.green[800], // text-green-800
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Connected',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[700], // text-green-700
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Add new payment method logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600], // bg-blue-600
              foregroundColor: Colors.white, // text-white
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)), // rounded-md
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10), // px-4 py-2
            ),
            child: const Text('Add New Payment Method'),
          ),
        ],
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Orders',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'View your order history and track current orders.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50], // bg-gray-50
              border: Border.all(
                color: Colors.grey.shade200,
              ), // border border-gray-200
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            margin: const EdgeInsets.only(bottom: 12), // mb-3
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #1001 - Delivered',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800], // text-gray-800
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Items: Product A, Product C',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600], // text-gray-600
                  ),
                ),
                Text(
                  'Total: \$31.99',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600], // text-gray-600
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50], // bg-gray-50
              border: Border.all(
                color: Colors.grey.shade200,
              ), // border border-gray-200
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            margin: const EdgeInsets.only(bottom: 12), // mb-3
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #1002 - Processing',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800], // text-gray-800
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Items: Product B',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600], // text-gray-600
                  ),
                ),
                Text(
                  'Total: \$29.50',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600], // text-gray-600
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class YouScreen extends StatelessWidget {
  const YouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Profile',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Manage your account settings, addresses, and preferences.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple[50], // bg-purple-50
              border: Border.all(
                color: Colors.purple.shade200,
              ), // border border-purple-200
              borderRadius: BorderRadius.circular(8), // rounded-lg
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: John Doe',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.purple[800], // text-purple-800
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Email: john.doe@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.purple[700], // text-purple-700
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Edit Profile logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[600], // bg-purple-600
                  foregroundColor: Colors.white, // text-white
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)), // rounded-md
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10), // px-4 py-2
                ),
                child: const Text('Edit Profile'),
              ),
              const SizedBox(width: 8), // mr-2
              ElevatedButton(
                onPressed: () {
                  // Logout logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[500], // bg-red-500
                  foregroundColor: Colors.white, // text-white
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)), // rounded-md
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10), // px-4 py-2
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomHomePage extends StatefulWidget {
  const CustomHomePage({super.key});

  @override
  _CustomHomePageState createState() => _CustomHomePageState();
}

class _CustomHomePageState extends State<CustomHomePage> {
  int _selectedIndex = 0;
  String? _currentAddress;
  bool _isLocating = false;

  final List<Widget> _pages = const [
    ShopPage(), // Corresponds to Vision
    ShelfScreen(), // Corresponds to Support
    PaymentsScreen(), // Corresponds to Services
    OrdersScreen(), // Corresponds to Partners
    YouScreen(), // Corresponds to Login
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePositionAndAddress();
  }

  Future<void> _determinePositionAndAddress() async {
    setState(() {
      _isLocating = true;
    });
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentAddress = 'Location services are disabled.';
        _isLocating = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = 'Location permissions are denied';
          _isLocating = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentAddress = 'Location permissions are permanently denied.';
        _isLocating = false;
      });
      return;
    }

    // When permissions are granted, get the position
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;
    setState(() {
      _currentAddress =
          '${place.street}, ${place.locality}, ${place.administrativeArea}';
      _isLocating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar (dynamically sized with logo)
            Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Added the logo here
                      Image.network(
                        'https://slege.vercel.app/static/media/navBarLogo1.76ad77f941d4c432a0e0.png',
                        height: 120, // Changed from 40 to 60
                        width: 1200, // Changed from 40 to 60
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.image, // Fallback icon
                          color: Color.fromARGB(255, 15, 15, 15),
                          size: 120,
                        ),
                      ),
                      const SizedBox(width: 10), // Space between logo and text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sledje_Mobile',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _isLocating
                                  ? 'Locating...'
                                  : (_currentAddress ??
                                      'Unable to get location'),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            // Notification logic
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4), // Reduced from 8 to 4 to shift up
                  // Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTopNavItem(context, 0, 'Vision', Icons.visibility),
                      _buildTopNavItem(
                          context, 1, 'Support', Icons.support_agent),
                      _buildTopNavItem(
                          context, 2, 'Services', Icons.business_center),
                      _buildTopNavItem(context, 3, 'Partners', Icons.handshake),
                      _buildTopNavItem(context, 4, 'Login', Icons.login),
                    ],
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -30),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: _pages[_selectedIndex],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavItem(
      BuildContext context, int index, String label, IconData icon) {
    final isSelected = index == _selectedIndex;
    return TextButton(
      onPressed: () => _onItemTapped(index),
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.white70,
        textStyle: const TextStyle(fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          Text(label),
        ],
      ),
    );
  }
}
