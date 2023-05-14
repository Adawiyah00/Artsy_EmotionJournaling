class MoodModel{
  String? name;
  String? image;
  int? id;
  MoodModel({this.id,this.image,this.name});
}

class ActivityListModel{
  List<String>? name;
  List<String>? image;
  List<int>? id;
  ActivityListModel({this.image,this.name});
}