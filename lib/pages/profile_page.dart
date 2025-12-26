import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_kuliah_mwsp_uts_kel4/components/sidebar.dart';
import 'package:project_kuliah_mwsp_uts_kel4/pages/messages_page.dart';
import 'package:project_kuliah_mwsp_uts_kel4/pages/detail_page.dart';
import 'package:project_kuliah_mwsp_uts_kel4/pages/store_locations_page.dart';
import 'package:project_kuliah_mwsp_uts_kel4/services/user_service.dart';
import 'package:project_kuliah_mwsp_uts_kel4/models/product.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotateController;
  bool showCallSection = false;
  String _username = 'Loading...';
  String _email = 'Loading...';
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final username = await _userService.getUsername();
    final email = await _userService.getEmail();
    setState(() {
      _username = username ?? 'Guest';
      _email = email ?? 'No email';
    });
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(74, 55, 73, 1),
      drawer: const SideBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔹 App Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        "Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // 🔹 Profile Avatar
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 1.6,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 1.3,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromRGBO(225, 207, 167, 1),
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/avatar/5.jpg"),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(125, 91, 124, 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        "456 Pts",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),
              Text(
                _username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.circle, size: 10, color: Colors.green),
                  SizedBox(width: 6),
                  Text(
                    "London, England",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // 🔹 Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _circleAction(
                      svgPath: 'assets/images/svg/icons/call_icon.svg',
                      color: const Color(0xFF44474F),
                      isActive: showCallSection,
                      onTap: () {
                        setState(() {
                          showCallSection = true;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    // 🔸 MAP ICON → Navigasi ke StoreLocationsPage
                    _circleAction(
                      svgPath: 'assets/images/svg/icons/locate_icon.svg',
                      color: const Color(0xFF44474F),
                      onTap: () {
                        setState(() {
                          showCallSection = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StoreLocationsPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _circleAction(
                      svgPath: 'assets/images/svg/icons/mail_icon.svg',
                      color: const Color(0xFF44474F),
                      onTap: () {
                        setState(() {
                          showCallSection = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MessagesPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _circleAction(
                      svgPath: 'assets/images/svg/icons/pen_icon.svg',
                      color: showCallSection
                          ? const Color(0xFF44474F)
                          : Colors.white,
                      background: showCallSection
                          ? Colors.white
                          : const Color.fromRGBO(156, 156, 156, 0.5),
                      onTap: () {
                        setState(() {
                          showCallSection = false;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Bottom Section
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: showCallSection
                    ? _buildCallSection(context)
                    : _buildFavouriteMenus(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔸 Action Circle
  Widget _circleAction({
    required String svgPath,
    Color? color,
    Color background = Colors.white,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromRGBO(156, 156, 156, 0.5)
              : background,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            svgPath,
            color: isActive ? Colors.white : color,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }

  // 🔹 Profile Info Section
  Widget _buildFavouriteMenus(BuildContext context) {
    return Container(
      key: const ValueKey('favourite'),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 260,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profile Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  onPressed: () => _showEditProfileDialog(context),
                  icon: const Icon(
                    Icons.edit,
                    color: Color(0xFF4A3749),
                    size: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              icon: Icons.person_outline,
              label: "Username",
              value: _username,
            ),
            const SizedBox(height: 15),
            _buildInfoCard(
              icon: Icons.email_outlined,
              label: "Email",
              value: _email,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 🔹 Info Card Widget
  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF4A3749).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF4A3749), size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Edit Profile Dialog
  void _showEditProfileDialog(BuildContext context) {
    final usernameController = TextEditingController(text: _username);
    final emailController = TextEditingController(text: _email);
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool obscurePassword = true;
    bool obscureConfirm = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: bottomInset + 16),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A3749),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: "Username",
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF4A3749),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF4A3749),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: "Password (Optional)",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF4A3749),
                              width: 2,
                            ),
                          ),
                          hintText: "Leave empty to keep current password",
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: obscureConfirm,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureConfirm = !obscureConfirm;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF4A3749),
                              width: 2,
                            ),
                          ),
                          hintText: "Required only if changing your password",
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: const BorderSide(
                                  color: Color(0xFF4A3749),
                                ),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Color(0xFF4A3749),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                print('=== PROFILE UPDATE STARTED ===');
                                // Show loading
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFF4A3749),
                                      ),
                                    );
                                  },
                                );

                                try {
                                  // Validate password confirmation when provided
                                  if (passwordController.text.isNotEmpty &&
                                      passwordController.text !=
                                          confirmPasswordController.text) {
                                    // Close loading dialog
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Password confirmation does not match.',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  // Get user ID
                                  final userId = await _userService.getUserId();
                                  print('Retrieved userId: $userId');

                                  if (userId != null && userId.isNotEmpty) {
                                    print('Calling updateUser API...');
                                    // Update via backend API
                                    await _userService.updateUser(
                                      userId: userId,
                                      username: usernameController.text,
                                      email: emailController.text,
                                      password:
                                          passwordController.text.isNotEmpty
                                          ? passwordController.text
                                          : null,
                                    );
                                    print('API call completed');
                                  } else {
                                    print(
                                      'No userId found, saving locally only',
                                    );
                                    // If no userId, just save locally
                                    await _userService.saveUserData(
                                      username: usernameController.text,
                                      email: emailController.text,
                                    );
                                  }

                                  // Update state
                                  setState(() {
                                    _username = usernameController.text;
                                    _email = emailController.text;
                                  });

                                  // Close loading dialog
                                  Navigator.pop(context);
                                  // Close edit dialog
                                  Navigator.pop(context);

                                  // Show success message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Profile updated successfully!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } catch (e) {
                                  print('ERROR: $e');
                                  // Close loading dialog
                                  Navigator.pop(context);

                                  // Show error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to update profile: $e',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4A3749),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // 🔹 Call Section
  Widget _buildCallSection(BuildContext context) {
    return Container(
      key: const ValueKey('callSection'),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 260,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          _phoneCard("123 456 7890"),
          const SizedBox(height: 15),
          _phoneCard("987 654 3210"),
        ],
      ),
    );
  }

  Widget _phoneCard(String number) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(74, 55, 73, 1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.call, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 15),
          Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Color.fromRGBO(6, 195, 106, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "CALL",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Menu Item Widget (klik menuju DetailPage)
  Widget _menuItem({
    required BuildContext context,
    required String image,
    required String title,
    required String category,
    required String price,
    required String rating,
  }) {
    return GestureDetector(
      onTap: () {
        final p = Product(
          id: '-',
          name: title,
          description: '',
          category: category,
          price:
              double.tryParse(price.replaceAll(RegExp(r'[^0-9\.]'), '')) ?? 0.0,
          imageUrl: '',
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(product: p)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(156, 156, 156, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        'assets/images/svg/icons/star_icon.svg',
                        color: const Color.fromRGBO(74, 55, 73, 1),
                        width: 18,
                        height: 18,
                      ),
                      Text(
                        rating,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
