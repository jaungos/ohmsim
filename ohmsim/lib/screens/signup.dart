import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static String routeName = '/signup';

  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // On dropdown select

  // context.read<AuthProvider>().switchSignUpPrivilege(value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Column(
        children: [
          PrivilegeForm(),
          SignupForm(),
        ],
      ),
    );
  }
}

class PrivilegeForm extends StatefulWidget {
  PrivilegeForm({super.key});

  @override
  _PrivilegeFormState createState() => _PrivilegeFormState();
}

class _PrivilegeFormState extends State<PrivilegeForm> {
  String dropdownValue = 'Student';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      items: <String>['Student', 'Admin', 'Entrance Monitor']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
      onChanged: (String? newValue) async {
        setState(() {
          dropdownValue = newValue!;
        });
        await context.read<AuthProvider>().switchSignUpPrivilege(dropdownValue);
      },
    );
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({super.key});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController fNameController = TextEditingController();
    TextEditingController mNameController = TextEditingController();
    TextEditingController lNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController collegeController = TextEditingController();
    TextEditingController courseController = TextEditingController();
    TextEditingController studentNoController = TextEditingController();
    TextEditingController employeeNoController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController homeUnitController = TextEditingController();
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    late String privilege = context.watch<AuthProvider>().privilege;
    Future<bool> emailValidator(String email) async {
      try {
        List<String> usersignin =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        return usersignin.isEmpty;
      } catch (e) {
        return true;
      }
    }

    // TextField for Email
    final email = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            emailRegex.hasMatch(value) == false) {
          return "Please enter valid email address";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Email Saved"),
    );

    // TextField for Password
    final password = TextFormField(
      controller: passwordController,
      decoration: const InputDecoration(
        hintText: "Password",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Password Saved"),
    );

    // TextField for First Name
    final firstName = TextFormField(
      controller: fNameController,
      decoration: const InputDecoration(
        hintText: "First Name",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Middle Initial
    final middleInitial = TextFormField(
      controller: mNameController,
      decoration: const InputDecoration(
        hintText: "Middle Initial",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your middle initial";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Middle Initial Saved"),
    );

    // TextField for Last Name
    final lastName = TextFormField(
      controller: lNameController,
      decoration: const InputDecoration(
        hintText: "Last Name",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your last name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Last Name Saved"),
    );

    // TextField for Username
    final username = TextFormField(
      controller: userNameController,
      decoration: const InputDecoration(
        hintText: "Username",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your username";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Username Saved"),
    );

    // TextField for College
    final college = TextFormField(
      controller: collegeController,
      decoration: const InputDecoration(
        hintText: "College",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your college";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("College Saved"),
    );

    // TextField for Course
    final course = TextFormField(
      controller: courseController,
      decoration: const InputDecoration(
        hintText: "Course",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your course";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Course Saved"),
    );

    // TextField for Student Number
    final studentNum = TextFormField(
      controller: studentNoController,
      decoration: const InputDecoration(
        hintText: "Student Number",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your student number";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Student Number Saved"),
    );

    // TextField for Employee Number
    final employeeNum = TextFormField(
      controller: employeeNoController,
      decoration: const InputDecoration(
        hintText: "Employee Number",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your employee number";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Employee Number Saved"),
    );

    // TextField for Position
    final position = TextFormField(
      controller: positionController,
      decoration: const InputDecoration(
        hintText: "Position",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your position";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Position Saved"),
    );

    // TextField for Home Unit
    final homeUnit = TextFormField(
      controller: homeUnitController,
      decoration: const InputDecoration(
        hintText: "Home Unit",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your home unit";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("Home Unit Saved"),
    );

    // SignUp Button
    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();

            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    // Back Button
    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back'),
      ),
    );

    return Form(
      key: _formKey,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: [
            email,
            password,
            firstName,
            middleInitial,
            lastName,
            if (privilege == 'Student') ...[
              username,
              college,
              course,
              studentNum,
            ] else ...[
              employeeNum,
              position,
              homeUnit,
            ],
            SignupButton,
            backButton,
          ],
        ),
      ),
    );
  }
}
