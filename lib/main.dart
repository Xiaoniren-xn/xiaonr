import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '爱心配对',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _words = <WordPair>[];
  final _mywords = <WordPair>[];
  @override
  Widget build(BuildContext context) {
    _words.addAll(generateWordPairs().take(10));
    return Scaffold(
        appBar: AppBar(
          title: const Text('爱心配对'),
          actions: [
            IconButton(onPressed: _gotoLoved, icon: const Icon(Icons.list))
          ],
        ),
        body: Center(
          child: _buildList(),
        ));
  }

  void _gotoLoved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> titles = _mywords.map((wp) {
        return ListTile(
          title: Text(wp.asCamelCase),
        );
      });

      return Scaffold(
          appBar: AppBar(
            title: const Text('喜欢的列表'),
          ),
          body: ListView(children: titles.toList()));
    }));
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, item) {
      if (item.isOdd) {
        return const Divider();
      } else {
        int index = item ~/ 2;
        if (index >= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(index);
      }
    });
  }

  Widget _buildRow(index) {
    WordPair wp = _words[index];
    return ListTile(
      title: Text(_words[index].asCamelCase),
      // subtitle: const Text('hello subtitle'),
      trailing: _buildLoveIcon(wp),
      onTap: () => {_addToLove(wp)},
    );
  }

  Widget _buildLoveIcon(WordPair wp) {
    if (_mywords.contains(wp)) {
      return const Icon(Icons.favorite, color: Colors.red);
    } else {
      return const Icon(Icons.favorite_border);
    }
  }

  void _addToLove(WordPair wp) {
    setState(() {
      if (_mywords.contains(wp)) {
        _mywords.remove(wp);
      } else {
        _mywords.add(wp);
      }
    });

    // print(_mywords.length);
  }
}
