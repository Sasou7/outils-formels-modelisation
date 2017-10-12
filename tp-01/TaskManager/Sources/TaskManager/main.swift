import TaskManagerLib


let taskManager = createTaskManager()

/*
Le problème ici est qu'il restera un jeton "bloqué"" dans inProgress et plus rien ne pourra être fait!
*/
let create = taskManager.transitions.filter{$0.name == "create"}[0]
let spawn = taskManager.transitions.filter{$0.name == "spawn"}[0]
let exec = taskManager.transitions.filter{$0.name == "exec"}[0]
let success = taskManager.transitions.filter{$0.name == "success"}[0]
let fail = taskManager.transitions.filter{$0.name == "fail"}[0]
let taskPool = taskManager.places.filter{$0.name == "taskPool"}[0]
let processPool = taskManager.places.filter{$0.name == "processPool"}[0]
let inProgress = taskManager.places.filter{$0.name == "inProgress"}[0]
let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
let m2 = spawn.fire(from: m1!)
let m3 = spawn.fire(from: m2!)
let m4 = exec.fire(from: m3!)
let m5 = exec.fire(from: m4!)
let m6 = success.fire(from: m5!)

print(m6!)
print("   ")//Je fais de l'espace entre les deux résultats, sinon cette ligne est totalement inutile..


let correctTaskManager = createCorrectTaskManager()

/*
Une correction de ce problème serait de rajouter une autre place que l'on appellera moderator qui comme
son nom l'indique va modérer le "trafic" pour faire en sorte qu'il ne reste aucun jeton bloqué
dans les places à la fin de l'opération
*/
let create1 = correctTaskManager.transitions.filter{$0.name == "create"}[0]
let spawn1 = correctTaskManager.transitions.filter{$0.name == "spawn"}[0]
let exec1 = correctTaskManager.transitions.filter{$0.name == "exec"}[0]
let success1 = correctTaskManager.transitions.filter{$0.name == "success"}[0]
let fail1 = correctTaskManager.transitions.filter{$0.name == "fail"}[0]
let taskPool1 = correctTaskManager.places.filter{$0.name == "taskPool"}[0]
let processPool1 = correctTaskManager.places.filter{$0.name == "processPool"}[0]
let inProgress1 = correctTaskManager.places.filter{$0.name == "inProgress"}[0]
let moderator = correctTaskManager.places.filter{$0.name == "moderator"}[0]
let n1 = create1.fire(from: [taskPool1: 0, processPool1: 0, inProgress1: 0, moderator: 0])
let n2 = spawn1.fire(from: n1!)
let n3 = spawn1.fire(from: n2!)
let n4 = exec1.fire(from: n3!)
let n5 = exec1.fire(from: n4!)
let n6 = success1.fire(from: n5!)
let n7 = fail1.fire(from: n6!)

print(n7!)
//une fois compilé on peut voir qu'il ne reste aucun jeton dans les place, il n'y a donc pas d'erreurs!
