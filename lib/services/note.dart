import 'package:bsm_noteapp/repository/noteRepo.dart';
class Note {

  final NoteRepo noteRepo = NoteRepo();

  // init note from storage
  Future<String> initNote() async {
    String note = await noteRepo.decryptNote();
    return note;
  }
  
  // save changed note
  Future<void> saveNote(String note) async {
    await noteRepo.encryptNote(note);
  }
}