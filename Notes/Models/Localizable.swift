//  Created by Roman Sorochak <roman.sorochak@gmail.com> on 6/23/17.
//  Copyright © 2017 MagicLab. All rights reserved.

import UIKit


private let appleLanguagesKey = "AppleLanguages"
enum Language: String {
    
    case english = "en"
    case czech = "cs"
    case russian = "ru"
    
    var semantic: UISemanticContentAttribute {
        switch self {
        case .english, .russian, .czech:
            return .forceLeftToRight
        }
    }
    
    static var language: Language {
        get {
            if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
                let language = Language(rawValue: languageCode) {
                return language
            } else {
                let preferredLanguage = NSLocale.preferredLanguages[0] as String
                let index = preferredLanguage.index(
                    preferredLanguage.startIndex,
                    offsetBy: 2
                )
                guard let localization = Language(
                    rawValue: preferredLanguage.substring(to: index)
                    ) else {
                        return Language.english
                }
                return localization
            }
        }
        set {
            guard language != newValue else {
                return
            }
            UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
            UserDefaults.standard.synchronize()
            UIView.appearance().semanticContentAttribute = newValue.semantic
            
            UIApplication.shared.windows[0].rootViewController = UIStoryboard(
                name: "Main",bundle: nil).instantiateInitialViewController()
        }
    }
}


extension String {
    
    var localized: String {
        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
    }
    
}

extension Bundle {
    static var localizedBundle: Bundle {
        let languageCode = Language.language.rawValue
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}
