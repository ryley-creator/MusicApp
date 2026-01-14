import 'package:audio_app/imports/imports.dart';
import 'package:audio_app/widgets/playlist/genre_box.dart';
import 'package:audio_app/widgets/search_textfield.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key, required this.onOpenCategory});
  final TextEditingController controller = TextEditingController();
  final void Function(PlaylistCategory category, String title) onOpenCategory;

  @override
  Widget build(BuildContext context) {
    final items = [
      GenreBox(
        color: Colors.blue,
        title: 'Pop',
        onTap: () => onOpenCategory(PlaylistCategory.pop, 'Pop'),
      ),
      GenreBox(
        color: Colors.orange,
        title: 'Rock',
        onTap: () => onOpenCategory(PlaylistCategory.rock, 'Rock'),
      ),
      GenreBox(
        color: Colors.green,
        title: 'Kpop',
        onTap: () => onOpenCategory(PlaylistCategory.kpop, 'Kpop'),
      ),
      GenreBox(
        color: Colors.indigoAccent,
        title: 'Phonk',
        onTap: () => onOpenCategory(PlaylistCategory.phonk, 'Phonk'),
      ),
      GenreBox(color: Colors.purple, title: 'New', onTap: () {}),
      GenreBox(color: Colors.grey, title: 'Indigo', onTap: () {}),
      GenreBox(color: Colors.deepOrangeAccent, title: 'Rus', onTap: () {}),
      GenreBox(color: Colors.brown, title: 'Uzbek', onTap: () {}),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Search', style: TextStyle(fontSize: 30))),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            SearchTextfield(controller: controller),
            SizedBox(height: 5),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return items[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
