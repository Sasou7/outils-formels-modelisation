import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}

public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {
        // Write here the implementation of the marking graph generation.
        let transitions = self.transitions
        let markingInit = MarkingGraph(marking: marking)
        var markToVisit = [MarkingGraph]()
        var markVisited = [MarkingGraph]()

        markToVisit.append(markingInit)

        while markToVisit.count != 0 {
            let cur = markToVisit.removeFirst()
            markVisited.append(cur)
            transitions.forEach { trans in
              if let newMark = trans.fire(from: cur.marking) {
                        if let alreadyVisited = markVisited.first(where: { $0.marking == newMark }) {
                            cur.successors[trans] = alreadyVisited
                        } else {
                            let foundMark = MarkingGraph(marking: newMark)
                            cur.successors[trans] = foundMark
                            if (!markToVisit.contains(where: { $0.marking == foundMark.marking})) {
                                markToVisit.append(foundMark)
                            }
                    }
                }
            }
        }

        return markingInit
    }


    /*
      Soit un MarkingGraph, la méthode va retourner le nombre de noeud déjà visité du graph
    */
    public func count (mark: MarkingGraph) -> Int{
      var visited = [MarkingGraph]()
      var toVisit = [MarkingGraph]()

      toVisit.append(mark)
      while let cur = toVisit.popLast() {
        visited.append(cur)
        for(_, successor) in cur.successors{
          if !visited.contains(where: {$0 === successor}) && !toVisit.contains(where: {$0 === successor}){
              toVisit.append(successor)
            }
          }
      }

      return visited.count
    }

    /*
      Soit un MarkingGraph, la méthode va renvoyer true s'il existe un noeud où
      plus de 2 fumeurs fument au même moment
    */
    public func moreThanTwo (mark: MarkingGraph) -> Bool {
      var visited = [MarkingGraph]()
      var toVisit = [MarkingGraph]()

      toVisit.append(mark)
      while let cur = toVisit.popLast() {
        visited.append(cur)
        var nbSmokers = 0;
        for (key, value) in cur.marking {
            if (key.name == "s1" || key.name == "s2" || key.name == "s3"){
               nbSmokers += Int(value)
            }
        }
        if (nbSmokers > 1) {
          return true
        }
        for(_, successor) in cur.successors{
          if !visited.contains(where: {$0 === successor}) && !toVisit.contains(where: {$0 === successor}){
              toVisit.append(successor)
            }
          }
      }
      return false
    }
    /*
      Soit un MarkingGraph, la méthode va retourner true s'il existe un noeud où
      il y a plusieurs exemplaires d'un même objet sur la table
    */
    public func sameItem (mark: MarkingGraph) -> Bool {
      var visited = [MarkingGraph]()
      var toVisit = [MarkingGraph]()

      toVisit.append(mark)
      while let cur = toVisit.popLast() {
        visited.append(cur)
        for (key, value) in cur.marking {
            if (key.name == "p" || key.name == "t" || key.name == "m"){
               if(value > 1){
                 return true
               }
            }
        }
        for(_, successor) in cur.successors{
          if !visited.contains(where: {$0 === successor}) && !toVisit.contains(where: {$0 === successor}){
              toVisit.append(successor)
            }
          }
      }
      return false
    }

}
