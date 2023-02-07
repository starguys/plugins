// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

import '../../billing_client_wrappers.dart';
import '../billing_client_wrappers/product_details_wrapper.dart';

/// The class represents the information of a product as registered in at
/// Google Play store front.
class GooglePlayProductDetails extends ProductDetails {
  /// Creates a new Google Play specific product details object with the
  /// provided details.
  GooglePlayProductDetails({
    required String id,
    required String title,
    required String description,
    required String price,
    required double rawPrice,
    required String currencyCode,
    required this.productDetails,
    required String currencySymbol,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          rawPrice: rawPrice,
          currencyCode: currencyCode,
          currencySymbol: currencySymbol,
        );

  /// Generate a [GooglePlayProductDetails] object based on an Android
  /// [ProductDetailsWrapper] object.
  factory GooglePlayProductDetails.fromProductDetails(
    ProductDetailsWrapper productDetails,
  ) {
    return GooglePlayProductDetails(
      id: productDetails.productId,
      title: productDetails.name,
      description: productDetails.description,
      price: productDetails.price ?? 'unknown',
      rawPrice:
          (productDetails.oneTimePurchaseOfferDetails?.priceAmountMicros ??
                  productDetails.subscriptionOfferDetails?.first.pricingPhases
                      .first.priceAmountMicros ??
                  0) /
              1000000.0,
      currencyCode:
          productDetails.oneTimePurchaseOfferDetails?.priceCurrencyCode ??
              productDetails.subscriptionOfferDetails?.first.pricingPhases.first
                  .priceCurrencyCode ??
              'USD',
      currencySymbol:
          productDetails.oneTimePurchaseOfferDetails?.formattedPrice[0] ??
              productDetails.subscriptionOfferDetails?.first.pricingPhases.first
                  .formattedPrice[0] ??
              r'$',
      productDetails: productDetails,
    );
  }

  /// Points back to the [ProductDetailsWrapper] object that was used to generate
  /// this [GooglePlayProductDetails] object.
  final ProductDetailsWrapper productDetails;
}
