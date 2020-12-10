import 'package:bsm_noteapp/repository/noteRepo.dart';
class Note {

  final NoteRepo noteRepo = NoteRepo();

  // init note from storage
  Future<String> initNote(String hash) async {
    String note = await noteRepo.decryptNote(hash);
    return note;
  }
  
  // save changed note
  Future<void> saveNote(String note, String hash) async {
    await noteRepo.encryptNote(note, hash);
  }
}