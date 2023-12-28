import 'dart:math';

double roundDouble(double number, int places){
   num mod = pow(10, places); 
   return ((number * mod).round().toDouble() / mod);
}