//
//  ViewController.swift
//  xylophone
//
//  Created by Ueta, Lucas T on 11/7/23.
//

import UIKit
import AVFoundation

struct Tile {
    let letter: String,
        color: UIColor,
        padding: CGFloat
}

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillEqually
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalTo: view.widthAnchor),
            stack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        let tiles: [Tile] = [
            Tile(letter: "C", color: .red, padding: 4),
            Tile(letter: "D", color: .orange, padding: 8),
            Tile(letter: "E", color: .yellow, padding: 12),
            Tile(letter: "F", color: .green, padding: 16),
            Tile(letter: "G", color: .blue, padding: 20),
            Tile(letter: "A", color: .cyan, padding: 24),
            Tile(letter: "B", color: .magenta, padding: 28)
        ]
        for tile in tiles { addTile(tile, to: stack) }
        
    }
    
    func addTile(_ tile: Tile, to stack: UIStackView) {
        let tileButton = UIButton()
        tileButton.backgroundColor = tile.color
        tileButton.setTitle(tile.letter, for: .normal)
        tileButton.titleLabel!.font = UIFont(name: "Arial", size: 36)
        tileButton.addTarget(self, action: #selector(play(_:)), for: .touchDown)
        
        tileButton.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(tileButton)
        NSLayoutConstraint.activate([
            tileButton.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: tile.padding),
            tileButton.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -tile.padding)
        ])
    }
    
    @objc func play(_ sender: UIButton) {
        let url = Bundle.main.url(forResource: sender.titleLabel!.text!, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

