import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_app/src/bloc/Bloc.dart';

class SavedList extends StatefulWidget {
  const SavedList({Key? key}) : super(key: key);

  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved List'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {
        var saved = <WordPair>{};
        if(snapshot.hasData){
          saved.addAll(snapshot.data!);
        } else {
          bloc.addCurrentSaved();
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            if (index.isOdd) return const Divider();

            var realIndex = index ~/ 2;

            return _buildRow(saved.toList()[realIndex]);
          },
          itemCount: saved.length*2,
        );
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: (){
        bloc.addOrRemoveFromSavedList(pair);
      },
    );
  }
}
