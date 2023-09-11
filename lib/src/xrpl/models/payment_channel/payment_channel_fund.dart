import 'package:xrp_dart/src/formating/bytes_num_formating.dart';
import 'package:xrp_dart/src/xrpl/models/transaction.dart';
import 'package:xrp_dart/src/xrpl/models/transaction_types.dart';
import 'package:xrp_dart/src/xrpl/utilities.dart';

/// Represents a `PaymentChannelFund <https://xrpl.org/paymentchannelfund.html>`_
/// transaction, adds additional XRP to an open `payment channel
/// <https://xrpl.org/payment-channels.html>`_, and optionally updates the
/// expiration time of the channel. Only the source address
/// of the channel can use this transaction.
class PaymentChannelFund extends XRPTransaction {
  final String channel;

  final BigInt amount;
  late final int? expiration;

  /// [channel] The unique ID of the payment channel, as a 64-character hexadecimal
  ///  string.
  /// [amount] The amount of XRP, in drops, to add to the channel.
  /// [expiration] A new mutable expiration time to set for the channel,
  /// This must be later than the existing expiration time of the
  /// channel or later than the current time plus the settle delay of the channel.
  /// This is separate from the immutable ``cancel_after`` time.
  PaymentChannelFund({
    required super.account,
    required this.channel,
    required this.amount,
    super.memos,
    super.ticketSequance,
    DateTime? expirationTime,
    super.signingPubKey,
    super.sequence,
    super.fee,
    super.lastLedgerSequence,
  }) : super(transactionType: XRPLTransactionType.PAYMENT_CHANNEL_FUND) {
    if (expirationTime != null) {
      expiration = datetimeToRippleTime(expirationTime);
    } else {
      expiration = null;
    }
  }
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    addWhenNotNull(json, "channel", channel);
    addWhenNotNull(json, "amount", amount.toString());
    addWhenNotNull(json, "expiration", expiration);
    return json;
  }

  PaymentChannelFund.fromJson(Map<String, dynamic> json)
      : channel = json["channel"],
        amount = parseBigInt(json["amount"])!,
        expiration = json["expiration"],
        super.json(json);
}
