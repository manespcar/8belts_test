class Utils {
  static bool isInstructionIsValid(final String instruction) {
    final validCharacters = RegExp(r'^[lLrRfF]+$');
    return validCharacters.hasMatch(instruction);
  }
}
