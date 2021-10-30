import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf_master/db/notes_database.dart';
import 'package:pdf_master/model/note.dart';
import 'package:pdf_master/page/edit_note_page.dart';
import 'package:pdf_master/page/note_detail_page.dart';
import 'package:pdf_master/screens/calculator.dart';
import 'package:pdf_master/widget/note_card_widget.dart';
import 'package:share_plus/share_plus.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FaIcon(
              FontAwesomeIcons.clipboard,
              size: 28,
            ),
          ),
          title: Text(
            'My Notes',
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await Share.share(
                    "Official App from vocalslocal.com -  PDF Master! \nDownload now ⬇️\nhttps://play.google.com/store/apps/developer?id=VocalsLocal");
              },
              icon: FaIcon(FontAwesomeIcons.share),
            ),
          ],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/pdfImagesPage.gif"),
                            Text(
                              "No Notes",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: FaIcon(FontAwesomeIcons.plus),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddEditNotePage()),
                );
                refreshNotes();
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: FaIcon(FontAwesomeIcons.calculator),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Calculator()),
                    );
                  });
                }),
          ],
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
