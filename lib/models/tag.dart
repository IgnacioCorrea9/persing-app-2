class Tag {
  String text;
  bool selected;

  Tag(this.text, this.selected);

  @override
  String toString() {
    return '{ ${this.text}, ${this.selected} }';
  }
}
