//
//  LocationTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel

final class LocationTests: DecodableTests<[Location]> {

    override func setUpWithError() throws {
        jsonString = """
            [
                {
                    "name": "Seoul",
                    "local_names": {
                        "az": "Seul",
                        "fa": "سئول",
                        "th": "โซล",
                        "de": "Seoul",
                        "is": "Seúl",
                        "cv": "Сеул",
                        "mk": "Сеул",
                        "ur": "سؤل",
                        "bo": "སེ་ཨུལ།",
                        "sv": "Seoul",
                        "tr": "Seul",
                        "ru": "Сеул",
                        "ta": "சியோல்",
                        "nl": "Seoel",
                        "tg": "Сеул",
                        "hy": "Սեուլ",
                        "et": "Sŏul",
                        "ml": "സോൾ",
                        "yi": "סעאל",
                        "he": "סיאול",
                        "ky": "Сеул",
                        "km": "សេអ៊ូល",
                        "eu": "Seul",
                        "tk": "Seul",
                        "uk": "Сеул",
                        "bn": "সিওল",
                        "qu": "Siul",
                        "fr": "Séoul",
                        "an": "Seúl",
                        "en": "Seoul",
                        "af": "Seoel",
                        "am": "ሶል",
                        "ar": "سول",
                        "eo": "Seulo",
                        "it": "Seul",
                        "ro": "Seul",
                        "os": "Сеул",
                        "uz": "Seul",
                        "gl": "Seúl",
                        "be": "Сеул",
                        "mn": "Сөүл",
                        "hi": "सियोल",
                        "pl": "Seul",
                        "es": "Seúl",
                        "zh": "首尔市 / 首爾",
                        "lv": "Seula",
                        "ka": "სეული",
                        "sl": "Seul",
                        "kk": "Сеул",
                        "vo": "Söul",
                        "fi": "Soul",
                        "ku": "Sêûl",
                        "kn": "ಸೌಲ್",
                        "lt": "Seulas",
                        "ca": "Seül",
                        "cs": "Soul",
                        "my": "ဆိုးလ်မြို့",
                        "bh": "सियोल",
                        "bs": "Seul",
                        "bg": "Сеул",
                        "sr": "Сеул",
                        "hu": "Szöul",
                        "sk": "Soul",
                        "pt": "Seul",
                        "hr": "Seul",
                        "el": "Σεούλ",
                        "vi": "Seoul",
                        "mr": "सोल",
                        "oc": "Seol",
                        "ba": "Сеул",
                        "ko": "서울",
                        "la": "Seulum",
                        "ja": "ソウル"
                    },
                    "lat": 37.5666791,
                    "lon": 126.9782914,
                    "country": "KR"
                }
            ]
            """
        
        try super.setUpWithError()
    }
}
