import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_application_flutter/modules/user/infra/models/user_response.dart';
import 'package:github_application_flutter/modules/user/ui/bloc/search_user_bloc.dart';
import 'package:github_application_flutter/modules/user/ui/widgets/user_tile_widget.dart';
import 'package:github_application_flutter/shared/app_images.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final searchUserBloc = Modular.get<SearchUserBloc>();
  final _formKey = GlobalKey<FormState>();
  final _searchTextController = TextEditingController();

  @override
  void dispose() {
    searchUserBloc.dispose();
    super.dispose();
  }

  void onSubmitForm(String value) {
    _formKey.currentState.save();
    searchUserBloc.inputUserName.add(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Application Flutter'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 100,
            bottom: 10,
            child: Opacity(
              opacity: 0.02,
              child: Image.asset(
                AppImages.backgroundImage,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _searchTextController,
                    onSubmitted: (value) {
                      _searchTextController.text = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search_outlined,
                            color: Colors.green),
                        onPressed: () {
                          onSubmitForm(_searchTextController.text);
                        },
                      ),
                      hintText: 'Type user\'s name...',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<UserResponse>>(
                  stream: searchUserBloc.outputUsers,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text(
                          'Search an user by name...',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data[index];
                        return UserTileWidget(user: user);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
