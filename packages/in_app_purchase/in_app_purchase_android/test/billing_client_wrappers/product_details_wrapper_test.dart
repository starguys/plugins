// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/src/types/google_play_product_details.dart';
import 'package:test/test.dart';

const ProductDetailsWrapper dummyProductDetails = ProductDetailsWrapper(
  description: 'This is a test description',
  name: 'Test non-renewing subscription 1',
  productId: 'test.pack.230126',
  productType: SkuType.subs,
  subscriptionOfferDetails: <SubscriptionOfferDetails>[
    SubscriptionOfferDetails(
      basePlanId: 'standard01',
      offerTags: <String>[],
      offerToken:
          r'AUj\/YhhZsl3w+hlJe0LJU52xlM7vvVoYamwaKc8FNA71RIDbAECTXZGiCT2LnAJImpgt4sGQ6z5xr1OlBz0Ou2WgbOJyj3kqE4uhAgpAfjTUymZfQiNDlSpq8g==',
      pricingPhases: <PricingPhase>[
        PricingPhase(
          billingPeriod: 'P6M',
          formattedPrice: '₩99,000',
          priceAmountMicros: 99000000000,
          priceCurrencyCode: 'KRW',
          recurrenceMode: 3,
        ),
      ],
    ),
  ],
  title: 'Test Non-renewing subscription 1 (TestGlider)',
);

