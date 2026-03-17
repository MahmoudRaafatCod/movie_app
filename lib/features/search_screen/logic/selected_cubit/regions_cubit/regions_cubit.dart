
import 'package:flutter_bloc/flutter_bloc.dart';

class RegionsCubit extends Cubit<List<Map<String, String>>> {
  RegionsCubit() : super([]){
    generateLanguages();
  }


  String selectedLanguage = "all";

  void selectLanguage(String language) {
    selectedLanguage = language;
    generateLanguages();
  }

  void generateLanguages() {
    final languages = [
      {"name": "All Languages", "code": "all"},
      {"name": "English", "code": "en"},
      {"name": "Spanish", "code": "es"},
      {"name": "French", "code": "fr"},
      {"name": "German", "code": "de"},
      {"name": "Italian", "code": "it"},
      {"name": "Japanese", "code": "ja"},
      {"name": "Chinese (Mandarin)", "code": "zh"},
      {"name": "Korean", "code": "ko"},
      {"name": "Russian", "code": "ru"},
      {"name": "Hindi", "code": "hi"},
      {"name": "Portuguese", "code": "pt"},
      {"name": "Arabic", "code": "ar"},
      {"name": "Swedish", "code": "sv"},
      {"name": "Dutch", "code": "nl"},
      {"name": "Turkish", "code": "tr"},
    ];

    emit(languages);
  }

}
