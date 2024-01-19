//
//  FBBallView.swift
//  FlappyBall
//
//  Created by Petro Strynada on 13.01.2024.
//

import UIKit

//protocol FBBallViewDelegate: AnyObject {
//    func fbBallView(
//        _ ballView: FBBallView,
//        didSelectBall ball: FBBall
//    )
//}

/// View that constructs ball appearance
final class FBBallView: UIView {

//    public weak var delegate: FBBallViewDelegate?

    

    private let ball: UIView = {
        let ball = UIView()
        ball.translatesAutoresizingMaskIntoConstraints = false
        ball.backgroundColor = UIColor.blue
        ball.layer.cornerRadius = 25
        ball.layer.masksToBounds = true
        return ball
    }()

    private let line: UIView = {
        let middleLine = UIView()
        middleLine.translatesAutoresizingMaskIntoConstraints = false
        middleLine.backgroundColor = UIColor.yellow
        return middleLine
    }()


    private func addConstraints() {
        NSLayoutConstraint.activate([
            ball.widthAnchor.constraint(equalToConstant: 50),
            ball.heightAnchor.constraint(equalTo: ball.widthAnchor),
            ball.centerXAnchor.constraint(equalTo: centerXAnchor),
            ball.centerYAnchor.constraint(equalTo: centerYAnchor),

            ball.widthAnchor.constraint(equalToConstant: 10),
            ball.heightAnchor.constraint(equalTo: ball.heightAnchor),
            ball.centerXAnchor.constraint(equalTo: ball.centerXAnchor),
            ball.centerYAnchor.constraint(equalTo: ball.centerYAnchor),
        ])
    }

    private func setupBallView() {
        
    }

}

//extension FBBallView: FBBallViewViewModelDelegate {
//    func didSetNewSize(with radius: Int) {
//        <#code#>
//    }
//
//    func didCollisionWithObstacle() {
//        <#code#>
//    }
//}
