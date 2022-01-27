import 'dart:io';

/**
 * Method who fetch a file (fixtures json created) and return as a String 
 */
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
