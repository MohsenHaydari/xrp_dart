import 'package:xrpl_dart/src/rpc/methods/methods.dart';
import 'package:xrpl_dart/src/rpc/on_chain_models/on_chain_models.dart';
import '../core/methods_impl.dart';

/// This request retrieves a list of offers made by a given account that are
/// outstanding as of a particular ledger version.
/// See [account_offers](https://xrpl.org/account_offers.html)
class RPCAccountOffer extends XRPLedgerRequest<Map<String, dynamic>> {
  RPCAccountOffer({
    required this.account,
    this.strict = false,
    this.limit,
    this.marker,
    XRPLLedgerIndex? ledgerIndex = XRPLLedgerIndex.validated,
  }) : super(ledgerIndex: ledgerIndex);
  @override
  String get method => XRPRequestMethod.accountOffers;

  final String account;
  final int? limit;
  final bool strict;
  final dynamic marker;

  @override
  Map<String, dynamic> toJson() {
    return {
      "account": account,
      "strict": strict,
      "limit": limit,
      "marker": marker
    };
  }
}
