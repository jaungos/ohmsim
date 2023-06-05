import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/adminMonitor.dart';
import 'package:ohmsim/models/studentUserModel.dart';
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
                fontWeight: FontWeight.normal,
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
  List<TextEditingController> preExistingIllnesses = [
    TextEditingController(),
  ];

  List<String> sampleIllnesses = [
    "Hypertension",
    "Diabetes",
    "Tuberculosis",
    "Cancer",
    "Kidney Disease",
    "Cardiac Disease",
    "Autoimmune Disease",
    "Asthma",
  ];

  @override
  void dispose() {
    for (var controller in preExistingIllnesses) {
      controller.dispose();
    }
    super.dispose();
  }

  void addField() {
    setState(() {
      TextEditingController newField = TextEditingController();
      preExistingIllnesses.add(newField);
    });
  }

  void removeField(int index) {
    setState(() {
      preExistingIllnesses[index].dispose();
      preExistingIllnesses.removeAt(index);
    });
  }

  // Dynamic textfield/s for Pre-existing Illnesses
  Widget illnesses() => ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: preExistingIllnesses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: preExistingIllnesses[index],
                    decoration: InputDecoration(
                      hintText: index <= sampleIllnesses.length - 1
                          ? "e.g. ${sampleIllnesses[index]}"
                          : "e.g. ${sampleIllnesses[index % (sampleIllnesses.length - 1)]}",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFC7EAD9),
                      // Changes the border color when the field is active/clicked
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: const BorderSide(
                          color: Color(0xFF008D4C),
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an illness";
                      }
                      return null;
                    },
                    onSaved: (newValue) =>
                        debugPrint("Pre-existing illness $index Saved"),
                  ),
                ),
                if (index > 0)
                  IconButton(
                    onPressed: () {
                      removeField(index);
                    },
                    icon: const Icon(Icons.remove),
                  ),
              ],
            ),
          );
        },
      );

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
      decoration: InputDecoration(
        hintText: "e.g. example@domain.com",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
    // @TODO: implement the display password the eye is pressed
    final password = TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
      ),
      obscureText: true,
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
      decoration: InputDecoration(
        hintText: "e.g. Juan",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
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
      decoration: InputDecoration(
        hintText: "e.g. C. ",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
      decoration: InputDecoration(
        hintText: "e.g. Dela Cruz",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
      decoration: InputDecoration(
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
      decoration: InputDecoration(
        hintText: "e.g. CAS",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
      decoration: InputDecoration(
        hintText: "e.g. BS Computer Science",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
      decoration: InputDecoration(
        hintText: "e.g. 20XX-XXXXX",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
      decoration: InputDecoration(
        hintText: "Employee Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
      decoration: InputDecoration(
        hintText: "Position",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
      decoration: InputDecoration(
        hintText: "e.g. ICS",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFC7EAD9),
        // Changes the border color when the field is active/clicked
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: Color(0xFF008D4C),
            width: 2,
          ),
        ),
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
    final signupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A65A),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();

            var signUpData;
            var err;
            var success = false;

            // @TODO: add the preexisting illnesses to the database
            // @TODO: don't store or implement hashing to the password
            if (privilege == 'Student') {
              // This every illness to true
              List<String> allPreExistingIllnesses = preExistingIllnesses
                  .map((controller) => controller.text)
                  .toList();

              signUpData = StudentUser(
                email: emailController.text,
                password: passwordController.text,
                fname: fNameController.text,
                mname: mNameController.text,
                lname: lNameController.text,
                college: collegeController.text,
                course: courseController.text,
                studentNo: studentNoController.text,
                username: userNameController.text,
                privilege: privilege,
                preexistingIllnesses: allPreExistingIllnesses,
                hasDailyEntry: false,
                status: 'None',
              );

              try {
                success = await context
                    .read<AuthProvider>()
                    .signUpStudent(signUpData);
              } catch (e) {
                err = e;
              }
            } else if (privilege == 'Admin' ||
                privilege == 'Entrance Monitor') {
              signUpData = AdminMonitor(
                email: emailController.text,
                password: passwordController.text,
                fname: fNameController.text,
                mname: mNameController.text,
                lname: lNameController.text,
                employeeNo: employeeNoController.text,
                position: positionController.text,
                homeUnit: homeUnitController.text,
                privilege: privilege,
                status: 'None',
              );

              try {
                success = await context
                    .read<AuthProvider>()
                    .signUpAdminMonitor(signUpData);
              } catch (e) {
                err = e;
              }
            }

            if (success) {
              if (context.mounted) {
                await context
                    .read<AuthProvider>()
                    .switchSignUpPrivilege('Student');
                Navigator.pop(context);
              }
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Signup Failed"),
                    content: Text(err),
                  );
                },
              );
              return;
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
        await context.read<AuthProvider>().switchSignUpPrivilege('Student');
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

    // Form field labels
    formLabel(String formLabel) => Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (formLabel == 'Pre-existing Illnesses') ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formLabel,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF3e3b3a),
                      ),
                    ),
                    const Text(
                      "If none, please type 'None'. For allergies, please specify.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF3e3b3a),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          addField();
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  formLabel,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF3e3b3a),
                  ),
                ),
              ],
            ],
          ),
        );

    return Form(
      key: _formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              if (privilege == 'Student') ...[
                formLabel('Pre-existing Illnesses'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: illnesses(),
                ),
              ],
              formLabel('Email'),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: email,
              ),
              formLabel('Password'),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: password,
              ),
              formLabel('First Name'),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: firstName,
              ),
              formLabel('Middle Initial'),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: middleInitial,
              ),
              formLabel('Last Name'),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: lastName,
              ),
              if (privilege == 'Student') ...[
                formLabel('Username'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: username,
                ),
                formLabel('College'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: college,
                ),
                formLabel('Course'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: course,
                ),
                formLabel('Student Number'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: studentNum,
                ),
              ] else ...[
                formLabel('Employee Number'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: employeeNum,
                ),
                formLabel('Position'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: position,
                ),
                formLabel('Home Unit'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
