import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gift_app/widgets/jwtGen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/colors/main_colors.dart';
import '../data/icons.dart';
import '../utils/get_widget_coordinates.dart';
import '../widgets/transition_clipper.dart';
import 'distribution_page.dart';
import 'register_page.dart';

class SwingAnimation extends StatefulWidget {
  const SwingAnimation({super.key});

  @override
  _SwingAnimationState createState() => _SwingAnimationState();
}

class _SwingAnimationState extends State<SwingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: -0.2, end: 0.2).animate(_controller);

    _startSwing();
  }

  void _startSwing() async {
    while (true) {
      // Поворот от -0.2 до 0
      await _controller.animateTo(0.5);
      await Future.delayed(const Duration(seconds: 3));

      // Поворот от 0 до 0.2
      await _controller.animateTo(1.0);
      // await Future.delayed(const Duration(seconds: 1));

      // Поворот от 0.2 до 0
      await _controller.animateTo(0.5);
      await Future.delayed(const Duration(seconds: 3));

      // Поворот от 0 до -0.2
      await _controller.animateTo(0.0);
      // await Future.delayed(const Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child){
          return Transform.rotate(
            angle: _animation.value,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: SizedBox(
                    width: screenSize.width - 100,
                    height: screenSize.height/ 3,
                    child: Image.asset('lib/assets/pictures/mini_logo_var_3.png', fit: BoxFit.contain, color: Colors.black.withOpacity(0.9),),
                  ),
                ),
                SizedBox(
                  width: screenSize.width - 100,
                  height: screenSize.height/ 3,
                  child: Image.asset('lib/assets/pictures/mini_logo_var_3.png', fit: BoxFit.contain,),
                ),
              ],
            )
          );
        }
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: const LoginPageCreateState(),
        ),
        // body: LoginPageCreateState(),
      ),
    );
  }
}

class LoginPageCreateState extends StatefulWidget {
  const LoginPageCreateState({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageCreateState>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _key = GlobalKey();
  String _email = '';
  String _password = '';
  List<String> password = ['123', '321', '1234', 'abc'];
  OverlayEntry? overlayEntry;
  final _passwordController = TextEditingController();
  final _loginController = TextEditingController();
  Offset? widgetCoordinates;
  bool _obscureText = true;
  final FocusNode _focusEmailNode = FocusNode();
  final FocusNode _focusPasswordNode = FocusNode();

  void _showEmailHint(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            GestureDetector(
              onTap: () {
                _closeOverlay();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: screenSize.width/2,
              bottom: screenSize.height - widgetCoordinates!.dy + 7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: accentLightColor,
                    child: const Text('Формат e-mail:\n'
                        'name@example.ru', style: TextStyle(color: Colors.black, fontSize: 15)),
                  ),
                ),
              ),
            ),
          ],
        )
      );

      Overlay.of(context).insert(overlayEntry!);
    }
    else {
      _closeOverlay();
    }
  }

  void _closeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void _togglePasswordVisible(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateLoginOrEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите логин или e-mail';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    return null;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red, duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _submitForm() async {
    _focusEmailNode.unfocus();
    _focusPasswordNode.unfocus();
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      if (_loginController.text == 'admin' && _passwordController.text == 'admin') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);
        Timer(const Duration(milliseconds: 150), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Вход выполнен как администратор!'), backgroundColor: Colors.green),
          );
          Navigator.of(context).pushReplacement(_createRoute());
        });
      } else {
        _showError('Неверный логин или пароль');
      }
    }
  }

  Route _createRoute(){
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => const DistributionPage(),
      transitionDuration: const Duration(milliseconds: 2000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var screenSize = MediaQuery.sizeOf(context);
        var centerCircleClipper = Offset(screenSize.width / 2, screenSize.height / 2 - 200);

        double beginRadius = 0.0;
        double endRadius = screenSize.height*1.2;

        var radiusTween = Tween(begin: beginRadius, end: endRadius);
        var radiusTweenAnimation = animation.drive(radiusTween);

        return ClipPath(
          clipper: TransitionClipper(
            centerCircleClipper,
            radiusTweenAnimation.value,
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    return MaterialApp(
      title: 'Login page',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryLightColor,
        primaryColor: accentLightColor,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: ironManMetal,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: accentBlueColor, width: 2),
          ),
          labelStyle: TextStyle(color: accentGoldColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(accentGoldColor),
            foregroundColor: MaterialStatePropertyAll(ironManRed),
            overlayColor: MaterialStatePropertyAll(accentBlueColor.withOpacity(0.2)),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: accentBlueColor, width: 2),
              ),
            ),
            elevation: MaterialStatePropertyAll(6),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: accentGoldColor),
          titleLarge: TextStyle(color: accentBlueColor, fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.75, 1],
              colors: [ironManMetal, ironManRed, accentGoldColor],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 0.75, 1],
                    colors: [ironManMetal, accentLightColor.withOpacity(0.7), accentGoldColor,]
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SVG-логотип. Замените путь на свой SVG-файл
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 24),
                    child: SvgPicture.asset(
                      'lib/assets/mike_oxlong.svg', // Исправленный путь
                      height: 525,
                      width: 525,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: screenSize.width - 100,
                              height: 56,
                              child: TextFormField(
                                controller: _loginController,
                                decoration: InputDecoration(labelText: 'Логин или e-mail',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: accentLightColor
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.red
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: accentLightColor
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: accentLightColor
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      widgetCoordinates = getWidgetCoordinates(_key);
                                      _showEmailHint(context);
                                    },
                                    icon: Image.asset(questionIcon),
                                    key: _key,
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                                validator: _validateLoginOrEmail,
                                onSaved: (value) {
                                  _email = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                focusNode: _focusEmailNode,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            SizedBox(
                              width: screenSize.width - 100,
                              height: 56,
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Пароль',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: accentLightColor
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.red
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: accentLightColor
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: accentLightColor
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _togglePasswordVisible();
                                      },
                                      icon: _obscureText
                                          ? Image.asset(eyeIcon)
                                          : Image.asset(eyeOffIcon)
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                                validator: _validatePassword,
                                onSaved: (value) {
                                  _password = value!;
                                },
                                autocorrect: false,
                                obscureText: _obscureText,
                                focusNode: _focusPasswordNode,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: screenSize.width - 100,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF6F1FB),
                                  foregroundColor: Colors.black,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(color: accentLightColor, width: 2),
                                  ),
                                ),
                                onPressed: _submitForm,
                                child: const Text('Вход', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: screenSize.width - 100,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8E97FD),
                                  foregroundColor: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(color: accentLightColor, width: 2),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                                  );
                                },
                                child: const Text('Регистрация', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            // Защитный отступ снизу
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}