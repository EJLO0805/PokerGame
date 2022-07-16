//
//  ViewController.swift
//  PokerGame
//
//  Created by 羅以捷 on 2022/6/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showResult.layer.borderWidth = 3
        showResult.layer.borderColor = UIColor.darkGray.cgColor
        showResult.layer.cornerRadius = 30
        for rank in ranks{
            for color in colors{
                let card = Card(color: color, rank: rank)
                cards.append(card)
            }
        }
    }
    let colors = ["♠️", "♥️", "♦️", "♣️"]
    let ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    var cards = [Card]()
    var cardA = Card(color: "", rank: "")
    var cardB = Card(color: "", rank: "")
    var colorNum = [0, 0]
    var rankNum = [0, 0]
    func colortoNmber(color : String) -> Int {
        var colorNum = 0
        switch color {
        case "♠️" : colorNum = 4
        case "♥️" : colorNum = 3
        case "♦️" : colorNum = 2
        default : colorNum = 1
        }
        return colorNum
    }
    func ranktoNumber(rank : String) -> Int {
        var rankNum = 0
        switch rank {
        case "A" : rankNum = 14
        case "K" : rankNum = 13
        case "Q" : rankNum = 12
        case "J" : rankNum = 11
        default : rankNum = Int(rank)!
        }
        return rankNum
    }
    func cardAtoNum(){
        colorNum[0] = colortoNmber(color: cardA.color)
        rankNum[0] = ranktoNumber(rank: cardA.rank)
    }
    func cardBtoNum(){
        colorNum[1] = colortoNmber(color: cardB.color)
        rankNum[1] = ranktoNumber(rank: cardB.rank)
    }
    func Win(){
        if rankNum[0] > rankNum[1] {
            showResult.text = "PlayerA \(cardA.color)\(cardA.rank)\nPlayerB \(cardB.color)\(cardB.rank)\nPlayerA Win"
        } else if rankNum[0] < rankNum[1] {
            showResult.text = "PlayerA \(cardA.color)\(cardA.rank)\nPlayerB \(cardB.color)\(cardB.rank)\nPlayerB Win"
        } else {
            if colorNum[0] > colorNum[1] {
                showResult.text = "PlayerA \(cardA.color)\(cardA.rank)\nPlayerB \(cardB.color)\(cardB.rank)\nPlayerA Win"
            } else {
                showResult.text = "PlayerA \(cardA.color)\(cardA.rank)\nPlayerB \(cardB.color)\(cardB.rank)\nPlayerB Win"
            }
        }
    }
    @IBOutlet weak var showResult: UILabel!
    @IBAction func playerAbuttom(_ sender: Any) {
        if  cardB.rank == "" {
            if cardA.rank == "" {
                cardA = cards.randomElement()!
                cardAtoNum()
                showResult.text = "\(cardA.color) \(cardA.rank)，請PlayerB 抽卡"
            } else {
                showResult.text = "\(cardA.color) \(cardA.rank)，請PlayerB 抽卡"
            }
        } else if cardA.rank == "", cardB.rank != ""{
            cardA = cards.randomElement()!
            while cardA.rank == cardB.rank, cardA.color == cardB.color{
                cardA = cards.randomElement()!
            }
            cardAtoNum()
            Win()
        } else {
            showResult.text = "請按Replay重新抽卡"
        }
    }
    @IBAction func playrBbuttom(_ sender: Any) {
        if cardA.rank == "" {
            if cardB.rank == "" {
                cardB = cards.randomElement()!
                cardBtoNum()
                showResult.text = "\(cardB.color) \(cardB.rank)，請PlayerA 抽卡"
            } else {
                showResult.text = "\(cardB.color) \(cardB.rank)，請PlayerA 抽卡"
            }
        } else if cardA.rank != "", cardB.rank == "" {
            cardB = cards.randomElement()!
            while cardA.rank == cardB.rank, cardA.color == cardB.color{
                cardB = cards.randomElement()!
            }
            cardBtoNum()
            Win()
        } else {
           showResult.text = "請按Replay重新抽卡"
        }
    }
    @IBAction func replay(_ sender: Any) {
        cardA = Card(color: "", rank: "")
        cardB = Card(color: "", rank: "")
        showResult.text = "請雙方開始抽卡"
    }
}

