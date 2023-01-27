// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_product_details_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneTimePurchaseOfferDetails _$OneTimePurchaseOfferDetailsFromJson(Map json) =>
    OneTimePurchaseOfferDetails(
      formattedPrice: json['formattedPrice'] as String,
      priceAmountMicros: json['priceAmountMicros'] as int,
      priceCurrencyCode: json['priceCurrencyCode'] as String,
    );

PricingPhase _$PricingPhaseFromJson(Map json) => PricingPhase(
      billingCycleCount: json['billingCycleCount'] as int,
      billingPeriod: json['billingPeriod'] as String,
      formattedPrice: json['formattedPrice'] as String,
      priceAmountMicros: json['priceAmountMicros'] as int,
      priceCurrencyCode: json['priceCurrencyCode'] as String,
      recurrenceMode: json['recurrenceMode'] as int,
    );

PricingPhases _$PricingPhasesFromJson(Map json) => PricingPhases(
      pricingPhaseList: (json['pricingPhaseList'] as List<dynamic>)
          .map((e) => PricingPhase.fromJson(e as Map))
          .toList(),
    );

SubscriptionOfferDetails _$SubscriptionOfferDetailsFromJson(Map json) =>
    SubscriptionOfferDetails(
      basePlanId: json['basePlanId'] as String,
      offerId: json['offerId'] as String,
      offerTags:
          (json['offerTags'] as List<dynamic>).map((e) => e as String).toList(),
      offerToken: json['offerToken'] as String,
      pricingPhases: PricingPhases.fromJson(json['pricingPhases'] as Map),
    );

QueryProductDetailsWrapper _$QueryProductDetailsWrapperFromJson(Map json) =>
    QueryProductDetailsWrapper(
      description: json['description'] as String,
      name: json['name'] as String,
      oneTimePurchaseOfferDetails: OneTimePurchaseOfferDetails.fromJson(
          json['oneTimePurchaseOfferDetails'] as Map),
      productId: json['productId'] as String,
      productType:
          const SkuTypeConverter().fromJson(json['productType'] as String?),
      subscriptionOfferDetails:
          (json['subscriptionOfferDetails'] as List<dynamic>)
              .map((e) => SubscriptionOfferDetails.fromJson(e as Map))
              .toList(),
      title: json['title'] as String,
    );
