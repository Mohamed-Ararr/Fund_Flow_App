import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundflow/Core/ToastService.dart';
import 'package:fundflow/Data/BLoC%20Manager/Debt%20Cubit/debt_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../ContValues.dart';
import '../../../../Core/AppColors.dart';
import '../../../../Core/AppTextStyles.dart';
import '../../../../Core/Custom Mades/CustomInputField.dart';
import '../../../../Core/buttons.dart';
import '../../../../Data/BLoC Manager/Add New Debt Cubit/add_new_debt_cubit.dart';
import '../../../../Data/BLoC Manager/Transaction Cubit/transaction_cubit.dart';
import '../../../../Data/BLoC Manager/User Cubit/user_cubit.dart';
import '../../../../Data/Models/Debt Card Model/DebtCardModel.dart';

enum EntryType { expense, income, debtCredit }

class LogNewEntryView extends StatefulWidget {
  final EntryType initialType;

  const LogNewEntryView({super.key, this.initialType = EntryType.expense});

  @override
  State<LogNewEntryView> createState() => _LogNewEntryViewState();
}

class _LogNewEntryViewState extends State<LogNewEntryView> {
  late EntryType _selectedType;
  String? _selectedCategory; // New state for selected category
  String? _selectedDebtType; // New state for selected debt

  // Essential Categories List
  final List<String> _debtTypes = [
    'lending'.tr(), // Money you are owed
    'loan'.tr(), // Money you owe
  ];

