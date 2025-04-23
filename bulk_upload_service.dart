import 'package:excel/excel.dart';
import 'dart:io';
import 'firestore_service.dart';
import 'package:tncsc_hulling_admin_app/models/paddy_received_model.dart';
import 'package:tncsc_hulling_admin_app/models/rice_deposited_model.dart';
import 'package:tncsc_hulling_admin_app/models/gunny_deposits_model.dart';
import 'package:tncsc_hulling_admin_app/models/frk_received_model.dart';

class BulkUploadService {
  final FirestoreService _firestoreService = FirestoreService();

  /// Generic method to process rows from an Excel file and upload using the provided upload function
  Future<void> processExcelRows<T>(
      String filePath, T Function(List<Data?> row) parseRow, Future<void> Function(T data) uploadFunction) async {
    try {
      var fileBytes = File(filePath).readAsBytesSync();
      var excel = Excel.decodeBytes(fileBytes);

      int successCount = 0;
      int errorCount = 0;

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          try {
            var data = parseRow(row);
            await uploadFunction(data);
            successCount++;
          } catch (e) {
            errorCount++;
            print('Error processing row: $row\nError: $e');
          }
        }
      }

      print('Upload complete. Success: $successCount, Errors: $errorCount');
    } catch (e) {
      print('Error reading file: $filePath\nError: $e');
    }
  }

  /// Bulk upload for Paddy Received
  Future<void> bulkUploadPaddy(String filePath) async {
    await processExcelRows<PaddyReceivedModel>(
      filePath,
          (row) => PaddyReceivedModel(
        id: '', // Provide a default value for the id
        date: DateTime.parse(row[0]?.toString() ?? ''),
        lorryNumber: row[1]?.toString() ?? '',
        issueMemoNumber: row[2]?.toString() ?? '',
        variety: row[3]?.toString() ?? '',
        bagsCount: int.parse(row[4]?.toString() ?? '0'),
        weightKg: double.parse(row[5]?.toString() ?? '0.0'),
        nb: int.parse(row[6]?.toString() ?? '0'),
        onb: int.parse(row[7]?.toString() ?? '0'),
        ss: int.parse(row[8]?.toString() ?? '0'),
        swp: int.parse(row[9]?.toString() ?? '0'),
        us: int.parse(row[10]?.toString() ?? '0'),
        place: row[11]?.toString() ?? '',
        kmsYear: row[12]?.toString() ?? '',
      ),
          (data) => _firestoreService.addPaddyReceived(data), // Pass model object directly
    );
  }

  /// Bulk upload for Rice Deposited
  Future<void> bulkUploadRice(String filePath) async {
    await processExcelRows<RiceDepositedModel>(
      filePath,
          (row) => RiceDepositedModel(
        id: '', // Provide a default value for the id
        date: DateTime.parse(row[0]?.toString() ?? ''),
        lorryNumber: row[1]?.toString() ?? '',
        truckMemoNumber: row[2]?.toString() ?? '',
        acknowledgmentNumber: row[3]?.toString() ?? '',
        variety: row[4]?.toString() ?? '',
        bagsCount: int.parse(row[5]?.toString() ?? '0'),
        weightKg: double.parse(row[6]?.toString() ?? '0.0'),
        nb: int.parse(row[7]?.toString() ?? '0'),
        onb: int.parse(row[8]?.toString() ?? '0'),
        ss: int.parse(row[9]?.toString() ?? '0'),
        swp: int.parse(row[10]?.toString() ?? '0'),
        us: int.parse(row[11]?.toString() ?? '0'),
        depositLocation: row[12]?.toString() ?? '',
        kmsYear: row[13]?.toString() ?? '',
      ),
          (data) => _firestoreService.addRiceDeposited(data), // Pass model object directly
    );
  }

  /// Bulk upload for FRK Received
  Future<void> bulkUploadFrk(String filePath) async {
    await processExcelRows<FrkReceivedModel>(
      filePath,
          (row) => FrkReceivedModel(
        id: '', // Provide a default value for the id
        date: DateTime.parse(row[0]?.toString() ?? ''),
        lorryNumber: row[1]?.toString() ?? '',
        invoiceNumber: row[2]?.toString() ?? '',
        bagsCount: int.parse(row[3]?.toString() ?? '0'),
        weightKg: double.parse(row[4]?.toString() ?? '0.0'),
      ),
          (data) => _firestoreService.addFrkReceived(data), // Pass model object directly
    );
  }

  /// Bulk upload for Gunny Deposited
  Future<void> bulkUploadGunny(String filePath) async {
    await processExcelRows<GunnyDepositedModel>(
      filePath,
          (row) => GunnyDepositedModel(
        id: '', // Provide a default value for the id
        truckMemoNumber: row[1]?.toString() ?? '',
        date: DateTime.parse(row[2]?.toString() ?? ''),
        acknowledgmentNumber: row[3]?.toString() ?? '',
        noOfBundlesOnb: int.parse(row[4]?.toString() ?? '0'),
        noOfUnitsOnb: int.parse(row[5]?.toString() ?? '0'),
        noOfBundlesSs: int.parse(row[6]?.toString() ?? '0'),
        noOfUnitsSs: int.parse(row[7]?.toString() ?? '0'),
        noOfBundlesSwp: int.parse(row[8]?.toString() ?? '0'),
        noOfUnitsSwp: int.parse(row[9]?.toString() ?? '0'),
        noOfBundlesUs: int.parse(row[10]?.toString() ?? '0'),
        noOfUnitsUs: int.parse(row[11]?.toString() ?? '0'),
        place: row[12]?.toString() ?? '',
        lorryNumber: row[13]?.toString() ?? '',
        kmsYear: row[14]?.toString() ?? '',
      ),
          (data) => _firestoreService.addGunnyDeposited(data), // Pass model object directly
    );
  }
}