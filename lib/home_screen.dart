import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:fitness_bot/messages_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Bot'),
        centerTitle: true,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: MessagesScreen(messages: messages),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: const BoxDecoration(
                color:  Color(0XFF1968FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      ScaffoldMessenger;
    } else {
      //handling user message
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });
    }
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)));

    if (response.message == null) return;
    //handling dialog flow message
    setState(() {
      addMessage(response.message!);
    });
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
