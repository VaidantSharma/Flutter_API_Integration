import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:api_integration/controller.dart';

class GetXStateMixinDemo extends StatelessWidget {
  GetXStateMixinDemo({super.key});
  var c = Get.put(UserListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Getx State Mixin"),
      ),
      body: RefreshIndicator(
        onRefresh: c.fetchUsers(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: c.obx(
                  (state) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          state[index].picture.medium)),
                  title: Text(state[index].name.first),
                  subtitle: Text(state[index].email),
                ),
                itemCount: state!.length,
              ),
              onEmpty: Padding(
                padding: EdgeInsets.symmetric(vertical: context.height * 0.3),
                child: const Center(child: Text("Data is Empty")),
              ),
              onError: (e) => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.3, horizontal: 20),
                child: Center(
                  child: Text(
                    "$e",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onLoading: Padding(
                padding: EdgeInsets.symmetric(vertical: context.height * 0.3),
                child: const Center(child: CircularProgressIndicator()),
              )),
        ),
      ),
    );
  }
}