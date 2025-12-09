import 'dart:io';
import 'package:csv/csv.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../ContValues.dart';
import 'TransactionModel/TransactionModel.dart';

class TransactionExporter {
  /// EXPORT CSV ---------------------------------------------------------------
  static Future<void> exportAsCsv(List<TransactionModel> transactions) async {
    try {
      final rows = [
        ["Title", "Amount", "Date"],
        ...transactions.map((t) => [t.title, t.spentAmount.toString(), t.date])
      ];

      String csvData = const ListToCsvConverter().convert(rows);

      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/transactions_export.csv");

      await file.writeAsString(csvData);

      await OpenFile.open(file.path);
    } catch (e) {
      rethrow;
    }
  }

  /// EXPORT PDF ---------------------------------------------------------------
  static Future<void> exportAsPdf(List<TransactionModel> transactions) async {
    try {
      totalTransaction() {
        if (transactions.isEmpty) {
          return '0.0';
        }
        double total = 0.0;
        for (var transaction in transactions) {
          total += transaction.spentAmount ?? 0.0;
        }
        final String formattedAmount =
            '-${getCurrencySymbol()} ${total.abs().toStringAsFixed(2)}';
        return formattedAmount;
      }

      final pdf = pw.Document();
      String total = totalTransaction();

      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Transactions Export",
                style:
                    pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ["Title", "Amount", "Date"],
                data: transactions
                    .map((t) => [t.title, t.spentAmount.toString(), t.date])
                    .toList(),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Total: $total',
                style: pw.TextStyle(
                  fontSize: 20.0,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      );

      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/transactions_export.pdf");

      await file.writeAsBytes(await pdf.save());
      await OpenFile.open(file.path);
    } catch (e) {
      rethrow;
    }
  }
}
