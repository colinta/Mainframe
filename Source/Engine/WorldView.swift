////
/// WorldView.swift
//

class WorldView: SKView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: 0x3f3f3f)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            (scene as? WorldScene)?.gameShook()
        }
    }

    func presentWorld(_ world: World) {
        let scene = WorldScene(size: frame.size, world: world)
        presentScene(scene)
    }
}
