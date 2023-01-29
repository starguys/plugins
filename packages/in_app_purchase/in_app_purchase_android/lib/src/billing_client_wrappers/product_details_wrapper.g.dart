// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_wrapper.dart';

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
      billingCycleCount: json['billingCycleCount'] as int?,
      billingPeriod: json['billingPeriod'] as String,
      formattedPrice: json['formattedPrice'] as String,
      priceAmountMicros: json['priceAmountMicros'] as int,
      priceCurrencyCode: json['priceCurrencyCode'] as String,
      recurrenceMode: json['recurrenceMode'] as int,
    );

SubscriptionOfferDetails _$SubscriptionOfferDetailsFromJson(Map json) =>
    SubscriptionOfferDetails(
      basePlanId: json['basePlanId'] as String,
      offerId: json['offerId'] as String?,
      offerTags:
          (json['offerTags'] as List<dynamic>).map((e) => e as String).toList(),
      offerIdToken: json['offerIdToken'] as String,
      pricingPhases: (json['pricingPhases'] as List<dynamic>)
          .map(
              (e) => PricingPhase.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

ProductDetailsWrapper _$ProductDetailsWrapperFromJson(Map json) =>
    ProductDetailsWrapper(
      description: json['description'] as String,
      name: json['name'] as String,
      oneTimePurchaseOfferDetails: json['oneTimePurchaseOfferDetails'] == null
          ? null
          : OneTimePurchaseOfferDetails.fromJson(Map<String, dynamic>.from(
              json['oneTimePurchaseOfferDetails'] as Map)),
      productId: json['productId'] as String,
      productType: $enumDecode(_$SkuTypeEnumMap, json['productType']),
      subscriptionOfferDetails:
          (json['subscriptionOfferDetails'] as List<dynamic>?)
              ?.map((e) => SubscriptionOfferDetails.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList(),
      title: json['title'] as String,
    );

const _$SkuTypeEnumMap = {
  SkuType.inapp: 'inapp',
  SkuType.subs: 'subs',
};

ProductDetailsResponseWrapper _$ProductDetailsResponseWrapperFromJson(
        Map json) =>
    ProductDetailsResponseWrapper(
      billingResult:
          BillingResultWrapper.fromJson((json['billingResult'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e),
      )),
      productDetailsList: (json['productDetailsList'] as List<dynamic>?)
              ?.map((e) => ProductDetailsWrapper.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    );
