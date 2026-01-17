import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  const Library({
    super.key,
    required this.onTap,
    required this.onOpenFavorites,
  });
  final void Function() onTap;
  final void Function() onOpenFavorites;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Library')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            ListTile(
              onTap: onTap,
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 68,
                height: 68,
                child: Icon(
                  Icons.download_done_outlined,
                  size: 40,
                  color: Colors.grey[900],
                ),
              ),
              title: Text('Downloads', style: TextStyle(fontSize: 23)),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: onOpenFavorites,
              title: Text('Favorites', style: TextStyle(fontSize: 23)),
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 68,
                height: 68,
                child: Icon(Icons.favorite, size: 40, color: Colors.grey[900]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
