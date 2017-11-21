////
/// WorldController.swift
//

class WorldController: UIViewController {

    override func loadView() {
        let worldView = WorldView()
        if isIphoneX() {
            let view = UIView(frame: UIScreen.main.bounds)
            view.backgroundColor = .black
            let top: CGFloat = 24
            let bottom: CGFloat = 20
            worldView.frame = CGRect(x: 0, y: top, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - top - bottom)
            worldView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(worldView)
            self.view = view
        }
        else {
            worldView.frame = UIScreen.main.bounds
            self.view = worldView
        }

        self.view.isOpaque = true
        worldView.presentWorld(Mainframe())
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

private func isIphoneX() -> Bool {
    return UIScreen.main.bounds.size.height == 812
}
