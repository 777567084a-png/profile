import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';

/// ================= حالات الواجهة =================
enum LoginView {
  register,  // أول مرة فقط (اسم + رقم)
  pin,       // الصورة الأولى
  phone,     // الصورة الثانية
  resetPin,  // الصورة الثالثة
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginView currentView = LoginView.register;

  String savedPhone = "";
  String savedName = "";

  final TextEditingController phoneCon = TextEditingController();
  final TextEditingController nameCon = TextEditingController();

  final List<TextEditingController> pinControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> pinFocus =
  List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  /// ================= التحقق أول مرة =================
  Future<void> _checkUser() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("phone")) {
      currentView = LoginView.register;
    } else {
      savedPhone = prefs.getString("phone")!;
      savedName = prefs.getString("name")!;
      currentView = LoginView.pin;
    }

    setState(() {});
  }

  /// ================= تسجيل أول مرة =================
  Future<void> _register() async {
    if (nameCon.text.isEmpty || phoneCon.text.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", nameCon.text);
    await prefs.setString("phone", phoneCon.text);

    savedName = nameCon.text;
    savedPhone = phoneCon.text;

    setState(() => currentView = LoginView.pin);
  }

  /// ================= تسجيل دخول =================
  Future<void> _login() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(username: savedName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      currentView == LoginView.pin ? const Color(0xFFF26522) : Colors.white,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildCurrentView(),
        ),
      ),
    );
  }

  /// ================= اختيار الواجهة =================
  Widget _buildCurrentView() {
    switch (currentView) {
      case LoginView.register:
        return _registerScreen();
      case LoginView.pin:
        return _pinScreen();
      case LoginView.phone:
        return _phoneLoginScreen();
      case LoginView.resetPin:
        return _resetPinScreen();
    }
  }

  /// ================= شاشة التسجيل (أول مرة) =================
  Widget _registerScreen() {
    return Padding(
      key: const ValueKey("register"),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          _topBarColored(),

          const SizedBox(height: 60),

          TextField(
            controller: nameCon,
            decoration: _inputStyle("الاسم الكامل"),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: phoneCon,
            keyboardType: TextInputType.phone,
            decoration: _inputStyle("رقم الهاتف"),
          ),

          const Spacer(),

          ElevatedButton(
            onPressed: _register,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF26522),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("تسجيل",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }

  /// ================= الصورة الأولى =================
  Widget _pinScreen() {
    return Padding(
      key: const ValueKey("pin"),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          _topBar(),

          const SizedBox(height: 40),

          const Text("رقم الموبايل",
              style: TextStyle(color: Colors.white, fontSize: 18)),

          const SizedBox(height: 5),

          Text(savedPhone,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),

          const SizedBox(height: 25),

          const Text("أدخل الرمز السري",
              style: TextStyle(color: Colors.white)),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (i) => _pinBox(i)),
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => currentView = LoginView.resetPin);
                },
                child: const Text("نسيت الرمز السري",
                    style: TextStyle(color: Colors.white)),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => currentView = LoginView.phone);
                },
                child: const Text("الدخول بحساب آخر",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),

          const Spacer(),

          GestureDetector(
            onTap: _login,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.fingerprint,
                  color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= الصورة الثانية =================
  Widget _phoneLoginScreen() {
    return Padding(
      key: const ValueKey("phone"),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          _topBarColored(),

          const SizedBox(height: 60),

          const Text(
            "أدخل رقم الموبايل",
            style: TextStyle(
                color: Color(0xFFF26522),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: phoneCon,
            keyboardType: TextInputType.phone,
            decoration: _inputStyle("7xxxxxxxx"),
          ),

          const Spacer(),

          ElevatedButton(
            onPressed: () {
              setState(() => currentView = LoginView.pin);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("التالي"),
          ),

          TextButton(
            onPressed: () {
              setState(() => currentView = LoginView.pin);
            },
            child: const Text("رجوع"),
          ),
        ],
      ),
    );
  }

  /// ================= الصورة الثالثة =================
  Widget _resetPinScreen() {
    return Padding(
      key: const ValueKey("reset"),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          _topBarColored(),

          const SizedBox(height: 60),

          const Text(
            "أدخل رقم الهوية",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextField(
            decoration: _inputStyle("رقم الهوية"),
          ),

          const SizedBox(height: 15),

          const Text(
            "يرجى إدخال نفس رقم الهوية التي استخدمت أثناء التسجيل.",
            style: TextStyle(color: Colors.grey),
          ),

          const Spacer(),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("التالي"),
          ),

          TextButton(
            onPressed: () {
              setState(() => currentView = LoginView.pin);
            },
            child: const Text("رجوع"),
          ),
        ],
      ),
    );
  }

  /// ================= عناصر مساعدة =================
  Widget _pinBox(int i) {
    return SizedBox(
      width: 45,
      height: 55,
      child: TextField(
        controller: pinControllers[i],
        focusNode: pinFocus[i],
        maxLength: 1,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        onChanged: (v) {
          if (v.isNotEmpty && i < 3) {
            pinFocus[i + 1].requestFocus();
          }
        },
      ),
    );
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text("English", style: TextStyle(color: Colors.white)),
        Icon(Icons.account_balance_wallet, color: Colors.white),
      ],
    );
  }

  Widget _topBarColored() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text("English", style: TextStyle(color: Color(0xFFF26522))),
        Icon(Icons.account_balance_wallet, color: Color(0xFFF26522)),
      ],
    );
  }
}
