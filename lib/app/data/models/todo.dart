// import 'package:equatable/equatable.dart';

// class ToDo extends Equatable {
//   final String title;
//   final bool done;

//   const ToDo({
//     required this.title,
//     required this.done,
//   });

//   ToDo copyWith({
//     String? title,
//     bool? done,
//   }) =>
//       ToDo(
//         title: title ?? this.title,
//         done: done ?? this.done,
//       );

//   factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
//         title: json['title'],
//         done: json['done'],
//       );

//   Map<String, dynamic> toJson() => {
//         'title': title,
//         'done': done,
//       };
//   @override
//   List<Object?> get props => [title, done];
// }
