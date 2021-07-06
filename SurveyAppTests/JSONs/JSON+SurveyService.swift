// swiftlint:disable all
//
//  JSON+SurveyService.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/28/21.
//

import Foundation

extension JSON.SurveyService {
    
    static var fetchSurveysSuccess: Data {
        """
        {
            "data": [
                {
                    "id": "d5de6a8f8f5f1cfe51bc",
                    "type": "survey",
                    "attributes": {
                        "title": "Scarlett Bangkok",
                        "description": "We'd love ot hear from you!",
                        "thank_email_above_threshold": "Dear Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are thrilled that you enjoyed your time with us! If you have a moment, we would be greatly appreciate it if you could leave a short review on. It helps to spread the word and let others know about the Beach Republic Revolution! Thank you again and we look forward to welcoming you back soon. Beach Republic Team",
                        "thank_email_below_threshold": "Dear Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are thrilled that you enjoyed your time with us! If you have a moment, we would be greatly appreciate it if you could leave a short review on. It helps to spread the word and let others know about the Beach Republic Revolution! Thank you again and we look forward to welcoming you back soon. Beach Republic Team",
                        "is_active": true,
                        "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
                        "created_at": "2017-01-23T07:48:12.991Z",
                        "active_at": "2015-10-08T07:04:00.000Z",
                        "inactive_at": "null",
                        "survey_type": "Restaurant"
                    },
                    "relationships": {
                        "questions": {
                            "data": [
                                {
                                    "id": "d3afbcf2b1d60af845dc",
                                    "type": "question"
                                },
                                {
                                    "id": "940d229e4cd87cd1e202",
                                    "type": "question"
                                },
                                {
                                    "id": "ea0555f328b3b0124127",
                                    "type": "question"
                                },
                                {
                                    "id": "16e68f5610ef0e0fa4db",
                                    "type": "question"
                                },
                                {
                                    "id": "bab38ad82eaf22afcdfe",
                                    "type": "question"
                                },
                                {
                                    "id": "85275a0bf28a6f3b1e63",
                                    "type": "question"
                                },
                                {
                                    "id": "642770376f7cd0c87d3c",
                                    "type": "question"
                                },
                                {
                                    "id": "b093a6ad9a6a466fa787",
                                    "type": "question"
                                },
                                {
                                    "id": "e593b2fa2f81891a2b1e",
                                    "type": "question"
                                },
                                {
                                    "id": "c3a9b8ce5c2356010703",
                                    "type": "question"
                                },
                                {
                                    "id": "fbf5d260de1ee6195473",
                                    "type": "question"
                                },
                                {
                                    "id": "4372463ce56db58c0983",
                                    "type": "question"
                                }
                            ]
                        }
                    }
                },
                {
                    "id": "ed1d4f0ff19a56073a14",
                    "type": "survey",
                    "attributes": {
                        "title": "ibis Bangkok Riverside",
                        "description": "We'd love to hear from you!",
                        "thank_email_above_threshold": "Dear Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are thrilled that you enjoyed your time with us! If you have a moment, we would be greatly appreciate it if you could leave a short review on. It helps to spread the word and let others know about the Beach Republic Revolution! Thank you again and we look forward to welcoming you back soon. Beach Republic Team",
                        "thank_email_below_threshold": "Dear Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are thrilled that you enjoyed your time with us! If you have a moment, we would be greatly appreciate it if you could leave a short review on. It helps to spread the word and let others know about the Beach Republic Revolution! Thank you again and we look forward to welcoming you back soon. Beach Republic Team",
                        "is_active": true,
                        "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_",
                        "created_at": "2017-01-23T03:32:24.585Z",
                        "active_at": "2016-01-22T04:12:00.000Z",
                        "inactive_at": "null",
                        "survey_type": "Hotel"
                    },
                    "relationships": {
                        "questions": {
                            "data": [
                                {
                                    "id": "fa385b75617d98e069a3",
                                    "type": "question"
                                },
                                {
                                    "id": "1b03688d4af8a5c6b1e0",
                                    "type": "question"
                                },
                                {
                                    "id": "6e2b6ee71d3011cc0ac1",
                                    "type": "question"
                                },
                                {
                                    "id": "29272d3bac5725b4c2cf",
                                    "type": "question"
                                },
                                {
                                    "id": "7f164dd6150e6113f8ad",
                                    "type": "question"
                                },
                                {
                                    "id": "1d13ef20807de4f752c7",
                                    "type": "question"
                                },
                                {
                                    "id": "d06378d7ab2925282ecd",
                                    "type": "question"
                                },
                                {
                                    "id": "4c1e9486cf95ba54dac8",
                                    "type": "question"
                                },
                                {
                                    "id": "b8f06895134eb1da2d13",
                                    "type": "question"
                                },
                                {
                                    "id": "e9e2518333211ee2e5c8",
                                    "type": "question"
                                },
                                {
                                    "id": "81c9ae82f32f93c2967d",
                                    "type": "question"
                                },
                                {
                                    "id": "2ecd2926eb02e7a58024",
                                    "type": "question"
                                }
                            ]
                        }
                    }
                }
            ],
            "meta": {
                "page": 1,
                "pages": 10,
                "page_size": 2,
                "records": 20
            }
        }
        """.data(using: .utf8)!
    }
    