void main() {
  group('ProductDetailsWrapper', () {
    test('converts from map', () {
      const ProductDetailsWrapper expected = dummyProductDetails;
      final ProductDetailsWrapper parsed =
          ProductDetailsWrapper.fromJson(buildProductMap(expected));
      expect(parsed, equals(expected));
    });
  });

  group('ProductDetailsWrapper', () {
    test('parsed from map', () {
      const BillingResponse responseCode = BillingResponse.ok;
      const String debugMessage = 'dummy message';
      final List<ProductDetailsWrapper> productDetails =
          <ProductDetailsWrapper>[dummyProductDetails, dummyProductDetails];
      const BillingResultWrapper result = BillingResultWrapper(
          responseCode: responseCode, debugMessage: debugMessage);
      final ProductDetailsResponseWrapper expected =
          ProductDetailsResponseWrapper(
        billingResult: result,
        productDetailsList: productDetails,
      );

      final ProductDetailsResponseWrapper parsed =
          ProductDetailsResponseWrapper.fromJson(<String, dynamic>{
        'billingResult': <String, dynamic>{
          'responseCode': const BillingResponseConverter().toJson(responseCode),
          'debugMessage': debugMessage,
        },
        'productDetailsList': <Map<String, dynamic>>[
          buildProductMap(dummyProductDetails),
          buildProductMap(dummyProductDetails)
        ]
      });

      expect(parsed.billingResult, equals(expected.billingResult));
      expect(
          parsed.productDetailsList, containsAll(expected.productDetailsList));
    });

    test('toProductDetails() should return correct Product object', () {
      final ProductDetailsWrapper wrapper =
          ProductDetailsWrapper.fromJson(buildProductMap(dummyProductDetails));
      final GooglePlayProductDetails product =
          GooglePlayProductDetails.fromProductDetails(wrapper);
      expect(product.title, wrapper.title);
      expect(product.description, wrapper.description);
      expect(product.id, wrapper.productId);
      expect(product.price, wrapper.price);
      expect(product.productDetails, wrapper);
    });

    test('handles empty list of skuDetails', () {
      const BillingResponse responseCode = BillingResponse.error;
      const String debugMessage = 'dummy message';
      final List<ProductDetailsWrapper> skusDetails = <ProductDetailsWrapper>[];
      const BillingResultWrapper billingResult = BillingResultWrapper(
          responseCode: responseCode, debugMessage: debugMessage);
      final ProductDetailsResponseWrapper expected =
          ProductDetailsResponseWrapper(
        billingResult: billingResult,
        productDetailsList: skusDetails,
      );

      final ProductDetailsResponseWrapper parsed =
          ProductDetailsResponseWrapper.fromJson(<String, dynamic>{
        'billingResult': <String, dynamic>{
          'responseCode': const BillingResponseConverter().toJson(responseCode),
          'debugMessage': debugMessage,
        },
        'productDetailsList': const <Map<String, dynamic>>[]
      });

      expect(parsed.billingResult, equals(expected.billingResult));
      expect(
          parsed.productDetailsList, containsAll(expected.productDetailsList));
    });

    test('fromJson creates an object with default values', () {
      final ProductDetailsResponseWrapper skuDetails =
          ProductDetailsResponseWrapper.fromJson(const <String, dynamic>{});
      expect(
          skuDetails.billingResult,
          equals(const BillingResultWrapper(
              responseCode: BillingResponse.error,
              debugMessage: kInvalidBillingResultErrorMessage)));
      expect(skuDetails.productDetailsList, isEmpty);
    });
  });

  group('BillingResultWrapper', () {
    test('fromJson on empty map creates an object with default values', () {
      final BillingResultWrapper billingResult =
          BillingResultWrapper.fromJson(const <String, dynamic>{});
      expect(billingResult.debugMessage, kInvalidBillingResultErrorMessage);
      expect(billingResult.responseCode, BillingResponse.error);
    });

    test('fromJson on null creates an object with default values', () {
      final BillingResultWrapper billingResult =
          BillingResultWrapper.fromJson(null);
      expect(billingResult.debugMessage, kInvalidBillingResultErrorMessage);
      expect(billingResult.responseCode, BillingResponse.error);
    });

    test('operator == of ProductDetailsWrapper works fine', () {
      const ProductDetailsWrapper firstSkuDetailsInstance =
          ProductDetailsWrapper(
        description: 'This is a test description',
        name: '테스트 선불 구독1',
        productId: 'test.pack.230126',
        productType: SkuType.subs,
        subscriptionOfferDetails: <SubscriptionOfferDetails>[
          SubscriptionOfferDetails(
            basePlanId: 'standard01',
            offerId: 'standard0101',
            offerTags: <String>[],
            offerToken:
                r'AUj\/YhhMKE1Vxl+FP3Pw\/XDyFTV+RUyiOh6Gt7KXDzCOcJnPsYTszAPoaFQJ3skn1bJQXICBZkR6o7E4eKIHoU40Jvr1uA5QmnyEcEu+StUzO9M=',
            pricingPhases: <PricingPhase>[
              PricingPhase(
                billingPeriod: 'P3M',
                formattedPrice: '₩120,000',
                priceAmountMicros: 120000000000,
                priceCurrencyCode: 'KRW',
                recurrenceMode: 3,
              ),
            ],
          ),
        ],
        title: '테스트 선불 구독1 (TestGlider for Stage)',
      );
      const ProductDetailsWrapper secondSkuDetailsInstance =
          ProductDetailsWrapper(
        description: 'This is a test description',
        name: '테스트 선불 구독1',
        productId: 'test.pack.230126',
        productType: SkuType.subs,
        subscriptionOfferDetails: <SubscriptionOfferDetails>[
          SubscriptionOfferDetails(
            basePlanId: 'standard01',
            offerId: 'standard0101',
            offerTags: <String>[],
            offerToken:
                r'AUj\/YhhMKE1Vxl+FP3Pw\/XDyFTV+RUyiOh6Gt7KXDzCOcJnPsYTszAPoaFQJ3skn1bJQXICBZkR6o7E4eKIHoU40Jvr1uA5QmnyEcEu+StUzO9M=',
            pricingPhases: <PricingPhase>[
              PricingPhase(
                billingPeriod: 'P3M',
                formattedPrice: '₩120,000',
                priceAmountMicros: 120000000000,
                priceCurrencyCode: 'KRW',
                recurrenceMode: 3,
              ),
            ],
          ),
        ],
        title: '테스트 선불 구독1 (TestGlider for Stage)',
      );
      expect(firstSkuDetailsInstance == secondSkuDetailsInstance, isTrue);
    });

    test('operator == of BillingResultWrapper works fine', () {
      const BillingResultWrapper firstBillingResultInstance =
          BillingResultWrapper(
        responseCode: BillingResponse.ok,
        debugMessage: 'debugMessage',
      );
      const BillingResultWrapper secondBillingResultInstance =
          BillingResultWrapper(
        responseCode: BillingResponse.ok,
        debugMessage: 'debugMessage',
      );
      expect(firstBillingResultInstance == secondBillingResultInstance, isTrue);
    });
  });
}

Map<String, dynamic> buildProductMap(ProductDetailsWrapper original) {
  return <String, dynamic>{
    'description': original.description,
    'name': original.name,
    'productId': original.productId,
    'productType': original.productType.name,
    'subscriptionOfferDetails': [
      {
        'offerToken':
            r'AUj\/YhhZsl3w+hlJe0LJU52xlM7vvVoYamwaKc8FNA71RIDbAECTXZGiCT2LnAJImpgt4sGQ6z5xr1OlBz0Ou2WgbOJyj3kqE4uhAgpAfjTUymZfQiNDlSpq8g==',
        'basePlanId': 'standard01',
        'pricingPhases': [
          {
            'priceAmountMicros': 99000000000,
            'priceCurrencyCode': 'KRW',
            'formattedPrice': '₩99,000',
            'billingPeriod': 'P6M',
            'recurrenceMode': 3
          }
        ],
        'offerTags': <String>[]
      },
    ],
    'title': original.title,
  };
}
