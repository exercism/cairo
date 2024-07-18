type Domino = (u8, u8);

/// A table keeping track of available dominoes.
///
/// Effectively a 6x6 matrix represented as a dynamic array. Each position denotes whether a domino
/// is available with that column dots and row dots. Positions are mirrored ((3,4) == (4,3)), except
/// for positions with equal row and column numbers.
#[derive(Destruct)]
struct AvailabilityTable {
    d: Felt252Dict<u8>,
    len: usize
}

fn index(x: u8, y: u8) -> u8 {
    (x - 1) * 6 + (y - 1)
}

#[generate_trait]
impl AvailabilityTableImpl of AvailabilityTableTrait {
    fn new() -> AvailabilityTable {
        AvailabilityTable { d: Default::default(), len: 36 }
    }

    fn get(ref self: AvailabilityTable, x: u8, y: u8) -> u8 {
        let i = index(x, y);
        assert!(i.into() < self.len, "Index out of bounds");
        self.d.get(i.into())
    }

    fn set(ref self: AvailabilityTable, x: u8, y: u8, c: u8) {
        self.d.insert(index(x, y).into(), c);
    }

    fn add(ref self: AvailabilityTable, x: u8, y: u8) {
        let c = self.get(x, y);
        self.set(x, y, c + 1);
        if x != y { // Not the diagonal
            let c = self.get(y, x);
            self.set(y, x, c + 1);
        }
    }

    fn remove(ref self: AvailabilityTable, x: u8, y: u8) {
        // For this toy code hard explicit fail is best
        assert!(self.get(x, y) > 0, "no stones to remove: ({:?}, {:?})", x, y);

        let c = self.get(x, y);
        self.set(x, y, c - 1);
        if x != y { // Not the diagonal
            let c = self.get(y, x);
            self.set(y, x, c - 1);
        }
    }

    fn pop_first(ref self: AvailabilityTable, x: u8) -> Option<u8> {
        // the "double" has precedence, otherwise an invalid chain might occur
        if self.get(x, x) > 0 {
            self.remove(x, x);
            return Option::Some(x);
        }

        let mut y = 1;
        loop {
            if y == 7 {
                break Option::None;
            }
            if self.get(x, y) > 0 {
                self.remove(x, y);
                break Option::Some(y);
            }
            y += 1;
        }
    }
}

fn chain(dominoes: @Array<Domino>) -> Option<Array<Domino>> {
    match dominoes.len() {
        0 => Option::Some(array![]),
        1 => {
            let domino: Domino = *dominoes[0];
            let (x, y) = domino;
            if x == y {
                Option::Some(array![domino])
            } else {
                Option::None
            }
        },
        _ => {
            // First check if the total number of each amount of dots is even, if not it's not
            // possible to complete a cycle. This follows from that it's an Eulerian path.
            let mut d: Felt252Dict<u8> = Default::default();
            let mut i = 0;
            while i < dominoes
                .len() {
                    let (x, y): Domino = *dominoes[i];
                    d.insert(x.into(), d.get(x.into()) + 1);
                    d.insert(y.into(), d.get(y.into()) + 1);
                    i += 1;
                };
            let mut i = 0;
            let even_dot_types = loop {
                if i == 6 {
                    break true;
                }
                if d.get(i.into()) % 2 != 0 {
                    break false;
                }
                i += 1;
            };
            if !even_dot_types {
                return Option::None;
            }
            let chain = chain_worker(dominoes);
            if chain.len() == dominoes.len() {
                Option::Some(chain)
            } else {
                Option::None
            }
        }
    }
}

fn chain_worker(dominoes: @Array<Domino>) -> Array<Domino> {
    let mut t = AvailabilityTableTrait::new();
    let mut i = dominoes.len() - 1;
    let first = *dominoes[i];
    while i != 0 {
        i -= 1;
        let (x, y): Domino = *dominoes[i];
        t.add(x, y);
    };
    let mut chain: Array<Domino> = array![];
    chain.append(first);
    let (_, mut x) = first;
    while let Option::Some(y) = t.pop_first(x) {
        chain.append((x, y));
        x = y;
    };
    chain
}
