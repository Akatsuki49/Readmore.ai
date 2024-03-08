import 'package:hashcode/models/book.dart';
import 'package:hashcode/models/visualization_data.dart';

class DummyData {
  static final List<Book> books = [
    Book(
      title: 'The Brave Knight',
      content:
          'Once upon a time, in a far-off land, there lived a brave knight who rode a majestic white horse. The knight was known for his courage and chivalry, and he spent his days protecting the villagers from harm.\n\nOne day, as the knight was patrolling the kingdom, he came across a fearsome dragon terrorizing a nearby village. The dragon was breathing fire and causing chaos, and the villagers were cowering in fear.\n\nWithout hesitation, the knight charged towards the dragon, his sword drawn and his shield raised high. The dragon roared and unleashed a torrent of flames, but the knight\'s armor protected him from the scorching heat.',
    ),
    Book(
      title: 'The Enchanted Forest',
      content:
          'Deep within the ancient forest, a magical realm existed, hidden from the eyes of ordinary folk. Here, the trees were alive with the whispers of fairies and the rustling of mystical creatures that called this place home.\n\nA young girl named Lily stumbled upon this enchanted forest quite by accident. As she wandered deeper into the verdant foliage, she encountered a wise old wizard who informed her that she had a special destiny to fulfill.\n\nLily embarked on a journey through the forest, meeting friendly dwarves, talking animals, and other whimsical beings along the way. Each encounter taught her valuable lessons about courage, friendship, and the power of belief.',
    ),
  ];

  static final VisualizationData visualizationData = VisualizationData(
    image: 'https://via.placeholder.com/300',
    audio: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  );
}
