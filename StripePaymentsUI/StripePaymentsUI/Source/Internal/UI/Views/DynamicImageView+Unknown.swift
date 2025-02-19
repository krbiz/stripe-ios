//
//  DynamicImageView+Unknown.swift
//  StripePaymentSheet
//
//  Created by Nick Porter on 9/21/23.
//

import Foundation
@_spi(STP) import StripeUICore

@_spi(STP) public extension DynamicImageView {
    static func makeUnknownCardImageView(theme: ElementsUITheme) -> DynamicImageView {
        return DynamicImageView(
            lightImage: STPImageLibrary.safeImageNamed(
                "card_unknown_updated_icon",
                darkMode: true
            ),
            darkImage: STPImageLibrary.safeImageNamed(
                "card_unknown_updated_icon",
                darkMode: false
            ),
            pairedColor: theme.colors.textFieldText
        )
    }
}
