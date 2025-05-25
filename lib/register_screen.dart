import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart'; // Import GradientScaffold
import 'courses_data.dart'; // Import your courses data model
import 'package:flutter/services.dart'; // For FilteringTextInputFormatter

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _usnController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _semesterController = TextEditingController();
  final _branchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> branches = [
    'Computer Science and Engineering',
    'Electronics and Communication Engineering',
    'Electrical Engineering',
    'Mechanical Engineering',
    'Chemical Engineering',
    'Civil Engineering',
  ];

  final List<int> semesters = [1, 2, 3, 4, 5, 6, 7, 8];

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            );

        // Store additional info in Firestore
        await FirebaseFirestore.instance
            .collection('students')
            .doc(userCredential.user!.uid)
            .set({
              'name': _nameController.text,
              'usn': _usnController.text,
              'email': _emailController.text,
              'semester': int.tryParse(_semesterController.text) ?? 0,
              'branch': _branchController.text,
            });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful. Now please login.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Register',
            style: TextStyle(color: theme.colorScheme.onPrimary),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.onPrimary.withOpacity(0.3),
                  ),
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // USN field
                TextFormField(
                  controller: _usnController,
                  decoration: InputDecoration(
                    labelText: 'USN',
                    labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.onPrimary.withOpacity(0.3),
                  ),
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your USN';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.onPrimary.withOpacity(0.3),
                  ),
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Semester field (integer only)
                DropdownButtonFormField<int>(
                  value:
                      int.tryParse(_semesterController.text) != null
                          ? int.parse(_semesterController.text)
                          : null,
                  decoration: InputDecoration(
                    labelText: 'Semester',
                    labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.indigo[900], // <-- dark blue background
                  ),
                  dropdownColor:
                      Colors.indigo[900], // <-- dark blue dropdown menu
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                  items:
                      semesters.map((sem) {
                        return DropdownMenuItem<int>(
                          value: sem,
                          child: Text(
                            sem.toString(),
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _semesterController.text = value?.toString() ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your semester';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Branch field
                DropdownButtonFormField<String>(
                  value:
                      _branchController.text.isNotEmpty
                          ? _branchController.text
                          : null,
                  decoration: InputDecoration(
                    labelText: 'Branch',
                    labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.indigo[900], // <-- dark blue background
                  ),
                  dropdownColor:
                      Colors.indigo[900], // <-- dark blue dropdown menu
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                  items:
                      branches.map((branch) {
                        return DropdownMenuItem<String>(
                          value: branch,
                          child: Text(
                            branch,
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _branchController.text = value ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your branch';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: theme.colorScheme.onPrimary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.onPrimary.withOpacity(0.3),
                  ),
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: theme.colorScheme.onPrimary.withOpacity(
                      0.5,
                    ),
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: theme.colorScheme.surface,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
