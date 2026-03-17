import 'package:flutter_bloc/flutter_bloc.dart';

class TimeCubit extends Cubit<List<dynamic>> {
  TimeCubit() : super([]){
    generateYears();
  }

  dynamic selectedYear = "All Time";

  void selectYear(dynamic year) {
    selectedYear = year;
    generateYears();
  }

  void generateYears() {
    final currentYear = DateTime.now().year;

    // تحديد النوع هنا كـ <dynamic> ليقبل أرقام ونصوص
    final List<dynamic> years = List.generate(
      currentYear - 1999 + 1,
          (index) => currentYear - index,
    );

    years.insert(0, "All Time");

    emit(years);
  }
}
