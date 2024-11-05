//
//  ViewController.swift
//  Simon Dits
//
//  Created by Seedy on 11/10/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorBtns: [CircularButtonViewController]!
    
    @IBOutlet weak var actionBtn: UIButton!
    
    @IBOutlet var playerLabels: [UILabel]!
    @IBOutlet var scoreLables: [UILabel]!
    
    var currentplayer = 0
    var score = [0,0]
    var seqIndex = 0
    var colorSeq = [Int]()
    var colorsToTap = [Int]()
    var gameEnded = false
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        colorBtns = colorBtns.sorted(){ $0.tag < $1.tag }
        playerLabels = playerLabels.sorted(){ $0.tag < $1.tag }
        scoreLables = scoreLables.sorted(){ $0.tag < $1.tag }
        
        createGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded{
            gameEnded = false
            createGame()
        }
    }
    
    func createGame(){
        colorSeq.removeAll()
        actionBtn.setTitle("start Game", for: .normal)
        actionBtn.isEnabled = true
        // chnage color buttons
        for btn in colorBtns{
            btn.alpha = 0.5
//            btn.isEnabled = false
        }
        
        // split scrren multiplayer
        currentplayer = 0
        score = [0,0]
        playerLabels[currentplayer].alpha = 1
        playerLabels[1].alpha = 0.74
        updateScoreLabels()
    }
    
    func updateScoreLabels(){
        for (i, label) in scoreLables.enumerated(){
            label.text = "\(score[i])"
        }
    }
    
    func switchPlayers(){
        playerLabels[currentplayer].alpha = 0.74
        currentplayer = currentplayer == 0 ? 1 : 0
        playerLabels[currentplayer].alpha = 1
    }

    @IBAction func colorBtnHandler(_ sender: CircularButtonViewController){
        if sender.tag == colorsToTap.removeFirst(){
            
        }else{
            for btn in colorBtns{
//                btn.isEnabled = false
            }
            endGame()
            return
        }
        
        if colorsToTap.isEmpty{
            for btn in colorBtns{
//                btn.isEnabled = false
            }
            score[currentplayer] += 1
            updateScoreLabels()
            switchPlayers()
            actionBtn.setTitle("next Game, Continue", for: .normal)
            actionBtn.isEnabled = true
//            view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func actionBtnHandler(_ sender: UIButton){
        seqIndex = 0
        actionBtn.setTitle("memorixed", for: .normal)
        actionBtn.isEnabled = false
        view.isUserInteractionEnabled = false
        addColor()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.playColorSeq()
        })
    }
    
    func addColor(){
        colorSeq.append(Int(arc4random_uniform(UInt32(4))))
    }
    
    func playColorSeq(){
        if seqIndex < colorSeq.count{
            let btn = colorBtns[colorSeq[seqIndex]]
            flashBtn(btn: btn)
            seqIndex += 1
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                self.playColorSeq()
//            })
        }else{
            colorsToTap = colorSeq
            view.isUserInteractionEnabled = true
            actionBtn.setTitle("Tap Colors", for: .normal)
            for btn in colorBtns{
                btn.isEnabled = true
            }
        }
    }
    
    // incraese btn alpha
    func flashBtn(btn: CircularButtonViewController){
        UIView.animate(withDuration: 0.5) {
            btn.alpha = 1
            btn.alpha = 0.5
        } completion: { Bool in
            self.playColorSeq()
        }

    }
    
    func endGame(){
        let msg = currentplayer == 0 ? "Player 2 wins" : "Player 1 wins"
        actionBtn.setTitle(msg, for: .normal)
        gameEnded = true
    }
}

