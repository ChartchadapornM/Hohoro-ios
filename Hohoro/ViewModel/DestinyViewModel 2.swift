//
//  DestinyViewModel 2.swift
//  Hohoro
//
//  Created by Warit Karnbunjob on 21/2/2568 BE.
//


import Foundation

class DestinyViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var firstNameScore: Int = 0
    @Published var lastNameScore: Int = 0
    @Published var totalScore: Int = 0
    @Published var destinyResult: String = ""
    @Published var showResult: Bool = false
    
    private let characterScores: [Character: Int] = [
        "A": 1, "I": 1, "J": 1, "Q": 1, "Y": 1,
        "B": 2, "K": 2, "R": 2,
        "C": 3, "G": 3, "L": 3, "S": 3,
        "D": 4, "M": 4, "T": 4,
        "E": 5, "H": 5, "N": 5, "X": 5,
        "U": 6, "V": 6, "W": 6,
        "O": 7, "Z": 7,
        "F": 8, "P": 8
    ]
    
    private let destinyDescriptions: [Int: String] = [
        1: """
        You have high self-confidence because you are influenced by the "Sun". People who are under the influence of this number will be intelligent, brave, brave, have excellent wit, have ambition to be great, dare to take risks, like to be in the front, not second to anyone, think of their own ideas as the most important. Suitable to be a leader, like to be prominent, respected by people in general, have a decisive mind, make decisions quickly, not wavering, sometimes appear arrogant. Life often has to travel all the time. Life will be very successful, famous, have wealth, often do well with their own abilities, be happy, suitable for government work, military, police, executives, company owners.
        """,
        2: """
        "Moon" People who are under the influence of this number tend to be highly imaginative, optimistic, kind-hearted, and generous, making them easily loved by others. However, their minds tend to be sensitive, sometimes overthinking, daydreaming, and building castles in the air. They easily follow others, like poetry and aesthetics, and enjoy a free life. Number 2 people may seem sensitive at first glance, but when it comes to a crisis, they can control their wits well. They are incredibly brave and strong. They are suitable for jobs that require creativity, such as poets, architects, designers, art directors, artists, etc.
        """
        // Add more results here
    ]
    
    func calculateScore(for name: String) -> Int {
        let upperName = name.uppercased()
        return upperName.reduce(0) { sum, char in
            sum + (characterScores[char] ?? 0)
        }
    }
    
    func calculateDestiny() {
        firstNameScore = calculateScore(for: firstName)
        lastNameScore = calculateScore(for: lastName)
        totalScore = firstNameScore + lastNameScore
        
        // Get result based on total score
        destinyResult = destinyDescriptions[totalScore] ?? "Your destiny is yet to be written..."
        showResult = true
    }
}