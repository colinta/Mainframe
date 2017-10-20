////
/// WorldController.swift
//

class WorldController: UIViewController {
    var worldView: WorldView?

    override func loadView() {
        let view = WorldView(frame: UIScreen.main.bounds)
        self.worldView = view
        self.view = worldView

        view.presentWorld(Mainframe())
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
