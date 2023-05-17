import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sirketmanisa/login/register.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/giris.dart';
import '../screens/page1.dart';
import 'forgotpassword.dart';

class LoginPage extends StatefulWidget {
  final Function showRegisterPage;

  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _passwordController = TextEditingController();
  late AnimationController _animatedController;
  late Animation<double> _animation;
  bool _isVisible = false;

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  Future<bool> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Giriş başarılı olduğunda yapılması gereken işlemleri buraya ekleyebilirsiniz.
      print("Giriş Başarılı! Kullanıcı ID: ${userCredential.user!.uid}");
      return true;
    } catch (e) {
      // Giriş sırasında bir hata oluşursa burada yakalayabilir ve kullanıcıya bildirebilirsiniz.
      print("Giriş Hatası: $e");
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animatedController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animatedController =
        AnimationController(vsync: this, duration: Duration(seconds: 15));
    _animation = CurvedAnimation(
      parent: _animatedController,
      curve: Curves.linear,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          _animatedController.reset();
          _animatedController.forward();
        }
      });
    _animatedController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
          CachedNetworkImage(
          imageUrl:
          "https://i.pinimg.com/564x/81/db/9f/81db9f703de0ec7e79919174623f3d9e.jpg",
          errorWidget: (context, url, error) => Icon(Icons.error),
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
          alignment: FractionalOffset(_animation.value, 0),
        ),
        Center(
            child: SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(height: 12),
    Text(
    "Hello Again! ",
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue.shade900,
    ),
    ),
    SizedBox(height: 20),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextFormField(
    keyboardType: TextInputType.emailAddress,
    controller: _emailController,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
    prefixIcon: Icon(
    Icons.email_outlined,
    color: Colors.grey,
    ),
    border: InputBorder.none,
    filled: true,
    fillColor: Colors.white,
    hintText: "Email",
    hintStyle: TextStyle(color: Colors.black),
    enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black87),
    ),
    focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
    ),
    errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    ),
    ),
    ),
    ),
    SizedBox(height: 12),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextFormField(
    obscureText: !_isVisible,
    inputFormatters: [
    FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
    ],
    validator: (value) {
    if (value!.isEmpty || value.length < 8) {
    return 'Please Enter a valid password';
    }
    return null;
    },
    controller: _passwordController,
    style: TextStyle(color: Colors.black87),
    decoration: InputDecoration(
    prefixIcon: Icon(
    Icons.lock,
    color: Colors.grey,
    ),
    filled: true,
    fillColor: Colors.white,
    hintText: "Password",
    hintStyle: TextStyle(color: Colors.black),
    enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
    ),
    errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    ),
    suffixIcon: IconButton(
    color: Colors.blueGrey,
    onPressed: () => updateStatus(),
    icon: Icon(
    _isVisible ? Icons.visibility : Icons.visibility_off,
    ),
    ),
    ),
    ),
    ),
    SizedBox(height: 12),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: GestureDetector(
    onTap: () async {
    bool isLoggedIn = await login();
    if (isLoggedIn) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => HomePage(),
    ),
    );
    } else {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Incorrect email or password'),
    ),
    );
    }
    },
    child: Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: Colors.blue.shade800,
    borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
    'Sign In',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Colors.white,
    ),
    ),
    ),
    ),
    ),
    SizedBox(height: 12),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
    "Not a member? ",
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
    ),
    ),
    TextButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => RegisterPage(),
    ),
    );
    },
    child: Text(
    "Register now",
    style: TextStyle(
    fontSize: 15,
    color: Colors.blue.shade900,
    ),
    ),
    ),
    ],    ),
          SizedBox(
            height: 12,
          ),
        ],
        ),
        ),
            ),
            ),
        ),
          ],
        ),
    );
  }
}
