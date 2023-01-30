import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'billing_client_wrapper.dart';
import 'sku_details_wrapper.dart';

part 'product_details_wrapper.g.dart';

@JsonSerializable()
@immutable
class OneTimePurchaseOfferDetails {
  @visibleForTesting
  const OneTimePurchaseOfferDetails({
    required this.formattedPrice,
    required this.priceAmountMicros,
    required this.priceCurrencyCode,
  });

  factory OneTimePurchaseOfferDetails.fromJson(Map<String, dynamic> map) =>
      _$OneTimePurchaseOfferDetailsFromJson(map);

  final String formattedPrice;

  final int priceAmountMicros;

  final String priceCurrencyCode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is OneTimePurchaseOfferDetails &&
        other.formattedPrice == formattedPrice &&
        other.priceAmountMicros == priceAmountMicros &&
        other.priceCurrencyCode == priceCurrencyCode;
  }

  @override
  int get hashCode => Object.hash(
        formattedPrice,
        priceAmountMicros,
        priceCurrencyCode,
      );
}

@JsonSerializable()
@immutable
class PricingPhase {
  @visibleForTesting
  const PricingPhase({
    this.billingCycleCount,
    required this.billingPeriod,
    required this.formattedPrice,
    required this.priceAmountMicros,
    required this.priceCurrencyCode,
    required this.recurrenceMode,
  });
  factory PricingPhase.fromJson(Map<String, dynamic> map) =>
      _$PricingPhaseFromJson(map);
  final int? billingCycleCount;

  final String billingPeriod;

  final String formattedPrice;

  final int priceAmountMicros;

  final String priceCurrencyCode;

  final int recurrenceMode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is PricingPhase &&
        other.billingCycleCount == billingCycleCount &&
        other.billingPeriod == billingPeriod &&
        other.formattedPrice == formattedPrice &&
        other.priceAmountMicros == priceAmountMicros &&
        other.priceCurrencyCode == priceCurrencyCode &&
        other.recurrenceMode == recurrenceMode;
  }

  @override
  int get hashCode => Object.hash(
        billingCycleCount,
        billingPeriod,
        formattedPrice,
        priceAmountMicros,
        priceCurrencyCode,
        recurrenceMode,
      );
}

@JsonSerializable()
@immutable
class SubscriptionOfferDetails {
  @visibleForTesting
  const SubscriptionOfferDetails({
    required this.basePlanId,
    this.offerId,
    required this.offerTags,
    required this.offerToken,
    required this.pricingPhases,
  });

  factory SubscriptionOfferDetails.fromJson(Map<String, dynamic> map) =>
      _$SubscriptionOfferDetailsFromJson(map);

  final String basePlanId;

  final String? offerId;

  final List<String> offerTags;

  final String offerToken;

  final List<PricingPhase> pricingPhases;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SubscriptionOfferDetails &&
        other.basePlanId == basePlanId &&
        other.offerId == offerId &&
        other.offerTags == offerTags &&
        other.offerToken == offerToken &&
        other.pricingPhases == pricingPhases;
  }

  @override
  int get hashCode => Object.hash(
        basePlanId,
        offerId,
        offerTags,
        offerToken,
        pricingPhases,
      );

  @override
  String toString() {
    return '''
    $basePlanId,
    $offerId,
    ${offerTags.toString()}
    $offerToken,
    $pricingPhases,
''';
  }
}

@JsonSerializable()
@immutable
class ProductDetailsWrapper {
  const ProductDetailsWrapper({
    required this.description,
    required this.name,
    this.oneTimePurchaseOfferDetails,
    required this.productId,
    required this.productType,
    this.subscriptionOfferDetails,
    required this.title,
  }) : assert((oneTimePurchaseOfferDetails != null ||
                subscriptionOfferDetails == null) ||
            (oneTimePurchaseOfferDetails == null ||
                subscriptionOfferDetails != null));

  factory ProductDetailsWrapper.fromJson(Map<String, dynamic> map) =>
      _$ProductDetailsWrapperFromJson(map);

  final String description;

  final String name;

  final OneTimePurchaseOfferDetails? oneTimePurchaseOfferDetails;

  final String productId;

  final SkuType productType;

  final List<SubscriptionOfferDetails>? subscriptionOfferDetails;

  final String title;

  String? get price =>
      oneTimePurchaseOfferDetails?.formattedPrice ??
      subscriptionOfferDetails?.first.pricingPhases.first.formattedPrice;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is ProductDetailsWrapper &&
        other.description == description &&
        other.name == name &&
        other.oneTimePurchaseOfferDetails == oneTimePurchaseOfferDetails &&
        other.productId == productId &&
        other.productType == productType &&
        other.subscriptionOfferDetails.toString() ==
            subscriptionOfferDetails.toString() &&
        other.title == title;
  }

  @override
  int get hashCode {
    return Object.hash(
      description,
      name,
      oneTimePurchaseOfferDetails,
      productId,
      productType,
      subscriptionOfferDetails,
      title,
    );
  }

  @visibleForTesting
  @override
  String toString() {
    return '''
    $description,
    $name,
    ${oneTimePurchaseOfferDetails.toString()},
    $productId,
    $productType
    ${subscriptionOfferDetails.toString()},
    $title,
''';
  }
}

@JsonSerializable()
@immutable
class ProductDetailsResponseWrapper {
  const ProductDetailsResponseWrapper({
    required this.billingResult,
    required this.productDetailsList,
  });

  factory ProductDetailsResponseWrapper.fromJson(Map<String, dynamic> map) =>
      _$ProductDetailsResponseWrapperFromJson(map);

  final BillingResultWrapper billingResult;

  @JsonKey(defaultValue: <ProductDetailsWrapper>[])
  final List<ProductDetailsWrapper> productDetailsList;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is ProductDetailsResponseWrapper &&
        other.billingResult == billingResult &&
        other.productDetailsList == productDetailsList;
  }

  @override
  int get hashCode => Object.hash(billingResult, productDetailsList);
}
