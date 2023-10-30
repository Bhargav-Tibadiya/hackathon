import 'package:flutter/material.dart';

TextField inputTextField(String text, IconData icon, bool isPassword,
    TextEditingController controller) {

  return TextField(
    controller: controller,
    obscureText: isPassword,
    cursorColor: Colors.blue,
    style: const TextStyle(
      color: Colors.black,
    ),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
                labelText: text,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        fillColor: Colors.white.withOpacity(0.2),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2,color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),

    ),
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.blueAccent;
          }
          return Colors.white;
        })
      ),
      child: Text(
        isLogin ? "Login" : "Sign Up",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    ),
  );
}
