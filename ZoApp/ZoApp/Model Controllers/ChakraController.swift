//
//  ChakraController.swift
//  JustBreateApp
//
//  Created by Kevin Tanner on 10/9/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class ChakraController {
    
    static let shared = ChakraController()
    
    enum ChakraLevelNames: String {
        case root = "Root"
        case sacral = "Sacral"
        case solarPlexus = "Solar Plexus"
        case heart = "Heart"
        case throat = "Throat"
        case thirdEye = "Third Eye"
        case crown = "Crown"
    }
    
    enum ChakraPointLevels: Int {
        case root = 0
        case sacral = 1000
        case solarPlexus = 3000
        case heart = 5000
        case throat = 10000
        case thirdEye = 15000
        case crown = 20000
    }
    
    enum ChakraImageNames: String {
        case root = "chakraRoot"
        case sacral = "chakraSacral"
        case solarPlexus = "chakraSolarPlexus"
        case heart = "chakraHeart"
        case throat = "chakraThroat"
        case thirdEye = "chakraThirdEye"
        case crown = "chakraCrown"
    }
    
    enum ChakraLevelDescriptions: String {
        case root = "The root chakra defines the human’s relation to the earth. It has a tremendous impact on our survival, vitality and passion. People associate the root chakra with courage, power, strength, love, war and desire. It indicates our requirement for logic, physical strength, and orderliness."
        case sacral = "The impact of the sacral chakra on the body’s emotions is related to sexuality, creativity, desire, the reproductive system, and compassion. Mostly, people associate the orange color with enthusiasm, happiness, attraction and joy."
        case solarPlexus = "The Solar Plexus Chakra is usually associated with the sun, bright fire, and high volumes of energy. It is also associated with producing joy, intellect and stimulating the mental activity of the body."
        case heart = "The heart chakra has a huge impact on human relationships. It is responsible for all types of relationships, including love and marriage. It is also associated with nature, believed to bring wholeness into our lives."
        case throat = "The throat chakra is associated with the human’s ability to listen attentively and to communicate with other people. It improves the artistic and spiritual abilities in our bodies. That is the reason we meditate efficiently on our own."
        case thirdEye = "The third eye chakra enables human beings to see the bigger picture by imagining things. It is the center of intuition in the body which enables us to live focused on our daily activities."
        case crown = "The Crown chakra enlightens the spiritual connections of one individual to another, as well as to supreme beings. When there is a good balance of the crown chakra in the body, an individual can have great capabilities like performing miracles, knowing the right and the wrong, interpretation of hidden things."
    }
    
    func addKarmaPointsForResponse(user: User) {
        user.kpPoints += 50
    }
    
    func addKarmaPointsForBestResponse(user: User) {
        user.kpPoints += 100
    }
    
    func updateChakraImage(user: User) -> (chakraName: String, chakraImage: UIImage, chakraLevelDescription: String) {
        switch user.kpPoints {
        case _ where user.kpPoints < ChakraPointLevels.sacral.rawValue:
            return (ChakraLevelNames.root.rawValue,
                    UIImage(named: ChakraImageNames.root.rawValue)!,
                    ChakraLevelDescriptions.root.rawValue)
        case _ where user.kpPoints >= ChakraPointLevels.sacral.rawValue && user.kpPoints < ChakraPointLevels.solarPlexus.rawValue:
            return (ChakraLevelNames.sacral.rawValue,
                    UIImage(named: ChakraImageNames.sacral.rawValue)!,
                    ChakraLevelDescriptions.sacral.rawValue)
        case _ where user.kpPoints >= ChakraPointLevels.solarPlexus.rawValue && user.kpPoints < ChakraPointLevels.heart.rawValue:
            return (ChakraLevelNames.solarPlexus.rawValue,
                    UIImage(named: ChakraImageNames.solarPlexus.rawValue)!,
                    ChakraLevelDescriptions.solarPlexus.rawValue)
        case _ where user.kpPoints >= ChakraPointLevels.heart.rawValue && user.kpPoints < ChakraPointLevels.throat.rawValue:
            return (ChakraLevelNames.heart.rawValue,
                    UIImage(named: ChakraImageNames.heart.rawValue)!,
                    ChakraLevelDescriptions.heart.rawValue)
        case _ where user.kpPoints >= ChakraPointLevels.throat.rawValue && user.kpPoints < ChakraPointLevels.thirdEye.rawValue:
            return (ChakraLevelNames.throat.rawValue,
                    UIImage(named: ChakraImageNames.throat.rawValue)!,
                    ChakraLevelDescriptions.throat.rawValue)
        case _ where user.kpPoints >= ChakraPointLevels.thirdEye.rawValue && user.kpPoints < ChakraPointLevels.crown.rawValue:
            return (ChakraLevelNames.thirdEye.rawValue,
                    UIImage(named: ChakraImageNames.thirdEye.rawValue)!,
                    ChakraLevelDescriptions.thirdEye.rawValue)
        case _ where user.kpPoints >= ChakraPointLevels.crown.rawValue:
            return (ChakraLevelNames.crown.rawValue,
                    UIImage(named: ChakraImageNames.crown.rawValue)!,
                    ChakraLevelDescriptions.crown.rawValue)
        default:
            print("There was no value for chakra karma points in \(#function)")
            return (ChakraLevelNames.root.rawValue,
                    UIImage(named: ChakraImageNames.root.rawValue)!,
                    ChakraLevelDescriptions.root.rawValue)
        }
    }
    
    
    
}
