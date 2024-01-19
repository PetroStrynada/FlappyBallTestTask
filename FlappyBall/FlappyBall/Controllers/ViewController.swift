//
//  ViewController.swift
//  FlappyBall
//
//  Created by Petro Strynada on 13.01.2024.



import UIKit

class ViewController: UIViewController {

    var ballView: UIView!
    var ballViewCurrentDiameter: CGFloat = 50

    var ObstacleTopLineView: UIView!
    var ObstacleBottomLineView: UIView!

    enum ObstacleSize: CGFloat {
        case small = 200
        case medium = 250
        case large = 275
    }

    enum ObstacleDelayInSeconds: TimeInterval {
        case zero = 0.0
        case three = 3.0
        case five = 5.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createBall()
        createScaleButtons()
        createObstacles()
    }

    // MARK: - Ball Setup

    func createBall() {
        ballView = UIView()
        ballView.translatesAutoresizingMaskIntoConstraints = false
        ballView.backgroundColor = .blue
        ballView.layer.cornerRadius = ballViewCurrentDiameter / 2
        ballView.layer.zPosition = 1
        ballView.layer.masksToBounds = true

        view.addSubview(ballView)

        NSLayoutConstraint.activate([
            ballView.widthAnchor.constraint(equalToConstant: ballViewCurrentDiameter),
            ballView.heightAnchor.constraint(equalTo: ballView.widthAnchor),
            ballView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ballView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        let middleLine = UIView()
        middleLine.translatesAutoresizingMaskIntoConstraints = false
        middleLine.backgroundColor = .yellow

        ballView.addSubview(middleLine)

        NSLayoutConstraint.activate([
            middleLine.widthAnchor.constraint(equalToConstant: 10),
            middleLine.heightAnchor.constraint(equalTo: ballView.heightAnchor),
            middleLine.centerXAnchor.constraint(equalTo: ballView.centerXAnchor),
            middleLine.centerYAnchor.constraint(equalTo: ballView.centerYAnchor),
        ])

        rotateBallViewWithInfiniteAnimation()
    }

    // MARK: - Ball Animations

    func rotateBallViewWithInfiniteAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveLinear, animations: {
            self.ballView.transform = self.ballView.transform.rotated(by: .pi)
        }) { _ in
            self.rotateBallViewWithInfiniteAnimation()
        }
    }

    func scaleBallViewWithAnimation(to newDiameter: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.ballView.transform = CGAffineTransform(scaleX: newDiameter / self.ballView.bounds.width,
                                                          y: newDiameter / self.ballView.bounds.height)
        }
    }

    // MARK: - Scale Buttons Setup

    func createScaleButtons() {
        let scaleUpButton = scaleButtonConfiguration(title: "+", backgroundColor: .green, action: #selector(scaleUpButtonTapped))
        let scaleDownButton = scaleButtonConfiguration(title: "-", backgroundColor: .red, action: #selector(scaleDownButtonTapped))

        view.addSubview(scaleUpButton)
        view.addSubview(scaleDownButton)

        NSLayoutConstraint.activate([
            scaleUpButton.widthAnchor.constraint(equalToConstant: 150),
            scaleUpButton.heightAnchor.constraint(equalToConstant: 80),
            scaleUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            scaleUpButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -15),

            scaleDownButton.widthAnchor.constraint(equalToConstant: 150),
            scaleDownButton.heightAnchor.constraint(equalToConstant: 80),
            scaleDownButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            scaleDownButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15)
        ])
    }

    func scaleButtonConfiguration(title: String, backgroundColor: UIColor, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    // MARK: - Scale Buttons Actions

    @objc func scaleUpButtonTapped() {
        let newDiameter = ballViewCurrentDiameter * 2
        if newDiameter <= 300 {
            scaleBallViewWithAnimation(to: newDiameter)
            ballViewCurrentDiameter = newDiameter
        }
    }

    @objc func scaleDownButtonTapped() {
        let newDiameter = ballViewCurrentDiameter / 2
        if newDiameter >= 50 {
            scaleBallViewWithAnimation(to: newDiameter)
            ballViewCurrentDiameter = newDiameter
        }
    }

    // MARK: - Obstacles Setup

    func createObstacles() {
        let randomSize = [ObstacleSize.small, .medium, .large].randomElement() ?? .medium
        let randomDelay = [ObstacleDelayInSeconds.zero, .three, .five].randomElement() ?? .three

        let (topLine, bottomLine) = createObstacleLines(height: randomSize.rawValue)
        ObstacleTopLineView = topLine
        ObstacleBottomLineView = bottomLine

        view.addSubview(ObstacleTopLineView)
        view.addSubview(ObstacleBottomLineView)

        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay.rawValue) {
            self.obstaclesMovementWithAnimation()
        }
    }

    func createObstacleLines(height: CGFloat) -> (UIView, UIView) {
        let obstacleTopLine = UIView()
        obstacleTopLine.translatesAutoresizingMaskIntoConstraints = false
        obstacleTopLine.layer.zPosition = 0.99
        obstacleTopLine.backgroundColor = .red

        let obstacleBottomLine = UIView()
        obstacleBottomLine.translatesAutoresizingMaskIntoConstraints = false
        obstacleBottomLine.layer.zPosition = 0.99
        obstacleBottomLine.backgroundColor = .red

        view.addSubview(obstacleTopLine)
        view.addSubview(obstacleBottomLine)

        NSLayoutConstraint.activate([
            obstacleTopLine.widthAnchor.constraint(equalToConstant: 20),
            obstacleTopLine.heightAnchor.constraint(equalToConstant: height + 100),
            obstacleTopLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            obstacleTopLine.leadingAnchor.constraint(equalTo: view.trailingAnchor),

            obstacleBottomLine.widthAnchor.constraint(equalToConstant: 20),
            obstacleBottomLine.heightAnchor.constraint(equalToConstant: height),
            obstacleBottomLine.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            obstacleBottomLine.leadingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        return (obstacleTopLine, obstacleBottomLine)
    }

    // MARK: - Obstacle Animation

    func obstaclesMovementWithAnimation() {
        UIView.animate(withDuration: 3.0, animations: {
            self.ObstacleTopLineView.frame.origin.x = -self.ObstacleTopLineView.frame.width
            self.ObstacleBottomLineView.frame.origin.x = -self.ObstacleBottomLineView.frame.width
        }) { _ in

            //adding new animations can break (obstaclesMovementWithAnimation). Sign: Animation finishes too early
            //Maybe it can help in the future
            UIView.animate(withDuration: 0) {
                self.ObstacleTopLineView.removeFromSuperview()
                self.ObstacleBottomLineView.removeFromSuperview()
            } completion: { _ in
                self.createObstacles()
            }
        }
    }

    // MARK: - Collision Check



}
