import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedList extends StatefulWidget {
  const SavedList({Key? key, required this.saved}) : super(key: key);

  final Set<WordPair> saved;

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
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index.isOdd) return const Divider();

        var realIndex = index ~/ 2;

        return _buildRow(widget.saved.toList()[realIndex]);
      },
      itemCount: widget.saved.length*2,
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: (){
        setState(() {
          widget.saved.remove(pair);
        });
      },
    );
  }
}
