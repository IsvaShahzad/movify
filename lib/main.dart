import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello/screens/detail_screen.dart';
import 'package:hello/screens/youtube_widget.dart';
import 'screens/mainpage_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: '',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _emailError;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Replace this with your image widget
          Image.asset(
            'assets/images/poster2.png', // Replace with your image asset path
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Unlimited movies, TV shows and beyond',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Watch anytime, Anywhere',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 60),
                    child: Text(
                      'Ready to watch? Enter your email to get started.',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: 390,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[400]?.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: 'Montserrat',
                            ),
                            errorText: _emailError,
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                            ),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!isValidEmail(value)) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (_emailError != null && isValidEmail(value)) {
                              setState(() {
                                _emailError = null;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageScreen()),
                        );
                      } else {
                        // Show error message inside the text field
                        setState(() {
                          _emailError = 'Invalid email format';
                        });
                      }
                    },
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[500],
                      fixedSize: Size(180, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageScreen()),
          );
        },
        child: const Icon(Icons.navigate_next_sharp),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Updated email validation using regex
    String emailRegex =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$'; // Require at least 2 characters for domain
    return RegExp(emailRegex).hasMatch(email);
  }
}
