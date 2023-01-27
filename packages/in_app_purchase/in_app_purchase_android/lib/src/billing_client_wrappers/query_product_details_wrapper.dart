import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'billing_client_wrapper.dart';

part 'query_product_details_wrapper.g.dart';

@JsonSerializable()
@immutable
class OneTimePurchaseOfferDetails {
  @visibleForTesting
  const OneTimePurchaseOfferDetails({
    required this.formattedPrice,
    required this.priceAmountMicros,
    required this.priceCurrencyCode,
  });

  final String formattedPrice;

  final int priceAmountMicros;

  final String priceCurrencyCode;
}

@JsonSerializable()
@immutable
class PricingPhase {
  @visibleForTesting
  const PricingPhase({
    required this.billingCycleCount,
    required this.billingPeriod,
    required this.formattedPrice,
    required this.priceAmountMicros,
    required this.priceCurrencyCode,
    required this.recurrenceMode,
  });

  final int billingCycleCount;

  final String billingPeriod;

  final String formattedPrice;

  final int priceAmountMicros;

  final String priceCurrencyCode;

  final int recurrenceMode;
}

@JsonSerializable()
@immutable
class PricingPhases {
  @visibleForTesting
  const PricingPhases({
    required this.pricingPhaseList,
  });

  final List<PricingPhase> pricingPhaseList;
}

@JsonSerializable()
@immutable
class SubscriptionOfferDetails {
  @visibleForTesting
  const SubscriptionOfferDetails({
    required this.basePlanId,
    required this.offerId,
    required this.offerTags,
    required this.offerToken,
    required this.pricingPhases,
  });

  final String basePlanId;

  final String offerId;

  final List<String> offerTags;

  final String offerToken;

  final PricingPhases pricingPhases;
}

@JsonSerializable()
@SkuTypeConverter()
@immutable
class QueryProductDetailsWrapper {
  @visibleForTesting
  const QueryProductDetailsWrapper({
    required this.description,
    required this.name,
    required this.oneTimePurchaseOfferDetails,
    required this.productId,
    required this.productType,
    required this.subscriptionOfferDetails,
    required this.title,
  });

  final String description;

  final String name;

  final OneTimePurchaseOfferDetails oneTimePurchaseOfferDetails;

  final String productId;

  final SkuType productType;

  final List<SubscriptionOfferDetails> subscriptionOfferDetails;

  final String title;
}
