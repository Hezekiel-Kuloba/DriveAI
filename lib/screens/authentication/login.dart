import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_car_app/screens/authentication/register.dart';
import 'package:new_car_app/utilis/user.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // Controller for the birthday text field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05), // Reduced spacing
            Center(
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/animations/moving_car.json',
                    // height: (size.height * 0.5), // Reduced height
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5.0),

            // Email TextField
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email',
                helperText: 'A valid email e.g. joe.doe@gmail.com',
                border: UnderlineInputBorder(), // Bottom border only
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20.0),

            // Password TextField
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility_off),
                helperText:
                    'At least 8 characters including one letter and number',
                labelText: 'Password',
                border: UnderlineInputBorder(), // Bottom border only
              ),
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: 20.0),

            // Login Button with increased height
            ElevatedButton(
              onPressed: () async {
                try {
                  final successMessage =
                      await ref.read(userProvider.notifier).login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                  // Show success dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text(successMessage), // Show success message
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                              Navigator.pushReplacementNamed(
                                  context, '/'); // Navigate to home screen
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  // Show error dialog if sign-up failed
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(e.toString()), // Show error message
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60), // Increased height
              ),
              child: const Text('Sign Up'),
            ),

            // Forgot Password with underline and black color
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Forgot password logic placeholder
                },
                child: const Text(
                  'Forgot password ?',
                  style: TextStyle(
                    // decoration: TextDecoration.underline,
                    fontWeight: FontWeight
                        .bold, // Change to desired weight (e.g., bold, normal)
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            // Or login with providers
            const Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('or login with'),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),

            const SizedBox(height: 20.0),

            // Social Login Buttons (Google, Apple, Facebook)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Google Login
                IconButton(
                  onPressed: () {
                    // Google login logic placeholder
                  },
                  icon: SvgPicture.asset('assets/icons/icons8-google.svg'),
                  iconSize: 32.0,
                ),

                // Apple Login
                IconButton(
                  onPressed: () {
                    // Apple login logic placeholder
                  },
                  icon: SvgPicture.asset('assets/icons/icons8-apple.svg'),
                  iconSize: 32.0,
                ),

                // Facebook Login
                IconButton(
                  onPressed: () {
                    // Facebook login logic placeholder
                  },
                  icon: SvgPicture.asset('assets/icons/icons8-facebook.svg'),
                  iconSize: 32.0,
                ),
              ],
            ),

            const SizedBox(height: 40.0),

            // Register Link with underline and black color
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      // decoration: TextDecoration.underline,

                      fontWeight: FontWeight
                          .bold, // Change to desired weight (e.g., bold, normal)
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
