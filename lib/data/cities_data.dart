class CitiesData {
  List<String>? cities;

  CitiesData({
    required this.cities,
  });

  CitiesData.fromJson(Map<String, dynamic> json) {
    cities = List<String>.from(json["cities"].map((x) => x.toString()));
  }
}
