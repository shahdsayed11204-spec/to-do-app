class TaskModel {
  final int? id;
  final String title;
  final String date;
  final String time;
  final String status;

  TaskModel({
    this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
  });

  factory TaskModel.fromMap(Map<String,dynamic> map){
    return TaskModel(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      time: map['time'],
      status: map['status'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'title':title,
      'date':date,
      'time':time,
      'status':status,
    };
  }
}