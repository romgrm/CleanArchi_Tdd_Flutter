import 'package:equatable/equatable.dart';

/**
 * Create an entity of what we will receive from the API.
 * Convert the JSON format to Dart Object 
 
 * In Dart, we can compare two objects to see if they are identical only if they have the same memory location
 * Even if they have the same data but not the same location memory, Dart will return false 
 * So for compare if 2 objects have the same data, we will use Equatable package, who manage boilerplate code for us and return true if data have the exact same data inside
 
 * There aren't logic in this class so why we don't use TDD 
 */

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  const NumberTrivia(this.text, this.number) : super();

  @override
  List<Object?> get props => [text, number];
}
