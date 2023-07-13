dynamic removeWhiteChars(dynamic val) {
  String value = val.toString();
  value = value.replaceAll(' ', '');
  return value;
}

dynamic buildBodyMeasurement(String content) {
  return buildContentOfSegments(content);
}

dynamic buildContentOfMeasurement(String measurement) {
  measurement = buildContentOfSegments(measurement);
  return measurement
      .replaceAll('angles', '"angles"')
      .replaceAll('raw', '"raw"');
}

dynamic buildContentOfSegments(String segments) {
  return segments
      .toString()
      .replaceAll('0:', '"segment_0":')
      .replaceAll('1:', '"segment_1":')
      .replaceAll('2:', '"segment_2":')
      .replaceAll('3:', '"segment_3":')
      .replaceAll('4:', '"segment_4":')
      .replaceAll('5:', '"segment_5":')
      .replaceAll('6:', '"segment_6":')
      .replaceAll('7:', '"segment_7":')
      .replaceAll('8:', '"segment_8":')
      .replaceAll('9:', '"segment_9":')
      .replaceAll('1"segment_0":', '"segment_10":');
}

dynamic segmentsModel() {
  final Map<int, dynamic> _model = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
    10: false,
  };
  return _model;
}
