//
//  BackgroundImageTests.swift
//  ShinyModel
//
//  Created by YoonieMac on 6/8/25.
//

import XCTest
@testable import ShinyModel

// Decoding이 잘 되는지만 테스트
final class BackgroundImageTests: DecodableTests<BackgroundImage> {
    
    override func setUpWithError() throws {
        jsonString = """
            {
                "id": "g_MhcGqCk7E",
                "slug": "people-walking-on-road-g_MhcGqCk7E",
                "alternative_slugs": {
                    "en": "people-walking-on-road-g_MhcGqCk7E",
                    "es": "gente-caminando-por-la-carretera-g_MhcGqCk7E",
                    "ja": "道路を歩く人々-g_MhcGqCk7E",
                    "fr": "personnes-marchant-sur-la-route-g_MhcGqCk7E",
                    "it": "persone-che-camminano-sulla-strada-g_MhcGqCk7E",
                    "ko": "도로를-걷는-사람들-g_MhcGqCk7E",
                    "de": "menschen-die-auf-der-strasse-gehen-g_MhcGqCk7E",
                    "pt": "pessoas-andando-na-estrada-g_MhcGqCk7E"
                },
                "created_at": "2016-08-31T04:35:17Z",
                "updated_at": "2025-06-08T07:35:45Z",
                "promoted_at": null,
                "width": 3614,
                "height": 5421,
                "color": "#262626",
                "blur_hash": "LhG8r[M|4.t6NJWBRkof~pWVIUj[",
                "description": null,
                "alt_description": "people walking on road",
                "breadcrumbs": [],
                "urls": {
                    "raw": "https://images.unsplash.com/photo-1472618039048-d33f70f0777e?ixid=M3w3MTQ4NDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NDkzODM4Njl8&ixlib=rb-4.1.0",
                    "full": "https://images.unsplash.com/photo-1472618039048-d33f70f0777e?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3MTQ4NDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NDkzODM4Njl8&ixlib=rb-4.1.0&q=85",
                    "regular": "https://images.unsplash.com/photo-1472618039048-d33f70f0777e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3MTQ4NDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NDkzODM4Njl8&ixlib=rb-4.1.0&q=80&w=1080",
                    "small": "https://images.unsplash.com/photo-1472618039048-d33f70f0777e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3MTQ4NDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NDkzODM4Njl8&ixlib=rb-4.1.0&q=80&w=400",
                    "thumb": "https://images.unsplash.com/photo-1472618039048-d33f70f0777e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3MTQ4NDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NDkzODM4Njl8&ixlib=rb-4.1.0&q=80&w=200",
                    "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1472618039048-d33f70f0777e"
                },
                "links": {
                    "self": "https://api.unsplash.com/photos/people-walking-on-road-g_MhcGqCk7E",
                    "html": "https://unsplash.com/photos/people-walking-on-road-g_MhcGqCk7E",
                    "download": "https://unsplash.com/photos/g_MhcGqCk7E/download?ixid=M3w3MTQ4NDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NDkzODM4Njl8",
                    "download_location": "https://api.unsplash.com/photos/g_MhcGqCk7E/download?ixid=M3w3MTQ4NDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NDkzODM4Njl8"
                },
                "likes": 430,
                "liked_by_user": false,
                "current_user_collections": [],
                "sponsorship": null,
                "topic_submissions": {},
                "asset_type": "photo",
                "user": {
                    "id": "_zIhbG6jCHs",
                    "updated_at": "2024-10-11T02:00:44Z",
                    "username": "robsonhmorgan",
                    "name": "Robson Hatsukami Morgan",
                    "first_name": "Robson Hatsukami",
                    "last_name": "Morgan",
                    "twitter_username": "robsonhmorgan",
                    "portfolio_url": "https://www.instagram.com/robsonhmorgan/",
                    "bio": "Adventure and Travel Photographer",
                    "location": "Minneapolis, MN, USA",
                    "links": {
                        "self": "https://api.unsplash.com/users/robsonhmorgan",
                        "html": "https://unsplash.com/@robsonhmorgan",
                        "photos": "https://api.unsplash.com/users/robsonhmorgan/photos",
                        "likes": "https://api.unsplash.com/users/robsonhmorgan/likes",
                        "portfolio": "https://api.unsplash.com/users/robsonhmorgan/portfolio",
                        "following": "https://api.unsplash.com/users/robsonhmorgan/following",
                        "followers": "https://api.unsplash.com/users/robsonhmorgan/followers"
                    },
                    "profile_image": {
                        "small": "https://images.unsplash.com/profile-fb-1470010123-640887b12fac.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
                        "medium": "https://images.unsplash.com/profile-fb-1470010123-640887b12fac.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
                        "large": "https://images.unsplash.com/profile-fb-1470010123-640887b12fac.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
                    },
                    "instagram_username": "robsonhmorgan",
                    "total_collections": 0,
                    "total_likes": 0,
                    "total_photos": 111,
                    "total_promoted_photos": 51,
                    "total_illustrations": 0,
                    "total_promoted_illustrations": 0,
                    "accepted_tos": true,
                    "for_hire": true,
                    "social": {
                        "instagram_username": "robsonhmorgan",
                        "portfolio_url": "https://www.instagram.com/robsonhmorgan/",
                        "twitter_username": "robsonhmorgan",
                        "paypal_email": null
                    }
                },
                "exif": {
                    "make": null,
                    "model": null,
                    "name": null,
                    "exposure_time": null,
                    "aperture": null,
                    "focal_length": null,
                    "iso": null
                },
                "location": {
                    "name": "Seoul, South Korea",
                    "city": "Seoul",
                    "country": "South Korea",
                    "position": {
                        "latitude": 37.566535,
                        "longitude": 126.9779692
                    }
                },
                "meta": {
                    "index": true
                },
                "public_domain": false,
                "tags": [
                    {
                        "type": "search",
                        "title": "street"
                    },
                    {
                        "type": "search",
                        "title": "urban"
                    },
                    {
                        "type": "search",
                        "title": "seoul"
                    },
                    {
                        "type": "search",
                        "title": "korea"
                    },
                    {
                        "type": "search",
                        "title": "south korea"
                    },
                    {
                        "type": "search",
                        "title": "building"
                    },
                    {
                        "type": "search",
                        "title": "city"
                    },
                    {
                        "type": "search",
                        "title": "human"
                    },
                    {
                        "type": "search",
                        "title": "road"
                    },
                    {
                        "type": "search",
                        "title": "clothing"
                    },
                    {
                        "type": "search",
                        "title": "path"
                    },
                    {
                        "type": "search",
                        "title": "town"
                    },
                    {
                        "type": "search",
                        "title": "apparel"
                    },
                    {
                        "type": "search",
                        "title": "asphalt"
                    },
                    {
                        "type": "search",
                        "title": "sidewalk"
                    },
                    {
                        "type": "search",
                        "title": "coat"
                    },
                    {
                        "type": "search",
                        "title": "alley"
                    },
                    {
                        "type": "search",
                        "title": "pavement"
                    },
                    {
                        "type": "search",
                        "title": "pedestrian"
                    },
                    {
                        "type": "search",
                        "title": "alleyway"
                    }
                ],
                "views": 16419857,
                "downloads": 11892,
                "topics": []
            }
            """
        try super.setUpWithError()
    }
}
