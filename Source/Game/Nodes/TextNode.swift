////
/// TextNode.swift
//

class TextNode: Node {
    private(set) var textSize: CGSize = .zero
    var text: String {
        didSet { updateTextNodes() }
    }
    var font: Font = DefaultFont {
        didSet { updateTextNodes() }
    }
    var textSprite: SKNode
    var textScale: CGFloat {
        set {
            textSprite.setScale(newValue)
            updateTextNodes()
        }
        get { return textSprite.xScale }
    }
    var color: Int = 0xFFFFFF {
        didSet { updateTextNodes() }
    }
    var alignment: NSTextAlignment = .center {
        didSet { updateTextNodes() }
    }
    var margins: UIEdgeInsets = .zero

    override var zPosition: CGFloat {
        didSet {
            for sprite in textSprite.children {
                sprite.zPosition = zPosition
            }
        }
    }

    required init() {
        text = ""
        textSprite = SKNode()
        super.init()
        self << textSprite
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTextNodes() {
        textSprite.removeAllChildren()

        let letterSpace = font.space
        let heightOffset = 2 * font.scale

        let sprites = text.map { (char: Character) -> SKSpriteNode in
            return SKSpriteNode(id: .letter(String(char), color: color))
        }
        var first = true
        let size = sprites.reduce(CGSize.zero) { size, sprite in
            let width = size.width + sprite.size.width + (first ? 0 : letterSpace)
            let height = max(size.height, sprite.size.height - heightOffset)
            first = false
            return CGSize(width, height)
        } + CGSize(margins.left + margins.right, margins.top + margins.bottom)

        var x: CGFloat
        switch alignment {
            case .left:
                x = margins.left
            case .right:
                x = -size.width - margins.right
            default:
                x = -size.width / 2 + margins.left
        }
        for sprite in sprites {
            x += sprite.size.width / 2
            sprite.position.x = x
            sprite.position.y = -heightOffset / 2 - margins.top
            sprite.zPosition = zPosition
            textSprite << sprite
            x += sprite.size.width / 2 + letterSpace
        }

        self.textSize = size * textScale
        self.size = size * textScale
    }

}
