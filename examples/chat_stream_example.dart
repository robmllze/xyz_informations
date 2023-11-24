//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Informations
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:io';

import 'package:xyz_informations/xyz_informations.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() async {
  print("Word count: ${TEST_DATA__ALCOHOLIC_DRINKS.split(" ").length}");

  final client = OpenAIClient(
    apiKey: Platform.environment["OPEN_AI_API_KEY"]!,
  );

  final stream = client.getOpenAiChatCompletionStream(
    maxTokens: 3000,
    model: const GPTModel("gpt-4-1106-preview"),
    messages: [
      ChatMessage(
        role: ChatRole.SYSTEM,
        content: "You're a function that takes raw and summarizes it.",
      ),
      ChatMessage(
        role: ChatRole.USER,
        content: "<SUMMARY> $TEST_DATA__ALCOHOLIC_DRINKS </SUMMARY>",
      ),
    ],
    onData: (buffer) {
      stdout.write(buffer);
    },
  );
  stream.listen((event) {});
}
