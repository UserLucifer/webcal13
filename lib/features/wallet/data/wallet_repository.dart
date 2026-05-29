import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/pagination.dart';
import '../../../shared/models/app_models.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository(ref.watch(apiClientProvider));
});

final walletProvider = FutureProvider<WalletInfo>((ref) {
  return ref.watch(walletRepositoryProvider).wallet();
});

final tokenWalletProvider = FutureProvider<TokenWalletInfo>((ref) {
  return ref.watch(walletRepositoryProvider).tokenWallet();
});

final walletTransactionsProvider =
    FutureProvider<PageResult<WalletTransaction>>((ref) {
      return ref.watch(walletRepositoryProvider).transactions();
    });

final tokenWalletTransactionsProvider =
    FutureProvider<PageResult<WalletTransaction>>((ref) {
      return ref.watch(walletRepositoryProvider).tokenTransactions();
    });

final walletTransactionProvider =
    FutureProvider.family<WalletTransaction, String>(
      (ref, txNo) => ref.watch(walletRepositoryProvider).transaction(txNo),
    );

final tokenWalletTransactionProvider =
    FutureProvider.family<WalletTransaction, String>(
      (ref, txNo) => ref.watch(walletRepositoryProvider).tokenTransaction(txNo),
    );

class WalletRepository {
  const WalletRepository(this._api);

  final ApiClient _api;

  Future<WalletInfo> wallet() async {
    final data = await _api.get('/api/wallet/me');
    return parseObject(data, WalletInfo.fromJson);
  }

  Future<TokenWalletInfo> tokenWallet() async {
    final data = await _api.get('/api/token-wallet/me');
    return parseObject(data, TokenWalletInfo.fromJson);
  }

  Future<PageResult<WalletTransaction>> transactions({int pageNo = 1}) async {
    final data = await _api.get(
      '/api/wallet/transactions',
      queryParameters: {'pageNo': pageNo, 'pageSize': 20},
    );
    return parsePage(data, WalletTransaction.fromJson);
  }

  Future<WalletTransaction> transaction(String txNo) async {
    final data = await _api.get(
      '/api/wallet/transactions',
      queryParameters: {'pageNo': 1, 'pageSize': 1, 'txNo': txNo},
    );
    final page = parsePage(data, WalletTransaction.fromJson);
    final transaction = _findTransaction(page.records, txNo);
    if (transaction == null) {
      throw const ApiException('流水记录不存在');
    }
    return transaction;
  }

  Future<PageResult<WalletTransaction>> tokenTransactions({
    int pageNo = 1,
    int pageSize = 20,
  }) async {
    final data = await _api.get(
      '/api/token-wallet/transactions',
      queryParameters: {'pageNo': pageNo, 'pageSize': pageSize},
    );
    return parsePage(data, WalletTransaction.fromJson);
  }

  Future<WalletTransaction> tokenTransaction(String txNo) async {
    const pageSize = 100;
    var pageNo = 1;
    while (true) {
      final page = await tokenTransactions(pageNo: pageNo, pageSize: pageSize);
      final transaction = _findTransaction(page.records, txNo);
      if (transaction != null) {
        return transaction;
      }
      final loadedCount = pageNo * page.pageSize;
      if (page.records.isEmpty || loadedCount >= page.total) {
        throw const ApiException('Token 流水记录不存在');
      }
      pageNo += 1;
    }
  }

  WalletTransaction? _findTransaction(
    List<WalletTransaction> records,
    String txNo,
  ) {
    for (final record in records) {
      if (record.txNo == txNo || record.walletTxNo == txNo) {
        return record;
      }
    }
    return null;
  }
}
