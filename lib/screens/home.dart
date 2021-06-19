import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Tdnizer",
              style: Theme.of(context).textTheme.headline1,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: TextField(
                controller: wordController,
                decoration: const InputDecoration(
                  labelText: 'TDN翻訳したいワードを入れてください',
                  hintText: 'tdn',
                  icon: Icon(Icons.search),
                ),
                onSubmitted: (_) {
                  Navigator.pushNamed(
                    context,
                    '/search',
                    arguments: wordController.text.toString(),
                  );
                },
              ),
            ),
            Container(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
