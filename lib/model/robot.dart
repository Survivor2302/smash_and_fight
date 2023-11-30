class Robot {
  String name;
  String sentence;
  int attack;
  int pv;
  int armor;
  late String imageUrl; // Mark the field as 'late'

  Robot(
      {required this.name,
      required this.sentence,
      required this.attack,
      required this.pv,
      required this.armor,
      required this.imageUrl}); // Add a generative constructor
}