  // Controllers for the form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
    // Set current date on initialization
    _dateController.text = _formatDate(DateTime.now());
    // Set initial category to the first one for expenses
    _selectedCategory = categories[0];
    // Set initial debt type
    _selectedDebtType = _debtTypes[0];
  }

  // Resets the category selection when the entry type changes
  void _updateSelectedType(EntryType newType) {
    setState(() {
      _selectedType = newType;
      // Adjust default category selection based on type
      if (newType == EntryType.income) {
        // Set default to 'Income' for income type
        _selectedCategory = categories.firstWhere(
            (cat) => cat.startsWith('Income'),
            orElse: () => categories[0]);
      } else {
        // Set default to the first expense category for others
        _selectedCategory = categories[0];
      }
      // Debt type will default to the first option 'Lending'
      _selectedDebtType = _debtTypes[0];
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = _formatDate(picked);
      });
    }
  }

  // Determine the primary color and button text based on the selected type
  Color get _primaryColor {
    switch (_selectedType) {
      case EntryType.expense:
        return AppColors.darkOrangeColor;
      case EntryType.income:
        return AppColors.successTeal;
      case EntryType.debtCredit:
        return AppColors.primaryDark; // Neutral dark for debt/credit options
    }
  }

  String get _buttonText {
    switch (_selectedType) {
      case EntryType.expense:
        return 'Log Expense';
      case EntryType.income:
        return 'Log Income';
      case EntryType.debtCredit:
        return 'Log Debt/Credit';
    }
  }

  void _logEntry() {
    final String title = _titleController.text;
    final double? amount = double.tryParse(_amountController.text);
    final String date = _dateController.text;

    // --- 1. Basic Validation ---
    if (title.isEmpty || amount == null || amount <= 0) {
      // In a real app, show a toast or message box for validation error
      log('Validation failed: Title and valid Amount are required.');
      ToastService.showError(
        context,
        "titleAndAmountRequired".tr(),
      );
      return;
    }

    // --- 2. Type-Specific Validation and Data Assembly ---
    String entryCategory = '';
    double finalAmount = amount; // Default amount is positive

    switch (_selectedType) {
      case EntryType.expense:
        if (_selectedCategory == null) {
          log('Validation failed: Category selection is required for Expense.');
          ToastService.showError(
            context,
            'categorySelectionRequired'.tr(),
          );
          return;
        }
        entryCategory = _selectedCategory!;
        finalAmount = -amount; // Expenses are negative
        final balanceBox = Hive.box<double>(kbalanceBox);
        final currentBalance = balanceBox.get(kbalanceBox) ?? 0.0;
        if (currentBalance <= amount) {
          ToastService.showError(
            context,
            'Not enough balance to do this operation',
          );
          return;
        }
        balanceBox.put(kbalanceBox, currentBalance - amount);
        context.read<TransactionCubit>().addTransaction(
              title: title,
              desc: entryCategory,
              spentAmount: finalAmount,
              date: date,
            );
        context.read<UserCubit>().fetchUserBalanceNew();
        context.read<TransactionCubit>().fetchTransactions();
        context.pop();
        break;

      case EntryType.income:
        entryCategory = _selectedCategory!;
        var box = Hive.box<double>(kbalanceBox);
        // RETRIEVE THE OLD BALANCE
        double oldBalance = box.get(kbalanceBox) ?? 0.0;
        // THEN ADD THE NEW AMOUNT TO THE OLD BALANCE
        double newBalance = oldBalance + finalAmount;
        box.put(kbalanceBox, newBalance);
        BlocProvider.of<UserCubit>(context).logBalanceEntry(
          amount: finalAmount,
          date: date,
          title: title,
        );
        BlocProvider.of<UserCubit>(context).fetchUserBalanceNew();
        context.pop();
        // Income remains positive
        break;

      case EntryType.debtCredit:
        if (_selectedDebtType == null) {
          log('Validation failed: Debt Type selection is required for Debt/Credit.');
          return;
        }
        entryCategory = _selectedDebtType!;
        Box<double> balanceBox = Hive.box<double>(kbalanceBox);
        double currentBalance = balanceBox.get(kbalanceBox)!;

        if (_selectedDebtType?.toLowerCase() == 'loan') {
          currentBalance = currentBalance + amount;
        } else {
          if (currentBalance < amount) {
            ToastService.showError(context, "notEnoughBalance".tr());
            return;
          }
          currentBalance = currentBalance - amount;
        }
        balanceBox.put(kbalanceBox, currentBalance);
        DebtCardModel debtCardModel = DebtCardModel(
          title: title,
          amount: amount,
          date: date,
          isDebt:
              _selectedDebtType?.toLowerCase() == 'loan'.tr() ? false : true,
          isPaid: false,
        );
        BlocProvider.of<AddNewDebtCubit>(context).addNewDebtCard(debtCardModel);
        context.read<UserCubit>().fetchUserBalanceNew();
        context.read<DebtCubit>().fetchDebtCards();
        context.pop();
        // The sign (finalAmount) is often handled by the backend based on whether it's 'Lending' (asset/positive) or 'Loan' (liability/negative)
        // For simple logging, we'll keep it positive and use the type string (entryCategory) to identify the nature of the transaction.
        break;
    }

    // --- 3. Process the entry (In the real app, this would be a Firestore call)
    log('--- New Entry Logged ---');
    log('Type: $_selectedType');
    log('Title: $title');
    log('Final Amount: $finalAmount (Positive/Negative sign applied)');
    log('Category/Type Detail: $entryCategory');
    log('Date: $date');
    log('--------------------------');

    // --- 4. Clear Fields ---
    _titleController.clear();
    _amountController.clear();
    _updateSelectedType(EntryType.expense); // Reset to default entry type
    // Navigator.pop(context); // Remove navigation for this snippet
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "logNewEntry".tr(),
          style: AppTextStyles.headerSectionTitle(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Column(
            children: [
              // 1. Entry Type Toggle Bar (Expense, Income, Debt/Credit)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: EntryType.values.map((type) {
                  final bool isSelected = _selectedType == type;
                  String text;
                  IconData icon;
                  Color color;

                  switch (type) {
                    case EntryType.expense:
                      text = 'expense'.tr();
                      icon = FontAwesomeIcons.minus;
                      color = AppColors.darkOrangeColor;
                      break;
                    case EntryType.income:
                      text = 'income'.tr();
                      icon = FontAwesomeIcons.plus;
                      color = AppColors.successTeal;
                      break;
                    case EntryType.debtCredit:
                      text = 'debt'.tr();
                      icon = FontAwesomeIcons.handshake;
                      color = AppColors.greyColor;
                      break;
                  }

                  return Expanded(
                    child: InkWell(
                      onTap: () => _updateSelectedType(type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withValues(alpha: 0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: isSelected ? color : AppColors.greyColor,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(icon, size: 14, color: color),
                            const SizedBox(width: 8),
                            Text(
                              text,
                              style:
                                  AppTextStyles.listItemTitle(context).copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              // 2. Form Fields
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16.0),
                      // Amount Field
                      CustomInputField(
                        label: '${"amount".tr()} (e.g., 42.85)',
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),

                      // Title/Description Field
                      CustomInputField(
                        label: '${"title".tr()} (e.g., Dinner at Olive Garden)',
                        controller: _titleController,
                      ),

                      // Category Dropdown (for Expense/Income)
                      if (_selectedType == EntryType.expense)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: theme.colorScheme.surface,
                            initialValue: _selectedCategory,
                            decoration: InputDecoration(
                              // hintText: 'Select Category',
                              hintStyle:
                                  AppTextStyles.listItemSubtitle(context),
                              filled: true,
                              fillColor: theme.colorScheme.surface,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: AppTextStyles.listItemTitle(context),
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: theme.colorScheme.primary,
                            ),
                            items: categories.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(
                                  category,
                                  style: AppTextStyles.listItemTitle(context),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCategory = newValue;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'selectCategory'.tr() : null,
                          ),
                        ),

                      // Debt Type Dropdown (for Debt/Credit)
                      if (_selectedType == EntryType.debtCredit)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: theme.colorScheme.surface,
                            initialValue:
                                _selectedDebtType, // Use value instead of initialValue
                            decoration: InputDecoration(
                              // hintText: 'Select Debt Type',
                              hintStyle:
                                  AppTextStyles.listItemSubtitle(context),
                              filled: true,
                              fillColor: theme.colorScheme.surface,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: AppTextStyles.listItemTitle(context),
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: theme.colorScheme.primary,
                            ),
                            items: _debtTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.listItemTitle(context),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDebtType = newValue;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'selectDebtType'.tr() : null,
                          ),
                        ),

                      // Date Field (Clickable to open DatePicker)
                      CustomInputField(
                        label: 'date'.tr(),
                        controller: _dateController,
                        readOnly: true,
                        onTap: _selectDate,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.calendar_month_outlined),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              ),

              // 3. Primary Action Button
              AppButton.main(
                context,
                text: _buttonText,
                onPressed: _logEntry,
                backgroundColor: _primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
