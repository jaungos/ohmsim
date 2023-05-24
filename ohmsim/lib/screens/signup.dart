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
      // appBar: AppBar(
      //   title: const Text('Sign Up'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            const HeaderTitle(),
            PrivilegeForm(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 0.5,
                width: 300.0,
                color: const Color(0xFFd3d3d3),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Fill in the form to continue',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            SignupForm(),
          ],
        ),
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: const [
            Text(
              'Create new account',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Choose user type',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
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

    late String privilege = context.watch<AuthProvider>().privilege;

    // TextField for Email
    final email = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Password
    final password = TextFormField(
      controller: passwordController,
      decoration: const InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for First Name
    final firstName = TextFormField(
      controller: fNameController,
      decoration: const InputDecoration(
        hintText: "First Name",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
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
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Last Name
    final lastName = TextFormField(
      controller: lNameController,
      decoration: const InputDecoration(
        hintText: "Last Name",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Username
    final username = TextFormField(
      controller: userNameController,
      decoration: const InputDecoration(
        hintText: "Username",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for College
    final college = TextFormField(
      controller: collegeController,
      decoration: const InputDecoration(
        hintText: "College",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Course
    final course = TextFormField(
      controller: courseController,
      decoration: const InputDecoration(
        hintText: "Course",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Student Number
    final studentNum = TextFormField(
      controller: studentNoController,
      decoration: const InputDecoration(
        hintText: "Student Number",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Employee Number
    final employeeNum = TextFormField(
      controller: employeeNoController,
      decoration: const InputDecoration(
        hintText: "Employee Number",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Position
    final position = TextFormField(
      controller: positionController,
      decoration: const InputDecoration(
        hintText: "Position",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // TextField for Home Unit
    final homeUnit = TextFormField(
      controller: homeUnitController,
      decoration: const InputDecoration(
        hintText: "Home Unit",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        // Changes the label name color when the field is active/clicked
        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF008D4C), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your first name";
        }
        return null;
      },
      onSaved: (newValue) => debugPrint("First Name Saved"),
    );

    // SignUp Button
    final signupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A65A),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();

            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        },
        child: const Text('Sign up',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );

    // Back Button
    final backButton = TextButton(
      onPressed: () async {
        Navigator.pop(context);
      },
      child: const Text(
        'Log In',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF00A65A),
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: email,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: password,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: firstName,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: middleInitial,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: lastName,
              ),
              if (privilege == 'Student') ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: username,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: college,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: course,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: studentNum,
                ),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: employeeNum,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: position,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: homeUnit,
                ),
              ],
              signupButton,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 0.5,
                  width: 300.0,
                  color: const Color(0xFFd3d3d3),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  backButton,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
