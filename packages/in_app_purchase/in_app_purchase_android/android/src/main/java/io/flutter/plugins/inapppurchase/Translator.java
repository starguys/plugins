// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.inapppurchase;

import android.util.Log;

import androidx.annotation.Nullable;

import com.android.billingclient.api.AccountIdentifiers;
import com.android.billingclient.api.BillingResult;
import com.android.billingclient.api.ProductDetails;
import com.android.billingclient.api.Purchase;
import com.android.billingclient.api.PurchaseHistoryRecord;
import com.android.billingclient.api.SkuDetails;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Currency;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

/**
 * Handles serialization of {@link com.android.billingclient.api.BillingClient} related objects.
 */
/*package*/ class Translator {
    static HashMap<String, Object> fromSkuDetail(SkuDetails detail) {
        HashMap<String, Object> info = new HashMap<>();
        info.put("title", detail.getTitle());
        info.put("description", detail.getDescription());
        info.put("freeTrialPeriod", detail.getFreeTrialPeriod());
        info.put("introductoryPrice", detail.getIntroductoryPrice());
        info.put("introductoryPriceAmountMicros", detail.getIntroductoryPriceAmountMicros());
        info.put("introductoryPriceCycles", detail.getIntroductoryPriceCycles());
        info.put("introductoryPricePeriod", detail.getIntroductoryPricePeriod());
        info.put("price", detail.getPrice());
        info.put("priceAmountMicros", detail.getPriceAmountMicros());
        info.put("priceCurrencyCode", detail.getPriceCurrencyCode());
        info.put("priceCurrencySymbol", currencySymbolFromCode(detail.getPriceCurrencyCode()));
        info.put("sku", detail.getSku());
        info.put("type", detail.getType());
        info.put("subscriptionPeriod", detail.getSubscriptionPeriod());
        info.put("originalPrice", detail.getOriginalPrice());
        info.put("originalPriceAmountMicros", detail.getOriginalPriceAmountMicros());
        return info;
    }

    static List<HashMap<String, Object>> fromSkuDetailsList(
            @Nullable List<SkuDetails> skuDetailsList) {
        if (skuDetailsList == null) {
            return Collections.emptyList();
        }

        ArrayList<HashMap<String, Object>> output = new ArrayList<>();
        for (SkuDetails detail : skuDetailsList) {
            output.add(fromSkuDetail(detail));
        }
        return output;
    }

    static HashMap<String, Object> fromProductDetails(ProductDetails detail) {
        final HashMap<String, Object> info = new HashMap<>();
        info.put("description", detail.getDescription());
        info.put("name", detail.getName());
        info.put("productId", detail.getProductId());
        info.put("productType", detail.getProductType());
        info.put("title", detail.getTitle());

        final HashMap<String, Object> oneTimePurchaseInfo = new HashMap<>();
        oneTimePurchaseInfo.put("formattedPrice", detail.getOneTimePurchaseOfferDetails().getFormattedPrice());
        oneTimePurchaseInfo.put("priceAmountMicros", detail.getOneTimePurchaseOfferDetails().getPriceAmountMicros());
        oneTimePurchaseInfo.put("priceCurrencyCode", detail.getOneTimePurchaseOfferDetails().getPriceCurrencyCode());
        info.put("oneTimePurchaseOfferDetails", oneTimePurchaseInfo);

        if (detail.getSubscriptionOfferDetails() != null) {
            final List<HashMap<String, Object>> subscriptionInfo = new ArrayList<>();
            for (final ProductDetails.SubscriptionOfferDetails subscriptionOfferDetails : detail.getSubscriptionOfferDetails()) {
                final HashMap<String, Object> detailMap = new HashMap<>();
                detailMap.put("basePlanId", subscriptionOfferDetails.getBasePlanId());
                detailMap.put("offerId", subscriptionOfferDetails.getOfferId());
                detailMap.put("offerTags", subscriptionOfferDetails.getOfferTags());
                detailMap.put("offerToken", subscriptionOfferDetails.getOfferToken());

                final List<HashMap<String, Object>> pricingPhases = new ArrayList<>();
                for (final ProductDetails.PricingPhase phase : subscriptionOfferDetails.getPricingPhases().getPricingPhaseList()) {
                    final HashMap<String, Object> pricingPhasesMap = new HashMap<>();
                    pricingPhasesMap.put("billingCycleCount", phase.getBillingCycleCount());
                    pricingPhasesMap.put("billingPeriod", phase.getBillingPeriod());
                    pricingPhasesMap.put("formattedPrice", phase.getFormattedPrice());
                    pricingPhasesMap.put("priceAmountMicros", phase.getPriceAmountMicros());
                    pricingPhasesMap.put("priceCurrencyCode", phase.getPriceCurrencyCode());
                    pricingPhasesMap.put("recurrenceMode", phase.getRecurrenceMode());
                    pricingPhases.add(pricingPhasesMap);
                }
                detailMap.put("pricingPhases", pricingPhases);

                subscriptionInfo.add(detailMap);
            }

            info.put("subscriptionOfferDetails", subscriptionInfo);
        } else {
            info.put("subscriptionOfferDetails", null);
        }

        return info;
    }

    static List<HashMap<String, Object>> fromProductDetailsList(
            @Nullable List<ProductDetails> productDetailsList
    ) {
        if (productDetailsList == null || productDetailsList.isEmpty()) {
            Log.d("fromProductDetailsList", "Empty productDetailsList received");
            return Collections.emptyList();
        }

        final ArrayList<HashMap<String, Object>> output = new ArrayList<>();
        for (ProductDetails detail : productDetailsList) {
            output.add(fromProductDetails(detail));
        }
        return output;
    }

    static HashMap<String, Object> fromPurchase(Purchase purchase) {
        HashMap<String, Object> info = new HashMap<>();
        List<String> skus = purchase.getSkus();
        info.put("orderId", purchase.getOrderId());
        info.put("packageName", purchase.getPackageName());
        info.put("purchaseTime", purchase.getPurchaseTime());
        info.put("purchaseToken", purchase.getPurchaseToken());
        info.put("signature", purchase.getSignature());
        info.put("skus", skus);
        info.put("isAutoRenewing", purchase.isAutoRenewing());
        info.put("originalJson", purchase.getOriginalJson());
        info.put("developerPayload", purchase.getDeveloperPayload());
        info.put("isAcknowledged", purchase.isAcknowledged());
        info.put("purchaseState", purchase.getPurchaseState());
        info.put("quantity", purchase.getQuantity());
        AccountIdentifiers accountIdentifiers = purchase.getAccountIdentifiers();
        if (accountIdentifiers != null) {
            info.put("obfuscatedAccountId", accountIdentifiers.getObfuscatedAccountId());
            info.put("obfuscatedProfileId", accountIdentifiers.getObfuscatedProfileId());
        }
        return info;
    }

    static HashMap<String, Object> fromPurchaseHistoryRecord(
            PurchaseHistoryRecord purchaseHistoryRecord) {
        HashMap<String, Object> info = new HashMap<>();
        List<String> skus = purchaseHistoryRecord.getSkus();
        info.put("purchaseTime", purchaseHistoryRecord.getPurchaseTime());
        info.put("purchaseToken", purchaseHistoryRecord.getPurchaseToken());
        info.put("signature", purchaseHistoryRecord.getSignature());
        info.put("skus", skus);
        info.put("developerPayload", purchaseHistoryRecord.getDeveloperPayload());
        info.put("originalJson", purchaseHistoryRecord.getOriginalJson());
        info.put("quantity", purchaseHistoryRecord.getQuantity());
        return info;
    }

    static List<HashMap<String, Object>> fromPurchasesList(@Nullable List<Purchase> purchases) {
        if (purchases == null) {
            return Collections.emptyList();
        }

        List<HashMap<String, Object>> serialized = new ArrayList<>();
        for (Purchase purchase : purchases) {
            serialized.add(fromPurchase(purchase));
        }
        return serialized;
    }

    static List<HashMap<String, Object>> fromPurchaseHistoryRecordList(
            @Nullable List<PurchaseHistoryRecord> purchaseHistoryRecords) {
        if (purchaseHistoryRecords == null) {
            return Collections.emptyList();
        }

        List<HashMap<String, Object>> serialized = new ArrayList<>();
        for (PurchaseHistoryRecord purchaseHistoryRecord : purchaseHistoryRecords) {
            serialized.add(fromPurchaseHistoryRecord(purchaseHistoryRecord));
        }
        return serialized;
    }

    static HashMap<String, Object> fromBillingResult(BillingResult billingResult) {
        HashMap<String, Object> info = new HashMap<>();
        info.put("responseCode", billingResult.getResponseCode());
        info.put("debugMessage", billingResult.getDebugMessage());
        return info;
    }

    /**
     * Gets the symbol of for the given currency code for the default {@link Locale.Category#DISPLAY
     * DISPLAY} locale. For example, for the US Dollar, the symbol is "$" if the default locale is the
     * US, while for other locales it may be "US$". If no symbol can be determined, the ISO 4217
     * currency code is returned.
     *
     * @param currencyCode the ISO 4217 code of the currency
     * @return the symbol of this currency code for the default {@link Locale.Category#DISPLAY
     * DISPLAY} locale
     * @throws NullPointerException     if <code>currencyCode</code> is null
     * @throws IllegalArgumentException if <code>currencyCode</code> is not a supported ISO 4217
     *                                  code.
     */
    static String currencySymbolFromCode(String currencyCode) {
        return Currency.getInstance(currencyCode).getSymbol();
    }
}