    static var fetchSurveysFailure: Data {
        """
        {
            "errors": [
                {
                    "source": {
                        "parameter": "unauthorized"
                    },
                    "detail": "The access token is invalid",
                    "code": "invalid_token"
                }
            ]
        }
        """.data(using: .utf8)!
    }
    
    static var fetchSurveyDetailSuccess: Data {
        """
        {
            "data": {
                "id": "d5de6a8f8f5f1cfe51bc",
                "type": "survey",
                "attributes": {
                    "title": "Scarlett Bangkok",
                    "description": "We'd love ot hear from you!",
                    "thank_email_above_threshold": "Dear Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are thrilled that you enjoyed your time with us! If you have a moment, we would be greatly appreciate it if you could leave a short review on. It helps to spread the word and let others know about the Beach Republic Revolution! Thank you again and we look forward to welcoming you back soon. Beach Republic Team",
                    "thank_email_below_threshold": "Dear Thank you for visiting Beach Republic and for taking the time to complete our brief survey. We are thrilled that you enjoyed your time with us! If you have a moment, we would be greatly appreciate it if you could leave a short review on. It helps to spread the word and let others know about the Beach Republic Revolution! Thank you again and we look forward to welcoming you back soon. Beach Republic Team",
                    "is_active": true,
                    "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
                    "created_at": "2017-01-23T07:48:12.991Z",
                    "active_at": "2015-10-08T07:04:00.000Z",
                    "inactive_at": null,
                    "survey_type": "Restaurant"
                },
                "relationships": {
                    "questions": {
                        "data": [
                            {
                                "id": "d3afbcf2b1d60af845dc",
                                "type": "question"
                            },
                            {
                                "id": "940d229e4cd87cd1e202",
                                "type": "question"
                            }
                        ]
                    }
                }
            },
            "included": [
                {
                    "id": "d3afbcf2b1d60af845dc",
                    "type": "question",
                    "attributes": {
                        "text": "Thank you for visiting Scarlett! Please take a moment to share your feedback.",
                        "help_text": null,
                        "display_order": 0,
                        "short_text": "introduction",
                        "pick": "none",
                        "display_type": "intro",
                        "is_mandatory": false,
                        "correct_answer_id": null,
                        "facebook_profile": null,
                        "twitter_profile": null,
                        "image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/2001ebbfdcbf6c00c757_",
                        "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
                        "cover_image_opacity": 0.6,
                        "cover_background_color": null,
                        "is_shareable_on_facebook": false,
                        "is_shareable_on_twitter": false,
                        "font_face": null,
                        "font_size": null,
                        "tag_list": ""
                    },
                    "relationships": {
                        "answers": {
                            "data": []
                        }
                    }
                },
                {
                    "id": "940d229e4cd87cd1e202",
                    "type": "question",
                    "attributes": {
                        "text": "Food â€“ Variety, Taste and Presentation",
                        "help_text": null,
                        "display_order": 1,
                        "short_text": "Food",
                        "pick": "one",
                        "display_type": "star",
                        "is_mandatory": false,
                        "correct_answer_id": null,
                        "facebook_profile": null,
                        "twitter_profile": null,
                        "image_url": null,
                        "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_",
                        "cover_image_opacity": 0.75,
                        "cover_background_color": null,
                        "is_shareable_on_facebook": false,
                        "is_shareable_on_twitter": false,
                        "font_face": null,
                        "font_size": null,
                        "tag_list": ""
                    },
                    "relationships": {
                        "answers": {
                            "data": [
                                {
                                    "id": "4cbc3e5a1c87d99bc7ee",
                                    "type": "answer"
                                },
                                {
                                    "id": "6e6221ce7e0d1068874d",
                                    "type": "answer"
                                },
                                {
                                    "id": "037574cb93d16800eecd",
                                    "type": "answer"
                                },
                                {
                                    "id": "f09f1a680789b636459b",
                                    "type": "answer"
                                }
                            ]
                        }
                    }
                },
                {
                    "id": "4cbc3e5a1c87d99bc7ee",
                    "type": "answer",
                    "attributes": {
                        "text": "1",
                        "help_text": null,
                        "input_mask_placeholder": null,
                        "short_text": "answer_1",
                        "is_mandatory": false,
                        "is_customer_first_name": false,
                        "is_customer_last_name": false,
                        "is_customer_title": false,
                        "is_customer_email": false,
                        "prompt_custom_answer": false,
                        "weight": null,
                        "display_order": 0,
                        "display_type": "default",
                        "input_mask": null,
                        "date_constraint": null,
                        "default_value": null,
                        "response_class": "answer",
                        "reference_identifier": null,
                        "score": 0,
                        "alerts": []
                    }
                },
                {
                    "id": "6e6221ce7e0d1068874d",
                    "type": "answer",
                    "attributes": {
                        "text": "2",
                        "help_text": null,
                        "input_mask_placeholder": null,
                        "short_text": "answer_2",
                        "is_mandatory": false,
                        "is_customer_first_name": false,
                        "is_customer_last_name": false,
                        "is_customer_title": false,
                        "is_customer_email": false,
                        "prompt_custom_answer": false,
                        "weight": null,
                        "display_order": 1,
                        "display_type": "default",
                        "input_mask": null,
                        "date_constraint": null,
                        "default_value": null,
                        "response_class": "answer",
                        "reference_identifier": null,
                        "score": 25,
                        "alerts": []
                    }
                },
                {
                    "id": "037574cb93d16800eecd",
                    "type": "answer",
                    "attributes": {
                        "text": "3",
                        "help_text": null,
                        "input_mask_placeholder": null,
                        "short_text": "answer_3",
                        "is_mandatory": false,
                        "is_customer_first_name": false,
                        "is_customer_last_name": false,
                        "is_customer_title": false,
                        "is_customer_email": false,
                        "prompt_custom_answer": false,
                        "weight": null,
                        "display_order": 2,
                        "display_type": "default",
                        "input_mask": null,
                        "date_constraint": null,
                        "default_value": null,
                        "response_class": "answer",
                        "reference_identifier": null,
                        "score": 50,
                        "alerts": []
                    }
                },
                {
                    "id": "f09f1a680789b636459b",
                    "type": "answer",
                    "attributes": {
                        "text": "4",
                        "help_text": null,
                        "input_mask_placeholder": null,
                        "short_text": "answer_4",
                        "is_mandatory": false,
                        "is_customer_first_name": false,
                        "is_customer_last_name": false,
                        "is_customer_title": false,
                        "is_customer_email": false,
                        "prompt_custom_answer": false,
                        "weight": null,
                        "display_order": 3,
                        "display_type": "default",
                        "input_mask": null,
                        "date_constraint": null,
                        "default_value": null,
                        "response_class": "answer",
                        "reference_identifier": null,
                        "score": 75,
                        "alerts": []
                    }
                }
            ]
        }
        """.data(using: .utf8)!
    }
    
    static var surveyModelList: Data {
        """
        [
            {
                "id": "d5de6a8f8f5f1cfe51bc",
                "type": "survey",
                "title": "Scarlett Bangkok",
                "description": "We'd love ot hear from you!",
                "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l"
            },
            {
                "id": "ed1d4f0ff19a56073a14",
                "type": "survey",
                "title": "ibis Bangkok Riverside",
                "description": "We'd love ot hear from you!",
                "cover_image_url": "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_l"
            }
        ]
        """.data(using: .utf8)!
    }
}
