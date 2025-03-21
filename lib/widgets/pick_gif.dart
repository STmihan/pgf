import 'package:flutter/material.dart';

class PickGif extends StatefulWidget {
  static const String pickGifMethod = "pick_gif";

  const PickGif({super.key, required this.onPickGif});

  final Function(String) onPickGif;

  @override
  State<PickGif> createState() => _PickGifState();
}

class _PickGifState extends State<PickGif> {
  String _url = '';

  void onSubmit() {
    widget.onPickGif(_url);
  }

  void onCancel() {
    widget.onPickGif("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 450,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Choose GIF'),
              TextField(onChanged: (value) => setState(() => _url = value)),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: onCancel,
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: onSubmit,
                      child: const Text('Choose GIF'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
