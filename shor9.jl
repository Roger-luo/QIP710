using Yao

shor(Es...) = shor(chain(Es...))

shor(E) = chain(9,
    cnot(1, 4),
    cnot(1, 7),

    put(1=>H), put(4=>H), put(7=>H),

    cnot(1,2), cnot(1,3),
    cnot(4,5), cnot(4,6),
    cnot(7,8), cnot(7,9),
    # error
    E,

    cnot(1,3), cnot(1,2),
    cnot((2, 3), 1),

    cnot(4,6), cnot(4,5),
    cnot((5, 6), 4),

    cnot(7,9), cnot(7,8),
    cnot((8, 9), 7),

    put(1=>H), put(4=>H), put(7=>H),
    cnot(1, 7), cnot(1, 4), cnot((4, 7), 1)
    )

# assignment
# 1.a
@vars α β
r = α * ket"0" + β * ket"1" |> addbits!(8) |> shor(put(1=>Z)) |> partial_tr(1) |> expand
# output: α + β|00100100⟩
r = α * ket"0" + β * ket"1" |> addbits!(8) |> shor(put(2=>Z)) |> partial_tr(1) |> expand
# α + β|00100100⟩

# 1.c
r = α * ket"0" + β * ket"1" |> addbits!(8) |>
    shor(kron(1=>X, 2=>Z, 3=>Z, 4=>X, 5=>Z, 6=>Z, 7=>X, 8=>Z, 9=>Z)) |> partial_tr(2:9) |> expand
# output: α|0⟩ + β|1⟩
