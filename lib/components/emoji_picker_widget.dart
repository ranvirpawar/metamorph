import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmojiPickerButton extends StatelessWidget {
  final String selectedEmoji;
  final Function(String) onEmojiSelected;

  const EmojiPickerButton({
    required this.selectedEmoji,
    required this.onEmojiSelected,
  });

  // Common emojis for task types
  static const List<Map<String, String>> commonEmojis = [
    {"emoji": "📝", "name": "Notes"},
    {"emoji": "📚", "name": "Study"},
    {"emoji": "👔", "name": "Work"},
    {"emoji": "🏋️", "name": "Exercise"},
    {"emoji": "🎨", "name": "Art"},
    {"emoji": "🎮", "name": "Gaming"},
    {"emoji": "🏠", "name": "Home"},
    {"emoji": "🛒", "name": "Shopping"},
    {"emoji": "🍳", "name": "Cooking"},
    {"emoji": "🎵", "name": "Music"},
    {"emoji": "💻", "name": "Programming"},
    {"emoji": "📞", "name": "Calls"},
    {"emoji": "🤝", "name": "Meeting"},
    {"emoji": "🎯", "name": "Goals"},
    {"emoji": "💪", "name": "Health"},
    {"emoji": "✈️", "name": "Travel"},
    {"emoji": "💭", "name": "Personal"},
    {"emoji": "🎁", "name": "Events"},
    {"emoji": "📅", "name": "Schedule"},
    {"emoji": "⭐", "name": "Important"},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => Container(
            height: 400,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                  'Select Emoji',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: commonEmojis.length,
                    itemBuilder: (context, index) {
                      final emojiData = commonEmojis[index];
                      return GestureDetector(
                        onTap: () {
                          onEmojiSelected(emojiData['emoji']!);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selectedEmoji == emojiData['emoji']
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                emojiData['emoji']!,
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 4),
                              Text(
                                emojiData['name']!,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 10,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            selectedEmoji,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
