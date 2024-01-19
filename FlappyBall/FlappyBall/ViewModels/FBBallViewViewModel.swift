//
//  FBBallViewViewModel.swift
//  FlappyBall
//
//  Created by Petro Strynada on 13.01.2024.
//

import UIKit

protocol FBBallViewViewModelDelegate: AnyObject {
    func didSetNewSize(with radius: Int)
    func didCollisionWithObstacle()
}

final class FBBallViewViewModel: NSObject {

    public weak var delegate: FBBallViewViewModelDelegate?



}
