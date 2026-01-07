import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ================= الصفحة الرئيسية =================
class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),

      // ================= AppBar =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const CircleAvatar(
          backgroundImage: AssetImage("images/photo.jpg"),
        ),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 12),
          Icon(Icons.description_outlined),
          SizedBox(width: 12),
          Icon(Icons.qr_code),
          SizedBox(width: 8),
        ],
      ),

      drawer: const AppDrawer(),

      // ================= Body =================
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ===== كرت الرصيد =====
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8D9C4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.remove_red_eye_outlined,
                      color: Colors.blueGrey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("رصيدي ري",
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14)),
                        SizedBox(height: 6),
                        Text(
                          "******",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.account_balance_wallet,
                      color: Colors.orange, size: 32),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== بانر الإعلان =====
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xFFF26522),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "مع ون كاش\nكل فواتيرك\nبين يدك",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 10,
                    child: Icon(
                      Icons.phone_android,
                      size: 110,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // ===== نقاط السلايدر =====
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                    (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == 1 ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == 1
                        ? Colors.orange
                        : Colors.orange.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== كرت كريم =====
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.card_giftcard,
                        color: Colors.orange, size: 30),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("كريم",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text("أنت كريم وهم يستاهلوا!"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F3C88),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("أكرمهم الآن"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== شبكة الخدمات =====
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: const [
                _ServiceItem(Icons.download, "استلام حوالة"),
                _ServiceItem(Icons.swap_horiz, "تحويل أموال"),
                _ServiceItem(Icons.receipt_long, "فواتير ومدفوعات"),
                _ServiceItem(Icons.store, "دفع مشتريات وخدمات"),
                _ServiceItem(Icons.phone_android, "شحن رصيد وباقات"),
                _ServiceItem(Icons.support_agent, "خدمات أخرى"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ================= عنصر الخدمة =================
class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const _ServiceItem(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF1F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.orange),
          const SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// ================= Drawer مع اختيار صورة =================
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            color: const Color(0xFF1F3C88),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // ✅ عند الضغط على الصورة، يفتح المعرض
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : null,
                        child: _selectedImage == null
                            ? const Icon(Icons.person,
                            size: 35, color: Colors.grey)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("سياف القرضي",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("775088975",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("حساب مفعل"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                _DrawerItem(Icons.person, "بيانات الحساب"),
                _DrawerItem(Icons.shield, "الحماية"),
                _DrawerItem(Icons.lock, "الخصوصية"),
                _DrawerItem(Icons.person_add, "دعوة صديق"),
                _DrawerItem(Icons.trending_up, "عرض السقوف"),
                _DrawerItem(Icons.description, "الأحكام والشروط"),
                _DrawerItem(Icons.location_on, "أماكننا"),
                _DrawerItem(Icons.call, "تواصل معنا"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const _DrawerItem(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
