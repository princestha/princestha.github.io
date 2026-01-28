import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout.dart';

class WorkoutStorage {
  static const String _workoutsKey = 'workouts';

  Future<List<Workout>> loadWorkouts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final workoutsJson = prefs.getString(_workoutsKey);
      
      if (workoutsJson == null) {
        return [];
      }

      final List<dynamic> decoded = json.decode(workoutsJson);
      return decoded
          .map((item) => Workout.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading workouts: $e');
      return [];
    }
  }

  Future<void> saveWorkouts(List<Workout> workouts) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final workoutsJson = json.encode(
        workouts.map((w) => w.toJson()).toList(),
      );
      await prefs.setString(_workoutsKey, workoutsJson);
    } catch (e) {
      print('Error saving workouts: $e');
    }
  }

  Future<void> addWorkout(Workout workout) async {
    final workouts = await loadWorkouts();
    workouts.insert(0, workout);
    await saveWorkouts(workouts);
  }

  Future<void> updateWorkout(Workout workout) async {
    final workouts = await loadWorkouts();
    final index = workouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      workouts[index] = workout;
      await saveWorkouts(workouts);
    }
  }

  Future<void> deleteWorkout(String id) async {
    final workouts = await loadWorkouts();
    workouts.removeWhere((w) => w.id == id);
    await saveWorkouts(workouts);
  }
}
