extension DoubleExtension on double {
  double getPercentage(double a, double b) {
    return (this - a) / (b - a);
  }
}
