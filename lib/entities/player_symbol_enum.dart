enum PlayerSymbolEnum {X,O,EMPTY_SPACE}
extension ConvertToString on PlayerSymbolEnum {
  String toShortString(){
    return this.toString().replaceAll('_', '-').split('.').last;
  }
}