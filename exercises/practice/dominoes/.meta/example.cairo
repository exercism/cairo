use core::dict::Felt252DictTrait;

type Domino = (u8, u8);

/// A table keeping track of available dominoes.
///
/// Effectively a 6x6 matrix. Each position denotes whether a domino is available with that column
/// dots and row dots. Positions are mirrored ((3,4) == (4,3)), except for positions with equal row
/// and column numbers.
#[derive(Destruct)]
struct AvailabilityTable {
    m: Felt252Dict<u8>,
    len: usize
}

#[generate_trait]
impl AvailabilityTableImpl of AvailabilityTableTrait {
    fn new() -> AvailabilityTable {
        AvailabilityTable { m: Default::default(), len: 36 }
    }

    fn get(ref self: AvailabilityTable, x: u8, y: u8) -> u8 {
        let index: u8 = (x - 1) * 6 + (y - 1);
        assert!(index.into() < self.len, "Index out of bounds");
        self.m.get(index.into())
    }

    fn set(ref self: AvailabilityTable, x: u8, y: u8, v: u8) {
        self.m.insert(((x - 1) * 6 + (y - 1)).into(), v);
    }

    fn add(ref self: AvailabilityTable, x: u8, y: u8) {
        if x == y {
            let n = self.get(x, y);
            self.set(x, y, n + 1) // Along the diagonal
        } else {
            let m = self.get(x, y);
            self.set(x, y, m + 1);
            let n = self.get(y, x);
            self.set(y, x, n + 1);
        }
    }

    fn remove(ref self: AvailabilityTable, x: u8, y: u8) {
        // For this toy code hard explicit fail is best
        assert!(self.get(x, y) > 0, "remove for 0 stones: ({:?}, {:?})", x, y);

        if x == y {
            let n = self.get(x, y);
            self.set(x, y, n - 1) // Along the diagonal
        } else {
            let m = self.get(x, y);
            self.set(x, y, m - 1);
            let n = self.get(y, x);
            self.set(y, x, n - 1);
        }
    }

    fn pop_first(ref self: AvailabilityTable, x: u8) -> Option<u8> {
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
            let mut v: Felt252Dict<u8> = Default::default();
            // Keep the mutable borrow in a small scope here to allow v.iter().
            let mut i = 0;
            while i < dominoes
                .len() {
                    let (x, y): Domino = *dominoes[i];
                    v.insert(x.into(), v.get(x.into()) + 1);
                    v.insert(y.into(), v.get(y.into()) + 1);
                    i += 1;
                };
            i = 0;
            let even_dot_types = loop {
                if i == 6 {
                    break true;
                }
                if v.get(i.into()) % 2 != 0 {
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
    let mut v: Array<Domino> = array![];
    v.append(first);
    let (_, mut n): Domino = first;
    while let Option::Some(m) = t.pop_first(n) {
        v.append((n, m));
        n = m;
    };
    v
}

#[cfg(test)]
mod tests;
