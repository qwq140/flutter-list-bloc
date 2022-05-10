import 'dart:async';

import 'package:english_words/english_words.dart';

class Bloc{
  Set<WordPair> saved = <WordPair>{};

  // broadcast : snapshot을 보내줄 때 여러개 보내줌
  final _savedController = StreamController<Set<WordPair>>.broadcast();

  get savedStream => _savedController.stream;

  get addCurrentSaved => _savedController.sink.add(saved);

  addOrRemoveFromSavedList(WordPair pair){
    if(saved.contains(pair)){
      saved.remove(pair);
    } else {
      saved.add(pair);
    }

    _savedController.sink.add(saved);
  }

  dispose(){
    _savedController.close();
  }
}

var bloc = Bloc();