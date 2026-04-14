(define (domain magabot_simple)
  (:requirements :adl :typing)

  (:types robot package shelf dispenser location)

  (:predicates
    (at ?x ?l - location) ; ubicación de robots, estanterías y dispensadores
    (adjacent ?l1 ?l2 - location) ; las ubicaciones ?l1 y ?l2 son adyacentes (bidireccional)
    (wall ?l - location) ; la ubicación ?l es una pared
    (on ?p1 ?p2 - package) ; el paquete ?p1 está sobre el paquete ?p2
    (on-shelf ?p - package ?s - shelf) ; el paquete ?p está en la estantería ?s
    (top ?p - package) ; el paquete ?p está en el top
    (carrying ?r - robot ?p - package) ; el robot ?r está llevando el paquete ?p
    (dispensed ?p - package) ; el paquete ?p ha sido dispensado
  )

  ;; mover
  (:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (at ?r ?from) (adjacent ?from ?to) (not (wall ?to)))
    :effect (and
      (not (at ?r ?from))
      (at ?r ?to)
    )
  )



  (:action pick
    :parameters (?r - robot ?p - package ?s - shelf ?lr ?ls - location)
    :precondition (and
      (at ?r ?lr)
      (at ?s ?ls)
      (adjacent ?lr ?ls)
      (on-shelf ?p ?s)
      (top ?p)
    )
    :effect (and
      (carrying ?r ?p)
      (not (on-shelf ?p ?s))
      (not (top ?p))
      (forall (?q - package) (when (on ?p ?q) (and (not (on ?p ?q)) (top ?q))))
    )
  )

  (:action drop-on
    :parameters (?r - robot ?p - package ?s - shelf ?lr ?ls - location ?q - package)
    :precondition (and
      (at ?r ?lr)
      (at ?s ?ls)
      (adjacent ?lr ?ls)
      (carrying ?r ?p)
      (on-shelf ?q ?s)
      (top ?q)
    )
    :effect (and
      (on-shelf ?p ?s)
      (top ?p)
      (not (carrying ?r ?p))
      (not (top ?q))
      (on ?p ?q)
    )
  )

  (:action drop-alone
    :parameters (?r - robot ?p - package ?s - shelf ?lr ?ls - location)
    :precondition (and
      (at ?r ?lr)
      (at ?s ?ls)
      (adjacent ?lr ?ls)
      (carrying ?r ?p)
    )
    :effect (and
      (on-shelf ?p ?s)
      (top ?p)
      (not (carrying ?r ?p))
    )
  )

  ;; dispensar
  (:action dispense
    :parameters (?r - robot ?p - package ?lr ?ld - location ?d - dispenser)
    :precondition (and
      (at ?r ?lr)
      (at ?d ?ld)
      (adjacent ?lr ?ld)
      (carrying ?r ?p)
    )
    :effect (and
      (dispensed ?p)
      (not (carrying ?r ?p))
    )
  )
)