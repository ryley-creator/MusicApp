import '../imports/imports.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(auth.currentUser!.email!, style: TextStyle(fontSize: 20)),
            TextButton(
              onPressed: () {
                authService.logout();
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 10),
                  Text('Logout', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
