import PetriKit

public extension PTNet {
<<<<<<< HEAD
    // Permet de changer un marquage pour le graphe de couverture en un marquage tirable
    public func convToPT(with marking : CoverabilityMarking, and p : [PTPlace]) -> PTMarking{
      var m : PTMarking = [:]

      for temp in p
      {
        let this = correctValue(to : marking[temp]!)!
        m[temp] = this
      }
      return m
    }

    //Permet de changer un marquage tirable en un marquage pour le graphe de couverture
    public func ptToConv(with marking: PTMarking, and p : [PTPlace]) ->CoverabilityMarking{
      var temp : CoverabilityMarking = [:]
      for val in p
      {
        temp[val] = .some(marking[val]!)
        if(500 < temp[val]!)
        {
          temp[val] = .omega
        }
      }
      return temp
    }

    //Corrige les erreurs qui compromettent le tirage
    public func correctValue(to t: Token) -> UInt? {
      if case .some(let value) = t {
        return value
      }
      else {
        return 1000
      }
    }

    // Vérfie la présence de noeud dans la liste
    public func verify(at marking : [CoverabilityMarking], to markingToAdd : CoverabilityMarking) -> Int
    {
      var value = 0
      for i in 0...marking.count-1
      {
        if (marking[i] == markingToAdd)
        {
          value = 1
        }
        if (markingToAdd > marking[i])
        {
          value = i+2}
      }
      return value
    }

    // Permet l'ajout de omega comme jeton si nécessaire
    public func convertOmega(from comp : CoverabilityMarking, with marking : CoverabilityMarking, and p : [PTPlace])  -> CoverabilityMarking?
    {
      var temp = marking
      for t in p
      {
        if (comp[t]! < temp[t]!)
        {
          temp[t] = .omega
        }
      }
      return temp
    }

    public func coverabilityGraph(from marking0: CoverabilityMarking) -> CoverabilityGraph? {
=======

    public func coverabilityGraph(from marking: CoverabilityMarking) -> CoverabilityGraph {
>>>>>>> 2c3313f512f5b80773522eeb89bc8e8cbca58ef8
        // Write here the implementation of the coverability graph generation.

        // Note that CoverabilityMarking implements both `==` and `>` operators, meaning that you
        // may write `M > N` (with M and N instances of CoverabilityMarking) to check whether `M`
        // is a greater marking than `N`.

        // IMPORTANT: Your function MUST return a valid instance of CoverabilityGraph! The optional
        // print debug information you'll write in that function will NOT be taken into account to
        // evaluate your homework.

<<<<<<< HEAD

        // Transformation en array des set des transitions et places
        var transitionsC = Array (transitions) // sort les valeurs de l'array
        transitionsC.sort{$0.name < $1.name}
        let placesC = Array(places)
        // Initialisation des valeurs
        var markingList : [CoverabilityMarking] = [marking0]
        var graphList : [CoverabilityGraph] = []
        var this: CoverabilityMarking
        let returnedGraph = CoverabilityGraph(marking: marking0, successors: [:])
        var count = 0
        // Boucle principale qui s'arrête quand count est supérieur à la taille de la liste des marquage
        while(count < markingList.count)
        {
          // Seconde boucle qui itère les transitions et créée les marquages du graphe de couverture
          for tran in transitionsC{
            // Transforme le marquage en quekque chose de tirable
            let ptMarking = convToPT(with: markingList[count], and: placesC)
            if let firedTran = tran.fire(from: ptMarking){
              // Reconvertit en marquage pour el graphe de couverture
              let convMarking = ptToConv(with: firedTran, and: placesC)
              // // Crée le noeud du marquage
              let nouvCouv = CoverabilityGraph(marking: convMarking, successors: [:])
              // Ajoute le nouvau noeud au successeur
              returnedGraph.successors[tran] = nouvCouv
            }
            // Si le successeur existe
            if(returnedGraph.successors[tran] != nil){
              // on ajoute son marquage à la variable this
              this = returnedGraph.successors[tran]!.marking
              // On vérifie si il est contenu dans la liste
              let cur = verify(at: markingList, to: this)
              if (cur != 1)
              {
                if (cur > 1)
                {
                  this = convertOmega(from : markingList[cur-2], with : this, and : placesC)!
                }
                 // On ajoute le noeud à la liste
                graphList.append(returnedGraph)
                // On ajoute son marquage à la seconde
                markingList.append(this)
              }
            }
          }
          count = count + 1
        }
        return returnedGraph
      }
=======
        return CoverabilityGraph(marking: marking)
    }

>>>>>>> 2c3313f512f5b80773522eeb89bc8e8cbca58ef8
}
