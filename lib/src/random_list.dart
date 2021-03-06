import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_app/src/bloc/Bloc.dart';
import 'package:flutter_naming_app/src/saved_list.dart';

class RandomList extends StatefulWidget {
  const RandomList({Key? key}) : super(key: key);

  @override
  State<RandomList> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _words = <WordPair>[];
  final Set<WordPair> _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('naming app'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavedList())).then((value) => setState(() {},));
              },
              icon: const Icon(Icons.list),
            ),
          ],
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {
        return ListView.builder(
          itemBuilder: (context, index) {
            // 0, 2, 4, 6, 8 .. content
            // 1, 3, 5, 7 ,9 .. divider
            if (index.isOdd) {
              return const Divider();
            }

            var realIndex = index ~/ 2;

            if (realIndex >= _words.length) {
              _words.addAll(generateWordPairs().take(10));
            }

            return _buildRow(snapshot.data ?? <WordPair>{}, _words[realIndex]);
          },
        );
      }
    );
  }

  Widget _buildRow(Set<WordPair> saved, WordPair pair) {
    final bool alreadySaved = saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        bloc.addOrRemoveFromSavedList(pair);
      },
    );
  }
}
