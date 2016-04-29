//
//  SpriteKit.swift
//  AllTriangles
//
//  Created by Colin Gray on 12/17/2015.
//  Copyright (c) 2015 AllTriangles. All rights reserved.
//

extension SKTexture {
    static func id(id: ImageIdentifier) -> SKTexture {
        let texture = SKTexture(image: Artist.generate(id))
        return texture
    }
}

extension SKSpriteNode {
    convenience init(id: ImageIdentifier, at position: CGPoint = .zero) {
        let texture = SKTexture.id(id)
        self.init(texture: texture)
        setScale(0.5)
        self.position = position
    }

    func textureId(id: ImageIdentifier) {
        if self.texture == nil {
            setScale(0.5)
        }
        let texture = SKTexture.id(id)
        self.texture = texture
        size = texture.size() * xScale
    }
}

extension SKNode {
    var z: Z {
        set { zPosition = newValue.rawValue }
        get { return Z(rawValue: zPosition) ?? Z.Default }
    }

    var visible: Bool {
        get {
            if let parent = parent where !parent.visible {
                return false
            }
            return !hidden && alpha > 0.1
        }
        set { hidden = !newValue }
    }

    static func size(size: CGSize) -> SKNode {
        return SKSpriteNode(texture: nil, size: size)
    }

    func isParentOf(child: SKNode) -> Bool {
        return child.inParentHierarchy(self)
    }

    func distanceTo(node: SKNode) -> CGFloat {
        return sqrt(roughDistanceTo(node))
    }

    func roughDistanceTo(node: SKNode) -> CGFloat {
        let world = (self as? Node)?.world ?? (node as? Node)?.world
        if let world = world where world.isParentOf(self) && world.isParentOf(node) {
            let posSelf = world.convertPosition(self)
            let posNode = world.convertPosition(node)
            return posSelf.roughDistanceTo(posNode)
        }
        let position = convertPosition(node)
        return position.roughLength
    }

    func distanceTo(node: SKNode, within radius: CGFloat) -> Bool {
        let world = (self as? Node)?.world ?? (node as? Node)?.world
        if let world = world where world.isParentOf(self) && world.isParentOf(node) {
            let posSelf = world.convertPosition(self)
            let posNode = world.convertPosition(node)
            return posSelf.distanceTo(posNode, within: radius)
        }
        let position = convertPosition(node)
        return position.lengthWithin(radius)
    }

    func angleTo(node: SKNode) -> CGFloat {
        let world = (self as? Node)?.world ?? (node as? Node)?.world
        if let world = world where world.isParentOf(self) && world.isParentOf(node) {
            let posSelf = world.convertPosition(self)
            let posNode = world.convertPosition(node)
            return (posNode - posSelf).angle
        }
        let position = convertPosition(node)
        return position.angle
    }

    func convertPosition(node: SKNode) -> CGPoint {
        if node.parent == nil || self.parent == nil {
            if self is World {
                return node.position
            }
            else if node is World {
                return -1 * self.position
            }
            else {
                return node.position - self.position
            }
        }
        else if node.parent == self.parent {
            return convertPoint(node.position, fromNode: node.parent!)
        }
        else {
            return convertPoint(.zero, fromNode: node)
        }
    }

}
