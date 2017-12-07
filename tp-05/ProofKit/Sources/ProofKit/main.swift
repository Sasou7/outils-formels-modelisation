import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let c: Formula = "c"
let d: Formula = "d"

let f = (!a || b && c) && a
print("Test n°1:")
print("f  : \(f)")
print("nnf: \(f.nnf)")
print("cnf: \(f.cnf)")
print("dnf: \(f.dnf)")

//On va utiliser les exemples de la série 9 exercice 2
//J'écris à coté les réponses vu pendant la séance pour vérifier mes resultats
let g = !(a && (b || c))
print("\nTest n°2")
print("g  : \(g)")
print("nnf: \(g.nnf)")
print("cnf: \(g.cnf)")   //((!a || !b) && (!a || !c))
print("dnf: \(g.dnf)")  //((!a || !b)  || (!a || !c))

let h = (a => b) || !(a && c)
print("\nTest n°3")
print("h : \(h)")
print("nnf: \(h.nnf)")
print("cnf: \(h.cnf) ")         //(!a || b || !c)
print("dnf: \(h.dnf)")          //(!a || b || !c)

let i = (!a || b && c) && a
print("\nTest n°4")
print("i  : \(i)")
print("nnf: \(i.nnf)")
print("cnf: \(i.cnf)")      //(b && c && a)
print("dnf: \(i.dnf)")      //(b && c && a)




let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
