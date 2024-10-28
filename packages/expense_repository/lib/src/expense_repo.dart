import 'package:expense_repository/src/models/models.dart';

abstract class ExpenseRepository {

  Future<void> createCategory(Category category );

  Future<List<Category>> getCategory();
}
