import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_car_app/main.dart';
import 'package:new_car_app/utilis/user.dart'; // For formatting the date

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // Controller for the birthday text field
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Register')),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              MaterialPageRoute(
                builder: (context) =>
                    const MainScreen(), // Navigate to your screen
              );
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
                    height: size.height * 0.25, // Adjusted height
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5.0),

            // Username TextField
            TextFormField(
              controller: _firstnameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Firstname',
                helperText: 'Enter your firstname',
                border: UnderlineInputBorder(), // Bottom border only
              ),
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: 20.0),
            TextFormField(
              controller: _lastnameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Lastname',
                helperText: 'Enter your lastname',
                border: UnderlineInputBorder(), // Bottom border only
              ),
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: 20.0),

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

            // Phone Number TextField
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                labelText: 'Phone Number',
                helperText: 'Enter your phone number',
                border: UnderlineInputBorder(), // Bottom border only
              ),
              keyboardType: TextInputType.phone,
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

            // Confirm Password TextField
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility_off),
                labelText: 'Confirm Password',
                border: UnderlineInputBorder(), // Bottom border only
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),

            const SizedBox(height: 20.0),

            // Sign Up Button with increased height
            // Sign Up Button with increased height
            // In your SignUpScreen widget
            ElevatedButton(
              onPressed: () async {
                try {
                  final successMessage =
                      await ref.read(userProvider.notifier).signUp(
                            firstname: _firstnameController.text,
                            lastname: _lastnameController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneController.text,
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

            const SizedBox(height: 20.0),

            // Or sign up with providers
            const Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('or sign up with'),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),

            const SizedBox(height: 20.0),

            // Social Sign Up Buttons (Google, Apple, Facebook)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Google Sign Up
                IconButton(
                  onPressed: () {
                    // Google sign up logic placeholder
                  },
                  icon: SvgPicture.asset('assets/icons/icons8-google.svg'),
                  iconSize: 32.0,
                ),

                // Apple Sign Up
                IconButton(
                  onPressed: () {
                    // Apple sign up logic placeholder
                  },
                  icon: SvgPicture.asset('assets/icons/icons8-apple.svg'),
                  iconSize: 32.0,
                ),

                // Facebook Sign Up
                IconButton(
                  onPressed: () {
                    // Facebook sign up logic placeholder
                  },
                  icon: SvgPicture.asset('assets/icons/icons8-facebook.svg'),
                  iconSize: 32.0,
                ),
              ],
            ),

            const SizedBox(height: 40.0),

            // Login Link with underline and black color
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the login screen
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
