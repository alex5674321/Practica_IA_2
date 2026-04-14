(define (domain magabot_simple_order)
  (:requirements :adl :typing)

  (:types robot package shelf dispenser location)

  (:predicates
    (at ?x ?l - location)
    (adjacent ?l1 ?l2 - location)
    (wall ?l - location)
    (on ?p1 ?p2 - package)
    (on-shelf ?p - package ?s - shelf)
    (top ?p - package)
    (carrying ?r - robot ?p - package)
    (dispensed ?p - package)
    (next ?p1 ?p2 - package)
    (first ?p - package)
    (delivered ?p - package)
  )

  (:action move
    :parameters (?r - robot ?from ?to - location)
    :precondition (and (at ?r ?from) (adjacent ?from ?to) (not (wall ?to)))
    :effect (and
      (not (at ?r ?from))
      (at ?r ?to)
    )
  )



  (:action pick-with-under
    :parameters (?r - robot ?p - package ?q - package ?s - shelf ?lr ?ls - location)
    :precondition (and
      (at ?r ?lr)
      (at ?s ?ls)
      (adjacent ?lr ?ls)
      (on-shelf ?p ?s)
      (top ?p)
      (on ?p ?q)
    )
    :effect (and
      (carrying ?r ?p)
      (not (on-shelf ?p ?s))
      (not (top ?p))
      (not (on ?p ?q))
      (top ?q)
    )
  )

  (:action pick-alone
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

  ;; DISPENSAR CON ORDEN: primer paquete
  (:action dispense-first
    :parameters (?r - robot ?p - package ?lr ?ld - location ?d - dispenser)
    :precondition (and
      (at ?r ?lr)
      (at ?d ?ld)
      (adjacent ?lr ?ld)
      (carrying ?r ?p)
      (first ?p)
    )
    :effect (and
      (dispensed ?p)
      (delivered ?p)
      (not (carrying ?r ?p))
    )
  )

  ;; DISPENSAR CON ORDEN: siguiente paquete
  (:action dispense-next
    :parameters (?r - robot ?p - package ?prev - package ?lr ?ld - location ?d - dispenser)
    :precondition (and
      (at ?r ?lr)
      (at ?d ?ld)
      (adjacent ?lr ?ld)
      (carrying ?r ?p)
      (next ?prev ?p)
      (delivered ?prev)
    )
    :effect (and
      (dispensed ?p)
      (delivered ?p)
      (not (carrying ?r ?p))
    )
  )
)