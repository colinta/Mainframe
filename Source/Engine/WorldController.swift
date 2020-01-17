////
/// WorldController.swift
//

class WorldController: UIViewController {
    let worldView = WorldView()

    override func viewDidLoad() {
        view.backgroundColor = .black
        view.isOpaque = true

        view << worldView
        updateWorldViewFrame()
        worldView.presentWorld(Mainframe())
    }
    
    private func updateWorldViewFrame() {
        worldView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        updateWorldViewFrame()
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
