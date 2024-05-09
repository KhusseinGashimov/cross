import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cross/providers/providers.dart';

class ActorAddScreen extends ConsumerStatefulWidget {
  const ActorAddScreen({super.key});

  @override
  ConsumerState<ActorAddScreen> createState() => _ActorAddScreenState();
}

class _ActorAddScreenState extends ConsumerState<ActorAddScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Expanded(
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                //name
                TextField(
                  controller: name,

                  decoration: InputDecoration(
                    labelText: 'name',
                    prefixIcon: const Icon(Icons.perm_identity_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Border color
                        width: 2.0, // Border width
                      ),
                    ),

                    filled: true,
                    fillColor: Colors.grey[200], // Fill color
                  ),
                  style: const TextStyle(color: Colors.black), // Text color
                ),

                const SizedBox(
                  height: 30,
                ),

                //description
                TextField(
                  controller: description,
                  decoration: InputDecoration(
                    labelText: 'description',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Border color
                        width: 2.0, // Border width
                      ),
                    ),

                    filled: true,
                    fillColor: Colors.grey[200], // Fill color
                  ),
                  style: const TextStyle(color: Colors.black), // Text color
                ),

                const SizedBox(
                  height: 30,
                ),

                //ticket_price
                TextField(
                  controller: url,
                  decoration: InputDecoration(
                    labelText: 'Image url',
                    prefixIcon: const Icon(Icons.price_check),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Border color
                        width: 2.0, // Border width
                      ),
                    ),

                    filled: true,
                    fillColor: Colors.grey[200], // Fill color
                  ),
                  style: const TextStyle(color: Colors.black), // Text color
                ),

                const SizedBox(
                  height: 30,
                ),

                Consumer(builder: (context, ref, child) {
                  return IconButton(
                    onPressed: () {
                      ref.read(authProvider).sendNewActor(
                            name.text.trim(),
                            description.text.trim(),
                            url.text.trim(),
                          );

                      name.clear();
                      description.clear();
                      url.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                    ),
                  );
                })
              ],
            ),
          ),
        ));
  }
}
