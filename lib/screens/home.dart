import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_travel_list/screens/login_screen.dart';
import 'package:smart_travel_list/models/data.dart';
import 'package:smart_travel_list/widgets/data_pop_up.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleLogout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      // Navigate back to the LoginScreen after logout
      Navigator.pushReplacement(
        // or Navigator.pushAndRemoveUntil
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () => _handleLogout(context),
              child: const Text('Logout'),
            ),
            Expanded(
              // Wrap ListView.builder with Expanded
              child: StreamBuilder<List<Data>>(
                stream: Data.fetchDataStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return ListTile(
                          title: Text(data.item),
                          subtitle: Text('Age: ${data.quantity}'),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Text('loading');
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DataPopUp();
                  },
                ).then((returnedData) { 
                  if (returnedData != null) {
                    DataPopUpData itemData = returnedData as DataPopUpData;
                    Data newItem = Data(item: itemData.description, quantity: itemData.quantity);
                    newItem.saveData();
       // ... process the data ...
                  }
                });
              },
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
