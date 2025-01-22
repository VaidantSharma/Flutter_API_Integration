import 'package:api_integration/API/rest_API/api_new.dart';
import 'package:flutter/material.dart';
import 'package:api_integration/API/rest_API/user_model_new.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  late List<UserModel>? _userModel = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(context) {
    return _userModel == null || _userModel!.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _userModel!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(_userModel![index].id.toString()),
                        Text(_userModel![index].username)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(_userModel![index].email),
                        Text(_userModel![index].website),
                      ],
                    )
                  ],
                ),
              );
            });
  }
}
