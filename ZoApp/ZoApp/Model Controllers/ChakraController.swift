//
//  ChakraController.swift
//  ZōApp
//
//  Created by The Zō Team on 10/2/19.
//  Copyright © 2019 Zō App. All rights reserved.
//

import UIKit

enum Chakra {
    case root
    case sacral
    case solarPlexus
    case heart
    case throat
    case thirdEye
    case crown
    
    var levelNames: String {
        switch self {
        case .root:
            return "Root"
        case .sacral:
            return "Sacral"
        case .solarPlexus:
            return "Solar Plexus"
        case .heart:
            return "Heart"
        case .throat:
            return "Throat"
        case .thirdEye:
            return "Third Eye"
        case .crown:
            return "Crown"
        }
    }
    
    var pointLevels: Int {
        switch self {
        case .root:
            return 0
        case .sacral:
            return 1000
        case .solarPlexus:
            return 3000
        case .heart:
            return 5000
        case .throat:
            return 10000
        case .thirdEye:
            return 15000
        case .crown:
            return 20000
        }
    }
    
    var imageNames: String {
        switch self {
        case .root:
            return "chakraRoot"
        case .sacral:
            return "chakraSacral"
        case .solarPlexus:
            return "chakraSolarPlexus"
        case .heart:
            return "chakraHeart"
        case .throat:
            return "chakraThroat"
        case .thirdEye:
            return "chakraThirdEye"
        case .crown:
            return "chakraCrown"
        }
    }
    
    var levelDescriptions: String {
        switch self {
        case .root:
            return "The root chakra defines the human’s relation to the earth. It has a tremendous impact on our survival, vitality and passion. People associate the root chakra with courage, power, strength, love, war and desire. It indicates our requirement for logic, physical strength, and orderliness."
        case .sacral:
            return "The impact of the sacral chakra on the body’s emotions is related to sexuality, creativity, desire, the reproductive system, and compassion. Mostly, people associate the orange color with enthusiasm, happiness, attraction and joy."
        case .solarPlexus:
            return "The Solar Plexus Chakra is usually associated with the sun, bright fire, and high volumes of energy. It is also associated with producing joy, intellect and stimulating the mental activity of the body."
        case .heart:
            return "The heart chakra has a huge impact on human relationships. It is responsible for all types of relationships, including love and marriage. It is also associated with nature, believed to bring wholeness into our lives."
        case .throat:
            return "The throat chakra is associated with the human’s ability to listen attentively and to communicate with other people. It improves the artistic and spiritual abilities in our bodies. That is the reason we meditate efficiently on our own."
        case .thirdEye:
            return "The third eye chakra enables human beings to see the bigger picture by imagining things. It is the center of intuition in the body which enables us to live focused on our daily activities."
        case .crown:
            return "The Crown chakra enlightens the spiritual connections of one individual to another, as well as to supreme beings. When there is a good balance of the crown chakra in the body, an individual can have great capabilities like performing miracles, knowing the right and the wrong, interpretation of hidden things."
        }
    }
}

class ChakraController {
    
    static let shared = ChakraController()
    
    let chakraLevelsArray = [
        Chakra.root.levelNames,
        Chakra.sacral.levelNames,
        Chakra.solarPlexus.levelNames,
        Chakra.heart.levelNames,
        Chakra.throat.levelNames,
        Chakra.thirdEye.levelNames,
        Chakra.crown.levelNames,
    ]
    
    func addKarmaPointsForResponse(user: User) {
        user.kpPoints += 50
    }
    
    func addKarmaPointsForBestResponse(user: User) {
        user.kpPoints += 100
    }
    
    func updateChakraImage(user: User) -> (chakraName: String, chakraImage: UIImage, chakraLevelDescription: String) {
        switch user.kpPoints {
        case _ where user.kpPoints < Chakra.sacral.pointLevels:
            user.kpLevel = Chakra.root.levelNames
            return (Chakra.root.levelNames,
                    UIImage(named: Chakra.root.imageNames)!,
                    Chakra.root.levelDescriptions)
        case _ where user.kpPoints >= Chakra.sacral.pointLevels && user.kpPoints < Chakra.solarPlexus.pointLevels:
            user.kpLevel = Chakra.sacral.levelNames
            return (Chakra.sacral.levelNames,
                    UIImage(named: Chakra.sacral.imageNames)!,
                    Chakra.sacral.levelDescriptions)
        case _ where user.kpPoints >= Chakra.solarPlexus.pointLevels && user.kpPoints < Chakra.heart.pointLevels:
            user.kpLevel = Chakra.solarPlexus.levelNames
            return (Chakra.solarPlexus.levelNames,
                    UIImage(named: Chakra.solarPlexus.imageNames)!,
                    Chakra.solarPlexus.levelDescriptions)
        case _ where user.kpPoints >= Chakra.heart.pointLevels && user.kpPoints < Chakra.throat.pointLevels:
            user.kpLevel = Chakra.heart.levelNames
            return (Chakra.heart.levelNames,
                    UIImage(named: Chakra.heart.imageNames)!,
                    Chakra.heart.levelDescriptions)
        case _ where user.kpPoints >= Chakra.throat.pointLevels && user.kpPoints < Chakra.thirdEye.pointLevels:
            user.kpLevel = Chakra.throat.levelNames
            return (Chakra.throat.levelNames,
                    UIImage(named: Chakra.throat.imageNames)!,
                    Chakra.throat.levelDescriptions)
        case _ where user.kpPoints >= Chakra.thirdEye.pointLevels && user.kpPoints < Chakra.crown.pointLevels:
            user.kpLevel = Chakra.thirdEye.levelNames
            return (Chakra.thirdEye.levelNames,
                    UIImage(named: Chakra.thirdEye.imageNames)!,
                    Chakra.thirdEye.levelDescriptions)
        case _ where user.kpPoints >= Chakra.crown.pointLevels:
            user.kpLevel = Chakra.crown.levelNames
            return (Chakra.crown.levelNames,
                    UIImage(named: Chakra.crown.imageNames)!,
                    Chakra.crown.levelDescriptions)
        default:
            print("There was no value for chakra karma points in \(#function)")
            return (Chakra.root.levelNames,
                    UIImage(named: Chakra.root.imageNames)!,
                    Chakra.root.levelDescriptions)
        }
    }
    
    
    
}
