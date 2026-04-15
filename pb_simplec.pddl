(define (problem pb_simplec)
  (:domain magabot_simple_order)

  (:objects
    r1 r2 - robot
    pkg1 pkg2 pkg3 ground - package
    e1 e2 - shelf
    d - dispenser

    l11 l12 l13 l14 l15 l16
    l21 l22 l23 l24 l25 l26
    l31 l32 l33 l34 l35 l36
    l41 l42 l43 l44 l45 l46
    l51 l52 l53 l54 l55 l56
    l61 l62 l63 l64 l65 l66
    - location
  )

  (:init
    ;; posiciones robots
    (at r1 l61) ; (6,1)
    (at r2 l55) ; (5,5)

    ;; adyacencias bidireccionales (horizontal) 
    (adjacent l61 l62) (adjacent l62 l61)
    (adjacent l63 l64) (adjacent l64 l63)
    (adjacent l51 l52) (adjacent l52 l51)
    (adjacent l52 l53) (adjacent l53 l52)
    (adjacent l53 l54) (adjacent l54 l53)
    (adjacent l54 l55) (adjacent l55 l54)
    (adjacent l55 l56) (adjacent l56 l55)
    (adjacent l43 l44) (adjacent l44 l43)
    (adjacent l44 l45) (adjacent l45 l44)
    (adjacent l21 l22) (adjacent l22 l21)

    ;; adyacencias bidireccionales (vertical)
    (adjacent l61 l51) (adjacent l51 l61)
    (adjacent l51 l41) (adjacent l41 l51)
    (adjacent l41 l31) (adjacent l31 l41)
    (adjacent l31 l21) (adjacent l21 l31)
    (adjacent l52 l42) (adjacent l42 l52)
    (adjacent l42 l32) (adjacent l32 l42)
    (adjacent l32 l22) (adjacent l22 l32)
    (adjacent l53 l43) (adjacent l43 l53)
    (adjacent l43 l33) (adjacent l33 l43)
    (adjacent l54 l44) (adjacent l44 l54)
    (adjacent l55 l45) (adjacent l45 l55)
    (adjacent l45 l35) (adjacent l35 l45)
    (adjacent l35 l25) (adjacent l25 l35)
    (adjacent l56 l46) (adjacent l46 l56)

    ;; paredes: 16, 23, 24, 26, 32, 34, 36, 42, 46, 62, 64, 65
    (wall l16) (wall l23) (wall l24) (wall l26)
    (wall l32) (wall l34) (wall l36)
    (wall l42) (wall l46)
    (wall l62) (wall l64) (wall l65)

    ;; estantería E1: (2,2) l22, pkg2 abajo, pkg1 arriba
    (on pkg2 ground)
    (on pkg1 pkg2)
    (on-shelf pkg2 e1)
    (on-shelf pkg1 e1)
    (top pkg1)

    ;; estantería E2: (2,5) l25
    (on pkg3 ground)
    (on-shelf pkg3 e2)
    (top pkg3)

    ;; zonas especiales
    (at e1 l22)
    (at e2 l25)
    (at d l44) ; (4,4)

    ;; orden de dispensación: pkg2 => pkg3 (pkg1 no se dispensa)
    (first pkg2)
    (next pkg2 pkg3)
  )

  (:goal
    (and
      (dispensed pkg2)
      (dispensed pkg3)
    )
  )
)