class WorkoutSet {
  int reps;
  double weight;

  WorkoutSet({
    required this.reps,
    required this.weight,
  });

  Map<String, dynamic> toJson() => {
        'reps': reps,
        'weight': weight,
      };

  factory WorkoutSet.fromJson(Map<String, dynamic> json) => WorkoutSet(
        reps: json['reps'] as int,
        weight: (json['weight'] as num).toDouble(),
      );
}

class Exercise {
  String id;
  String name;
  List<WorkoutSet> sets;
  String? notes;

  Exercise({
    required this.id,
    required this.name,
    required this.sets,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sets': sets.map((s) => s.toJson()).toList(),
        'notes': notes,
      };

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'] as String,
        name: json['name'] as String,
        sets: (json['sets'] as List)
            .map((s) => WorkoutSet.fromJson(s as Map<String, dynamic>))
            .toList(),
        notes: json['notes'] as String?,
      );
}

class Workout {
  String id;
  String name;
  DateTime date;
  List<Exercise> exercises;
  int duration; // in minutes
  String? notes;

  Workout({
    required this.id,
    required this.name,
    required this.date,
    required this.exercises,
    required this.duration,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
        'exercises': exercises.map((e) => e.toJson()).toList(),
        'duration': duration,
        'notes': notes,
      };

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json['id'] as String,
        name: json['name'] as String,
        date: DateTime.parse(json['date'] as String),
        exercises: (json['exercises'] as List)
            .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
            .toList(),
        duration: json['duration'] as int,
        notes: json['notes'] as String?,
      );
}
