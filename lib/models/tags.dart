library TagModel;

/// {@category Models}
///## Tags class that stores each tag info
///
///   • selected: boolean is true only if the tag is selected
/// 
///   • title: tag title
/// 
/// 
class Tag {
  final String title;
  bool selected;

  Tag(this.title, this.selected);
}