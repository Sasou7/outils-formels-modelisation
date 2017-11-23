import PetriKit

public class CoverabilityGraph {

    public init(
        marking: CoverabilityMarking, successors: [PTTransition: CoverabilityGraph] = [:])
    {
        self.marking    = marking
        self.successors = successors
    }

    public let marking   : CoverabilityMarking
    public var successors: [PTTransition: CoverabilityGraph]

    /// The number of nodes in the graph.
    public var count: Int {
<<<<<<< HEAD
        var seen: [CoverabilityGraph] = []
        var toCheck = [self]

        while let node = toCheck.popLast() {
            seen.append(node)
            for (_, successor) in node.successors {
                if !seen.contains(where: { $0 === successor }) {
=======
        var seen    = [self]
        var toCheck = [self]

        while let node = toCheck.popLast() {
            for (_, successor) in node.successors {
                if !seen.contains(where: { $0 === successor }) {
                    seen.append(successor)
>>>>>>> 2c3313f512f5b80773522eeb89bc8e8cbca58ef8
                    toCheck.append(successor)
                }
            }
        }

        return seen.count
    }

}

extension CoverabilityGraph: Sequence {

    public func makeIterator() -> AnyIterator<CoverabilityGraph> {
<<<<<<< HEAD
        var seen: [CoverabilityGraph] = []
=======
        var seen    = [self]
>>>>>>> 2c3313f512f5b80773522eeb89bc8e8cbca58ef8
        var toCheck = [self]

        return AnyIterator {
            guard let node = toCheck.popLast() else {
                return nil
            }

            let unvisited = node.successors.values.flatMap { successor in
                return seen.contains(where: { $0 === successor })
                    ? nil
                    : successor
            }

            seen.append(contentsOf: unvisited)
            toCheck.append(contentsOf: unvisited)

            return node
        }
    }

}
